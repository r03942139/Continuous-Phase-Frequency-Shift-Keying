#include	<stdio.h>
#include	<stdlib.h>
#include	<math.h>
#include	<log.h>
#include	<mem.h>
#include	 <time.h>
#include	<hw_dspcache.h>
#include 	<soc_OMAPL138.h>
#include	"ADC.h"
#include 	"dsplib.h"
#include	"float2bit.h"
#include	"bit2float.h"
#define     PI 3.1415926
#define 	M 4
#define  	d 5
#define		size 100/2
#define	    TX_blk 2    // unit is k(1024)
#define	    RX_blk 1


unsigned int	F_SetTxBlkGp(volatile unsigned short *dspTxPtr, unsigned short blk_cnt);
unsigned int	F_SetRxBlkGp(volatile unsigned short *dspRxPtr, unsigned short blk_cnt);
unsigned int	F_TxDmaDone(void);
unsigned int	F_RxDmaDone(void);
unsigned int	RX2_GET_ID(void);
unsigned int	RX2_PUT_ID(void);
unsigned int	TX1_GET_ID(void);
unsigned int	TX1_PUT_ID(void);

unsigned short	DspTxData[TX_blk*1024];
unsigned short	Data[TX_blk*1024];
unsigned short	DspRxData[RX_blk*1024];
unsigned short  DspRxData_TMP1[8][RX_blk*1024];

/* Global variable */
int bit_num_ad=10,bit_num_da=12;
float af=0.3;
float fix[((size+16*5+32)*M+2*d*M+1)*2],sig[TX_blk*1024];
void SRRC(float,int,int);
float short_preamble[32]={-1,1,-1,1,1,-1,-1,1,-1,1,-1,1,1,-1,1,-1,-1,1,-1,-1,1,-1,1,1,1,1,-1,-1,1,-1,1,-1};
float long_preamble_real[32]={1,1,1,-1,-1,1,1,1,-1,-1,1,-1,-1,1,-1,-1,1,-1,1,-1,1,1,-1,-1,1,-1,-1,-1,1,1,1,-1};
float long_preamble_imag[32]={-1,-1,1,-1,1,-1,1,-1,1,1,-1,1,-1,1,1,1,-1,-1,-1,-1,1,1,-1,1,-1,1,1,-1,1,-1,1,-1};
float real[size];
float imag[size];
float real_data[size+16*5+32];
float imag_data[size+16*5+32];
float upsample_real[(size+16*5+32)*M];
float upsample_imag[(size+16*5+32)*M];
float srrc[2*M*d+1];
float srrctmp[2*M*d+2];
float pulseshape_real[(size+16*5+32)*M+2*d*M+1];
float pulseshape_imag[(size+16*5+32)*M+2*d*M+1];
float realtmp[(size+16*5+32)*M+4*d*M+2];
float imagtmp[(size+16*5+32)*M+4*d*M+2];
float phasereal[size];
//float phaseimag[size];

const float Tb = 5.0;
const float fb = 0.05;
//  const float sq = 0.1;  // 1 / 2Tb
float s[size];

void system_run(float *seq[size*2])
{
	int i,j,test,iter;	
    for(i=0;i<TX_blk*1024;i++)
    {
  		 DspTxData[i] = 0;
    }

    	/* Mapping */
	for(i=0;i<10;i++)       // 10 data   //s(t)
	{
         if(*seq[i]==0)
         {
	            s[5*i]= -0.1; s[5*i+1] = -0.1; s[5*i+2]=-0.1;s[5*i+3]=-0.1;s[5*i+4]=-0.1;
	     }
	     else if(*seq[i]==1)
         {
	            s[5*i]= 0.1;; s[5*i+1] = 0.1; s[5*i+2]=0.1;s[5*i+3]=0.1;s[5*i+4]=0.1;
	     }
    }
    phasereal[0] =  3.1415926*s[0] ;          //phi(1) =  4*pi*Tb*fd*g(1);
    for(i=1;i<size;i++)
	{
         phasereal[i] = phasereal[i-1] + 3.1415926*s[i];
         if(phasereal[i]>3.1415926) phasereal[i] -= 2*3.1415926;
         else if((phasereal[i]<-3.1415926)) phasereal[i] += 2*3.1415926;
    }
	for(i=0;i<size;i++)            //CPFSK  50
	{
         real[i] = cos(phasereal[i]);
         imag[i] = sin(phasereal[i]);
    }
    	/* Add preamble */
    	for(i=0;i<size+16*5+32;i++)
    	{
    		if(i<16*5)
    		{
    			real_data[i] = short_preamble[(2*i)%32];
    			imag_data[i] = short_preamble[(2*i+1)%32];
    		}
    		else if(i >= 16*5 && i<16*5+32)
    		{
    			real_data[i] = long_preamble_real[i-16*5];
    			imag_data[i] = long_preamble_imag[i-16*5];
    		}
    		else
    		{
    			real_data[i] = real[i-16*5-32];
    			imag_data[i] = imag[i-16*5-32];
    		}

    	}

    	/* Up-sample  */
    	for(i=0;i<(size+16*5+32)*M;i++)
    	{
    		if (i%M==0)
    		{
    			upsample_real[i] = real_data[i/M];
    			upsample_imag[i] = imag_data[i/M];
    		}
    		else
    		{
    			upsample_real[i] = 0;
    			upsample_imag[i] = 0;
    		}
    	}

    	/*  Insert zero to input sequence  */
    	// 左右各補2*d*M+1個0,因為SRRC長度為2*d*M+2
    	j=0;
    	for(i=0;i<(size+16*5+32)*M+4*d*M+2;i++)
    	{
    		if(i<=2*M*d || i>=(size+16*5+32)*M+2*d*M+1)
    		{
    			realtmp[i] = 0;
    			imagtmp[i] = 0;
    		}
    		else
    		{
    			realtmp[i] = upsample_real[j];
    			imagtmp[i] = upsample_imag[j];
    			j++;
    		}
    	}

    	/* SRRC  */
    	SRRC(af,M,d);

    	/* Add one zero at the end of SRRC , in order to let the length of SRRC is even */
    	for(i=0;i<2*d*M+1;i++)
    	{
    		srrctmp[i] = srrc[i];
        }
    	srrctmp[2*d*M+1] = 0;


    	/* pulse shaping */
    	DSPF_sp_convol(realtmp,srrctmp,pulseshape_real,2*d*M+2,(size+16*5+32)*M+2*d*M+1);
    	DSPF_sp_convol(imagtmp,srrctmp,pulseshape_imag,2*d*M+2,(size+16*5+32)*M+2*d*M+1);

    	for(i=0;i<(size+16*5+32)*M+2*d*M+1;i++)
    	{
    		fix[2*i] = ADC(0.3*pulseshape_real[i],bit_num_ad,2);
    		fix[2*i+1] = ADC(0.3*pulseshape_imag[i],bit_num_ad,2);
    	}


    	for(i=0;i<(TX_blk*1024)/2;i++)
    	{
    		 if(i<(size+16*5+32)*M+2*d*M+1)
    		 {
    			 sig[2*i]=fix[2*i];
    			 sig[2*i+1]=fix[2*i+1];
    		 }
    		 else
    		 {
    			 sig[2*i]=1;
    			 sig[2*i+1]=1;
    		 }
    	}

    	///// transfer floating number to bits sequence

    	// 用10個bits做fixed point,所以用short的型態來存(16bits)
    	for(i=0;i<TX_blk*1024;i++)
    	{
    	   Data[i] = float2bit(sig[i],bit_num_ad,1);
    	}

    	for(i=0;i<TX_blk*1024;i++)
    	{
    		DspTxData[i] = Data[i];
    	}

    	for(i=0;i<1;i++)
    	{
    	    test=F_SetTxBlkGp( (volatile unsigned short *) DspTxData, TX_blk);
    		while (F_TxDmaDone()!= 1) {}		
    	}      

}

/* SRRC */
void SRRC(float af,int MM,int dd)
{
	int i;
    float n,temp,max=0,den;
    for(i=0;i<=2*dd*MM;i++)
    {
        n = i - (float)dd*(float)MM + 0.0000001;
        srrc[i] = cos((1+af)*PI*n/(float)MM)+(float)MM*sin((1-af)*PI*n/(float)MM)/af/4/n;
        den = 1-(4*af*n/(float)MM)*(4*af*n/(float)MM);
        srrc[i] = srrc[i]/den;
    }
    for(i=0;i<=2*dd*MM;i++)
    {
        temp = srrc[i];
        if(temp>max)
           max = temp;
    }
    for(i=0;i<=2*dd*MM;i++)
    {
        srrc[i]=srrc[i]/max;
    }
}
