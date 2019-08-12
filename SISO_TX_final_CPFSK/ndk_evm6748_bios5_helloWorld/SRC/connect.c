#include	 <stdio.h>
#include	 <stdlib.h>
#include	 <netmain.h>
#include	 <math.h>
#include	 <_stack.h>
#include 	 <std.h>
#include 	 <tsk.h>
#include 	"transform.h"
#include	<log.h>			//(S0305)
#include	<mem.h>			// (S0305)
#include	<hw_dspcache.h>			// (S0305)
#include 	<soc_OMAPL138.h>
#define		size 100/2
#define		_DEBUG_EMIFA
void	F_StartEMIFA(void);
extern void system_run(float *a[size*2]);
char *UnicastAddr = "192.168.0.40";	// PC address

//----{ (S0225)

union mydata recv_char[size*2];
float *seq[size*2];

/* Global variable */
int leave_flag=0,sentCnt = 0,i=0;


void udp_test()
{
    SOCKET   send = INVALID_SOCKET;     // Sender socket. 
    SOCKET   recv = INVALID_SOCKET;     // Sender socket.
    struct   sockaddr_in rec;           // Sender socket address structure
    struct   sockaddr_in to;           // Sender socket address structure
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
        leave_flag=1;
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


	for(;;)
	{
	    	do
	    	{
	    		sentCnt = recvfrom( recv, &recv_char[0].char_val[0], size*2*4, 0, (struct sockaddr*)&rec, &sz );
	    	} while (sentCnt < 0);
	    	//printf("Start!\n");

	    	/* transform data */
	    	for(i=0;i<size*2;i++)
	    	{
	    		recv_char[i] = trans(recv_char[i]);
	    		seq[i] = &recv_char[i].myval;
	    	}
	        system_run(seq);
	}
}

