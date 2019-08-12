#include <stdlib.h>
#include <stdio.h>
#include <math.h>


float ADC(float value,int bit,int dyn)
{
    float fixed_value,x;
    //int y;
    x = value/((float)dyn/(float)(pow(2,bit)));
    if(x > (float)(pow(2,bit-1)-1))
      x = (float)(pow(2,bit-1)-1);
    if(x < -(float)(pow(2,bit-1)))
      x = -(float)(pow(2,bit-1));
    
    fixed_value = (float)x*((float)dyn/(float)(pow(2,bit)))+(float)(dyn/2);
    
    return fixed_value;   
}

