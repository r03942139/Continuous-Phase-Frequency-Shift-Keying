/*
 *  ======== emacHooks.c ========
 */

#include <stdio.h>
#include <stdint.h>

#include <netmain.h>

#ifdef BSL
#include <evmomapl138.h>
#include <evmomapl138_emac.h>

/* 
 * Define BSL if you want the MAC address to be read from SPI Flash.
 * For this you also need to make sure that a valid MAC address is written to SPI Flash using macwriter.pjt
 * supplied with BSL.  Enable this define only after witing MAC address to SPI flash using
 * macwriter.pjt present in BSL.
 */
#include <evmomapl138_spiflash.h>
#include <evmomapl138_i2c.h>
#include <evmomapl138_i2c_gpio.h>
#include <evmomapl138_gpio.h>
#include <evmomapl138_timer.h>
#endif 

/* GPIO Control and Timer Global Register */
#define GPIO_CONTROL_REG (*(volatile int*)0x01C20008)
#define TIMER_GLOBAL_REG (*(volatile int*)0x01C20024)

/* Macros to set and clear bits */
#define BITSET(dest,mask)     (dest |= mask)
#define BITCLR(dest,mask)     (dest &= ~mask)


/* MII pinmux */
#define PINMUX_MII_REG_0         (2)
#define PINMUX_MII_MASK_0        (0xFFFFFFF0)
#define PINMUX_MII_VAL_0         (0x88888880)
#define PINMUX_MII_REG_1         (3)
#define PINMUX_MII_MASK_1        (0xFFFFFFFF)
#define PINMUX_MII_VAL_1         (0x88888888)

/* MDIO pinmux */
#define PINMUX_MDIO_REG          (4)
#define PINMUX_MDIO_MASK         (0x000000FF)
#define PINMUX_MDIO_VAL          (0x00000088)

/* GPIO pinmux */
#define PINMUX_MII_MDIO_EN_REG	 (6)
#define PINMUX_MII_MDIO_EN_MASK	 (0x000000F0)
#define PINMUX_MII_MDIO_EN_VAL	 (0x00000080)

/* MDIO phy access functions */
uint MDIO_phyRegWrite( uint phyIdx, uint phyReg, short data );

/* This string array corresponds to link state as defined in csl_mdio.h */
static char *LinkStr[] = { "No Link",
                           "10Mb/s Half Duplex",
                           "10Mb/s Full Duplex",
                           "100Mb/s Half Duplex",
                           "100Mb/s Full Duplex"};
                           
/* Sysconfig registers */
typedef struct
{
   volatile uint32_t REVID;            // 0x0000
   volatile uint32_t RSVD0;            // 0x0004
   volatile uint32_t DIEIDR[4];        // 0x0008
   volatile uint32_t RSVD1[2];         // 0x0018
   volatile uint32_t BOOTCFG;          // 0x0020
   volatile uint32_t RSVD2[5];         // 0x0024
   volatile uint32_t KICKR[2];         // 0x0038
   volatile uint32_t HOST0CFG;         // 0x0040
   volatile uint32_t HOST1CFG;         // 0x0044
   volatile uint32_t RSVD3[38];        // 0x0048
   volatile uint32_t IRAWSTAT;         // 0x00E0
   volatile uint32_t IENSTAT;          // 0x00E4
   volatile uint32_t IENSET;           // 0x00E8
   volatile uint32_t IENCLR;           // 0x00EC
   volatile uint32_t EOI;              // 0x00F0
   volatile uint32_t FLTADDRR;         // 0x00F4
   volatile uint32_t FLTSTAT;          // 0x00F8
   volatile uint32_t RSVD4[5];         // 0x00FC
   volatile uint32_t MSTPRI[3];        // 0x0110
   volatile uint32_t RSVD5;            // 0x011C
   volatile uint32_t PINMUX[20];       // 0x0120
   volatile uint32_t SUSPSRC;          // 0x0170
   volatile uint32_t CHIPSIG;          // 0x0174
   volatile uint32_t CHIPSIG_CLR;      // 0x0178
   volatile uint32_t CFGCHIP[5];       // 0x017C
} sys_config_regs_t;

#define SYSCONFIG_REG_BASE (0x01C14000)
#define SYSCONFIG          ((sys_config_regs_t *)SYSCONFIG_REG_BASE)

/* unlock/lock kick registers defines */
#define KICK0R_UNLOCK      (0x83E70B13)
#define KICK1R_UNLOCK      (0x95A4F1E0)
#define KICK0R_LOCK        (0x00000000)
#define KICK1R_LOCK        (0x00000000)

static UINT8 bMacAddr[8]= { 0x00, 0x08, 0xee, 0x03, 0x14, 0x99 }; 

/*
 *  ======== pinmuxConfig ========
 */
void pinmuxConfig(uint32_t in_reg, uint32_t in_mask, uint32_t in_val)
{
   /*
    * make sure the pinmux register is cleared for the mask bits before
    * setting the value.
    */
   BITCLR(SYSCONFIG->PINMUX[in_reg], in_mask);
   BITSET(SYSCONFIG->PINMUX[in_reg], in_val);
}

/*
 *  ======== EMAC_initialize ========
 */
void EMAC_initialize()
{
    /* configure the GPIO control and timer global registers */
    GPIO_CONTROL_REG = 0x00000000;
    TIMER_GLOBAL_REG = 0x00000007;

    /* unlock the system config registers. */   
    SYSCONFIG->KICKR[0] = KICK0R_UNLOCK;
    SYSCONFIG->KICKR[1] = KICK1R_UNLOCK;
    
    /* pinmux configuration */
	pinmuxConfig(PINMUX_MDIO_REG, PINMUX_MDIO_MASK, PINMUX_MDIO_VAL); 					  //MDIO shared by both RMII and MII
    pinmuxConfig(PINMUX_MII_MDIO_EN_REG, PINMUX_MII_MDIO_EN_MASK, PINMUX_MII_MDIO_EN_VAL); //pinmux to select gpio bank2 pin6 
    pinmuxConfig(PINMUX_MII_REG_0, PINMUX_MII_MASK_0, PINMUX_MII_VAL_0);
    pinmuxConfig(PINMUX_MII_REG_1, PINMUX_MII_MASK_1, PINMUX_MII_VAL_1);
      
    BITCLR(SYSCONFIG->CFGCHIP[3], 0x00000100);
}

/*
 *  ======== EMAC_getConfig ========
 *
 * This is a callback from the Ethernet driver. This function
 * is used by the driver to get its 6 byte MAC address, and
 * to determine which DSP interrupt the EMAC should be mapped to.
 */
void EMAC_getConfig( UINT8 *pMacAddr)
{
#ifdef BSL
    int retval;  
    static UINT8 readMacAddr[8]  
    
    retval= SPIFLASH_readMACAddr(readMacAddr);
    if (retval == 0)) {
        printf("Using MAC Address: %02x-%02x-%02x-%02x-%02x-%02x\n",
            readMacAddr[0], readMacAddr[1], readMacAddr[2],
            readMacAddr[3], readMacAddr[4], readMacAddr[5]);
		mmCopy( pMacAddr, readMacAddr, 6 );
    }
    else {
        printf("Using default MAC address\n");
        printf("Using MAC Address: %02x-%02x-%02x-%02x-%02x-%02x\n",
            bMacAddr[0], bMacAddr[1], bMacAddr[2],
            bMacAddr[3], bMacAddr[4], bMacAddr[5]);
		mmCopy( pMacAddr, bMacAddr, 6 );
    }
#else
    printf("Using default MAC address\n");
    printf("Using MAC Address: %02x-%02x-%02x-%02x-%02x-%02x\n",
            bMacAddr[0], bMacAddr[1], bMacAddr[2],
            bMacAddr[3], bMacAddr[4], bMacAddr[5]);
			 mmCopy( pMacAddr, bMacAddr, 6 );
#endif
}

/*
 * ======== EMAC_linkStatus ========
 *
 * This is a callback from the Ethernet driver. This function
 * is called whenever there is a change in link state. The
 * current PHY and current link state are passed as parameters.
 */
void EMAC_linkStatus( uint phy, uint linkStatus )
{
    printf("Link Status: %s on PHY %d\n",LinkStr[linkStatus],phy);

#if  0
    /* <TODO> Add the write function call to program LEDs for Micrel */
     
    // Program the LEDs for the Micrel PHY 
    MDIO_phyRegWrite( phy, 0x14, 0xd5d0 );
#endif
}

