#include <stdlib.h>
#include <stdio.h>
#include <math.h>


float bit2float(unsigned short tmp,int bit_num_da,float highest_num)  
{
    int j;
    float target,float_value;
    short ss,tt;
    
    target = (float)1;
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
    float_value = float_value - 1;

    return float_value;
}


