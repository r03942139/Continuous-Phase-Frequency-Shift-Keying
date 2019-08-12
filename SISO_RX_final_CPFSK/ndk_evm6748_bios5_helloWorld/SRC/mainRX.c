#include	 <stdio.h>
#include	 <stdlib.h>
#include	 <netmain.h>
#include	 <math.h>
#include	 <_stack.h>
#include 	 <std.h>
#include 	 <tsk.h>

#include	<log.h>			//(S0305)
#include	<mem.h>			// (S0305)
#include	<hw_dspcache.h>			// (S0305)
#include 	<soc_OMAPL138.h>



#include	"ADC.h"
#include 	"dsplib.h"
#include	 "float2bit.h"
#include 	"transform.h"

#define     PI 3.1415926
#define	    RX_blk 8   // unit is k(1024)
#define     N 4096
#define	    D 64   // short preamble length * upsample factor
#define 	M 4
#define  	d 5
#define		size 100/2

char *UnicastAddr = "192.168.0.40";	// PC address

//----{ (S0225)
void	F_StartEMIFA(void);
unsigned int	F_SetTxBlkGp(volatile unsigned short *dspTxPtr, unsigned short blk_cnt);
unsigned int	F_SetRxBlkGp(volatile unsigned short *dspRxPtr, unsigned short blk_cnt);
unsigned int	F_TxDmaDone(void);
unsigned int	F_RxDmaDone(void);
unsigned int	RX2_GET_ID(void);
unsigned int	RX2_PUT_ID(void);
unsigned int	TX1_GET_ID(void);
unsigned int	TX1_PUT_ID(void);
void	F_FlushEMIFA(void);	//----(S1129)
// void	F_ChkDbgBuffer(void);	//---- if need, EMIFA can be readback by non-DMA mode for check
//----}

extern 	unsigned	int				V_TxDmaDone, V_RxDmaDone;

union mydata recv_char[1];
union mydata send_char[size*2];
static  unsigned	short	DspRxData[RX_blk*1024];
int Data[RX_blk*1024];
int real_DC,imag_DC;
float defloat_real[2048/2];
float defloat_imag[2048/2];
float after_defloat_real[2048/2];
float after_defloat_imag[2048/2];
float defloat_real3[size];
float defloat_imag3[size];
float sync_data_real[(32+size)*M];
float sync_data_imag[(32+size)*M];
float output[10];
float symb[448]={0};

float recv_preamble_real[32];
float recv_preamble_imag[32];
float cfo_real=0.0;
float cfo_imag=0.0;
float omega=0.0,cfo_est=0.0;
float temp_a=0.0,temp_b=0.0;

void SRRC(float,int,int);
float bit2float(unsigned short,int,float);
float srrc[2*M*d+1];
float srrctmp[2*M*d+2];
float zero_real[(32+size)*M+4*d*M+2];
float zero_imag[(32+size)*M+4*d*M+2];
float zero_real_pre[32*M+4*d*M+2];
float zero_imag_pre[32*M+4*d*M+2];
float depulseshape_real[(32+size)*M+2*d*M+1];
float depulseshape_imag[(32+size)*M+2*d*M+1];
float downsample_real[32+size];
float downsample_imag[32+size];
float catch_defloat_real[size*M];
float catch_defloat_imag[size*M];
float catch_downsample_real[size];
float catch_downsample_imag[size];
float noreal[2048/2-60*M];
float noimag[2048/2-60*M];
float no[2048/2-60*M];
int demod[10];
int out_data[2*size],fail_cnt=1;


/* Global variable */
int i,j,n;
int leave_flag=0,time_out=0;
int bit_num_ad=10,bit_num_da=12;
int phase,flag=0,package_point=0;
int packet_position = 0;
int peak_flag = 0, peak_position[4] = {0}, data_position = 0;
float peak=0,sym_peak=0,power=0,auto_real=0,auto_imag=0;
float symb_real=0,symb_imag=0;
float arctan=0,cfo_w;
float f=1,fc=128;
float af=0.3;
float h_real=0,h_imag=0;
float fix[RX_blk*1024],sig[RX_blk*1024];
float long_preamble_real[32]={1,1,1,-1,-1,1,1,1,-1,-1,1,-1,-1,1,-1,-1,1,-1,1,-1,1,1,-1,-1,1,-1,-1,-1,1,1,1,-1};
float long_preamble_imag[32]={-1,-1,1,-1,1,-1,1,-1,1,1,-1,1,-1,1,1,1,-1,-1,-1,-1,1,1,-1,1,-1,1,1,-1,1,-1,1,-1};
float long_preamble_real_up[32*M];
float long_preamble_imag_up[32*M];
float long_preamble_real_srrc[32*M+2*d*M+1];
float long_preamble_imag_srrc[32*M+2*d*M+1];
float creal;
float cimag;
float angle;
float e;
float max;
float takephase[size];
float checkphase[size];
int number;
int done_cnt=1,detect_cnt=1,test,over_lap_cnt=0;
void SRRC(float,int,int);


#define		_DEBUG_EMIFA
volatile unsigned short *tmpPtr;
volatile unsigned short *NewTxBuff;
volatile unsigned short *NewRxBuff;


void udp_test()
{
//========================================================================================
    SOCKET   send = INVALID_SOCKET;     // Sender socket. 
    SOCKET   recv = INVALID_SOCKET;     // Sender socket.
    struct   sockaddr_in rec;           // Sender socket address structure
    struct   sockaddr_in to;           // Sender socket address structure
    int sentCnt = 0;
    int sentCnt2 = 0;
    int sz = sizeof(rec);

    // Allocate the file environment for this task
    fdOpenSession( TaskSelf() );

    // Create the receive socket
    recv = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
    if( recv == INVALID_SOCKET )
    	leave_flag=1;

    // Receive socket: set Port = 100, IP destination address = ANY
    bzero( &rec, sizeof(struct sockaddr_in) );
    rec.sin_family = AF_INET;
    rec.sin_len    = sizeof( rec );
    rec.sin_port   = htons(100);
    
    // Bind send socket
    if ( bind( recv, (PSA) &rec, sizeof(rec) ) < 0 )
    {
        printf("Send: %d",fdError());
        leave_flag=1 ;
    }
    rec.sin_addr.s_addr = inet_addr(UnicastAddr);
    
    // Create the send socket
	send = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
	if( send == INVALID_SOCKET )
		leave_flag=1;
	
	// Send socket: set Port = 5000, IP destination address = ANY
	bzero( &to, sizeof(struct sockaddr_in) );
	to.sin_family = AF_INET;
	to.sin_len    = sizeof(to);
	to.sin_port   = htons(5000);
	to.sin_addr.s_addr = inet_addr(UnicastAddr); // PC address is the destination

	if(leave_flag==1)
	{
		    // We only get here on a fatal error - close the sockets
		    if( send != INVALID_SOCKET )
		        fdClose( send );

		    printf("Fatal Error\n");

		    // This task is killed by the system - here, we block
		    TaskBlock( TaskSelf() );
	}

#ifdef	_DEBUG_EMIFA
	F_StartEMIFA();			//(S0225) init here

#endif
//========================================================================================

	//Initial
	for(j=0;j<RX_blk*1024;j++)
    {
	    DspRxData[j]=0;
	    Data[j]=0;
    }
	for(j=0;j<1024;j++)
	{
		defloat_real[j]=0.0;
		defloat_imag[j]=0.0;
	}
	for(j=0;j<size;j++)
	{
		defloat_real3[j]=0.0;
		defloat_imag3[j]=0.0;
	}
	for(j=0;j<(32+size)*M;j++)
	{
		sync_data_real[j]=0.0;
		sync_data_imag[j]=0.0;
	}
    for(j=0;j<32;j++)
    {
    	recv_preamble_real[j]=0.0;
    	recv_preamble_imag[j]=0.0;
    }
    for(j=0;j<(32+size)*M+4*d*M+2;j++)
    {
    	zero_real[j]=0.0;
    	zero_imag[j]=0.0;
    }
    for(j=0;j<(32+size)*M+2*d*M+1;j++)
    {
    	depulseshape_real[j]=0.0;
    	depulseshape_imag[j]=0.0;
    }
    for(j=0;j<32+size;j++)
    {
    	downsample_real[j]=0.0;
    	downsample_imag[j]=0.0;
    }
	for(j=0;j<2*size;j++)
	{
		output[j]=0.0;
		out_data[j]=0;
	}
    for(j=0;j<448;j++)
	    symb[j]=0.0;
    for(j=0;j<2*M*d+1;j++)
        srrc[j]=0.0;
    for(j=0;j<2*M*d+2;j++)
        srrctmp[j]=0.0;
    for(j=0;j<2*(size+4*d+(int)2/M);j++)
        demod[j]=0;

    SRRC(af,M,d);
    for(i=0;i<2*d*M+1;i++)
        srrctmp[i] = srrc[i];
        srrctmp[2*d*M+1] = 0;

    for(i=0;i<32*M;i++)
    {
        if(i%M==0)
        {
        	long_preamble_real_up[i]=long_preamble_real[i/4];
        	long_preamble_imag_up[i]=long_preamble_imag[i/4];
        }
        else
        {
        	long_preamble_real_up[i]=0;
        	long_preamble_imag_up[i]=0;
        }
    }

    
    j=0;
    for(i=0;i<32*M+4*d*M+2;i++)
    {
       	if(i<=2*M*d || i>=32*M+2*d*M+1)
       	{
       	    zero_real_pre[i]=0;
       		zero_imag_pre[i]=0;
       	}
       	else
        {
       	    zero_real_pre[i]=long_preamble_real_up[j];
       		zero_imag_pre[i]=long_preamble_imag_up[j];
       	    j++;
       	}
    }

    DSPF_sp_convol(zero_real_pre,srrctmp,long_preamble_real_srrc,2*d*M+2,32*M+2*d*M+1);
    DSPF_sp_convol(zero_imag_pre,srrctmp,long_preamble_imag_srrc,2*d*M+2,32*M+2*d*M+1);

    j=0;
    for(i=0;i<32*M+2*d*M+1;i++)
    {
        if(i<d*M+1 || i>=32*M+d*M)
        {

        }
        else
        {
        	long_preamble_real_up[j] = long_preamble_real_srrc[i];
            long_preamble_imag_up[j] = long_preamble_imag_srrc[i];
            j++;
        }
    }
    //end
    
    //Start (trigger by MATLAB)
	do
	{
		sentCnt = recvfrom( recv, &recv_char[0].char_val[0], 4, 0, (struct sockaddr*)&rec, &sz );
	} while (sentCnt < 0);


	printf("Start!\n");

	for(;;)
    {
	
        //Packet detection
    	while(1)
    	{
    		test=F_SetRxBlkGp( (volatile unsigned short *) DspRxData, RX_blk);
    		while (F_RxDmaDone()!= 1) {}

			auto_real=0;auto_imag=0;power=0;flag=0;peak=0;real_DC=0;imag_DC=0,over_lap_cnt=0;

			real_DC=2048;
			imag_DC=2048;

			for(i=0;i<RX_blk*1024/2-1024;i=i+1)//256=>1024
			{
				if(fabs(((int)DspRxData[2*i])-real_DC) > 100 && fabs(((int)DspRxData[2*i+1])-imag_DC) > 100)
				{

					if(flag == 0)
					{
						auto_real = auto_real + ( (((int)DspRxData[2*i])-real_DC)*(((int)DspRxData[2*i+D*2])-real_DC)+(((int)DspRxData[2*i+1])-imag_DC)*(((int)DspRxData[2*i+1+D*2])-imag_DC) );
						auto_imag = auto_imag + ( (((int)DspRxData[2*i+1])-imag_DC)*(((int)DspRxData[2*i+D*2])-real_DC)-(((int)DspRxData[2*i])-real_DC)*(((int)DspRxData[2*i+1+D*2])-imag_DC) );
						power = power + (((int)DspRxData[2*i+D*2])-real_DC) * (((int)DspRxData[2*i+D*2])-real_DC) + (((int)DspRxData[2*i+1+D*2])-imag_DC) * (((int)DspRxData[2*i+1+D*2])-imag_DC);
                        over_lap_cnt=over_lap_cnt+1;
						if(over_lap_cnt>=63)
						{
							flag=1;
						}
					}
					else
					{
						auto_real = auto_real - ( (((int)DspRxData[2*(i-64)])-real_DC)*(((int)DspRxData[2*(i-64)+D*2])-real_DC)+(((int)DspRxData[2*(i-64)+1])-imag_DC)*(((int)DspRxData[2*(i-64)+1+D*2])-imag_DC) ) + ( (((int)DspRxData[2*(i-64)+D*2])-real_DC)*(((int)DspRxData[2*(i-64)+2*D*2])-real_DC)+(((int)DspRxData[2*(i-64)+1+D*2])-imag_DC)*(((int)DspRxData[2*(i-64)+1+2*D*2])-imag_DC) );
						auto_imag = auto_imag - ( (((int)DspRxData[2*(i-64)+1])-imag_DC)*(((int)DspRxData[2*(i-64)+D*2])-real_DC)-(((int)DspRxData[2*(i-64)])-real_DC)*(((int)DspRxData[2*(i-64)+1+D*2])-imag_DC) ) + ( (((int)DspRxData[2*(i-64)+1+D*2])-imag_DC)*(((int)DspRxData[2*(i-64)+2*D*2])-real_DC)-(((int)DspRxData[2*(i-64)+D*2])-real_DC)*(((int)DspRxData[2*(i-64)+1+2*D*2])-imag_DC) );
						power = power - ( (((int)DspRxData[2*(i-64)+D*2])-real_DC)*(((int)DspRxData[2*(i-64)+D*2])-real_DC)+(((int)DspRxData[2*(i-64)+1+D*2])-imag_DC)*(((int)DspRxData[2*(i-64)+1+D*2])-imag_DC) ) + ( (((int)DspRxData[2*(i-64)+2*D*2])-real_DC)*(((int)DspRxData[2*(i-64)+2*D*2])-real_DC)+(((int)DspRxData[2*(i-64)+1+2*D*2])-imag_DC)*(((int)DspRxData[2*(i-64)+1+2*D*2])-imag_DC) );
					}
					if(flag==1)
					{
					    peak = (auto_real * auto_real + auto_imag * auto_imag)/(power * power);
					}
					if(peak > 0.9)
					{
						packet_position = i;
						break;
					}
				}
			}
			if(peak > 0.9)
				break;
    	}
        //end

        
        //pick the packet
    	for(i=packet_position;i<packet_position+2048/2;i++)
    	{
    	    defloat_real[i-packet_position] = bit2float(DspRxData[2*i],bit_num_da,1);
    	    defloat_imag[i-packet_position] = bit2float(DspRxData[2*i+1],bit_num_da,1);
    	}
        //end


        //use short preamble to do cfo estimation
        creal = 0;
        cimag = 0;
        for(i=0;i<16*M;i++)
        {
           creal = creal+(defloat_real[i]*defloat_real[i+16*M]+defloat_imag[i]*defloat_imag[i+16*M]);
           cimag = cimag+(defloat_imag[i]*defloat_real[i+16*M]-defloat_real[i]*defloat_imag[i+16*M]);
        }
        if(cimag<0&&creal<0)
        {
           angle = atan(cimag/creal)-PI;
        }
        else if(cimag>0&&creal<0)
        {
           angle = atan(cimag/creal)+PI;
        }
        else
        {
           angle = atan(cimag/creal);
        }
        e = -1*angle/(16*M);
        for(i=0;i<2048/2;i++)
        {
           after_defloat_real[i] = defloat_real[i]*cos(-1*e*i) - defloat_imag[i]*sin(-1*e*i);
           after_defloat_imag[i] = defloat_imag[i]*cos(-1*e*i) + defloat_real[i]*sin(-1*e*i);                                 
        }
        //symbol timing
        for(i=0;i<32*M;i++)
        {
           long_preamble_real_up[i] = 0;
           long_preamble_imag_up[i] = 0;
           if(i%M == 0)
           {
               long_preamble_real_up[i]=long_preamble_real[i/M];
               long_preamble_imag_up[i]=long_preamble_imag[i/M];
           }
        }
        for(i=0;i<2048/2-60*M;i++)
        {
           noreal[i] = 0;
           noimag[i] = 0;
           no[i] = 0;
        }
       for(i=0;i<2048/2-60*M;i++)
       {
           for(j=0;j<32*M;j++)
           {
               noreal[i] = noreal[i]+after_defloat_real[i+j]*long_preamble_real_up[j]+after_defloat_imag[i+j]*long_preamble_imag_up[j];
               noimag[i] = noimag[i]+after_defloat_imag[i+j]*long_preamble_real_up[j]-after_defloat_real[i+j]*long_preamble_imag_up[j];
           }
           no[i] = noreal[i]*noreal[i]+noimag[i]*noimag[i];
       }
       max = 0;
       for(i=0;i<2048/2-60*M;i++)
       {
           if(max<no[i])
           {
               max = no[i];
           }
       }
       for(i=0;i<2048/2-60*M;i++)
       {
           if(max == no[i])
           {
               number = i;
           }
       }
        //pick the desire data and long preamble

        //use long preamble to do channel estimation

        //demodule desire data after remove the channel gain
        ///**********After synchronization ,catch dqpsk signal*************
       for(i=number+32*M;i<number+32*M+size*M;i++)
       {
           catch_defloat_real[i-number-32*M] = after_defloat_real[i];
           catch_defloat_imag[i-number-32*M] = after_defloat_imag[i];
       } 
        //******************down sample*******************
       for(i=0;i<size*M;i+=M)
       {
           catch_downsample_real[i/M] = catch_defloat_real[i];
           catch_downsample_imag[i/M] = catch_defloat_imag[i];
       }	
       //*************Phase taking***********************	
       for(i=0;i<size;i++)
       {
           if(catch_downsample_imag[i]<0&&catch_downsample_real[i]<0)
           {
                 takephase[i] =  atan(catch_downsample_imag[i]/catch_downsample_real[i])- PI ;
           }
           else if(catch_downsample_imag[i]>0&&catch_downsample_real[i]<0)
           {
                 takephase[i] = atan(catch_downsample_imag[i]/catch_downsample_real[i])+PI;
           }
           else
           {
                 takephase[i] = atan(catch_downsample_imag[i]/catch_downsample_real[i]);
           }
       }
       //********Diff dec*****************************
       checkphase[0] = takephase[0];
       for(i=1;i<size;i++)
       {
    	   checkphase[i] =takephase[i]-takephase[i-1];
           if(checkphase[i]>3.1415926)
           {
                checkphase[i] = checkphase[i] - 2*3.1415926;
           }
           else if(checkphase[i]<-3.1415926)
           {
                checkphase[i] = checkphase[i] + 2*3.1415926;
           }
           checkphase[i] /= 3.1415926;
       }
       checkphase[0] /= 3.1415926;
       //**********use phase to determine the bit sequence**************
       for(i=0;i<size;i+=5)
       {
          if(checkphase[i]>0)
          {
                demod[i/5] = 1;
          }
          else if(checkphase[i]<0)
          {
                demod[i/5] = 0;
          }
       }	     
        //output bit sequence
    	//for(i=0;i<10;i++)
    	//{
    	//	out_data[i] = demod[i];
    	//}
        //end

        //return ??? to MATLAB by Ethernet
    	for(i=0;i<10;i++)
    	{
    		output[i] = demod[i];
    	}
    	for(i=0;i<10;i++)
    	{
    		send_char[i].myval = output[i];
    		send_char[i] = trans(send_char[i]);
    	}
    	time_out=0;
    	do
    	{
    	    sentCnt2=sendto( send, &send_char[0].char_val[0], size*2*4, 0, (struct sockaddr *)&to, sizeof(to));
    		time_out=time_out+1;
    		if(time_out>5)
    		    break;
    	 }while(sentCnt2 < 0 );
         //end
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

float bit2float(unsigned short tmp,int bit_num_da,float highest_num)
{
    int j;
    float target,float_value;
    short ss,tt;

    target = (float)highest_num;
    ss = 0x0800;
    float_value = 0;
    for(j=0;j<bit_num_da;j++)		// bit_num_da = 12
    {
        tt = tmp & ss;
        if(tt == ss)
        {
            float_value += (float)target;
        }
        target = (float)target/2;
        ss = ss >> 1;
    }
    float_value = float_value - highest_num;

    return float_value;
}
