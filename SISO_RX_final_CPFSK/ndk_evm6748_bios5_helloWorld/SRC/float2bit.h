#include <stdlib.h>
#include <stdio.h>
#include <math.h>



unsigned short float2bit(float float_value,int bit_num_ad,float highest_num)  
{
    int j;
    float target;
    short tmp,ss;
    
    ss = 0x0200;
   	tmp = 0x0000;
   	target = (float)highest_num;    //程蔼计

    for(j=0;j<bit_num_ad;j++)
    {
        if(float_value >= target)   // 膀非计碞糶1
        {
            tmp = tmp | ss;
            float_value = (float)float_value - target;
        }
        target = (float)target / 2;    // 盢膀非计埃2
        ss = ss >> 1;
    }
    tmp = tmp & 0x03ff;
    return tmp;
}

