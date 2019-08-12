#include <stdio.h>
#include <stdlib.h>
#include <math.h>

union mydata
{
    float   myval;
    char  char_val[4];
};

union mydata  trans(union mydata data)
{
	char a,b,c,d;

	a = data.char_val[0];
	b = data.char_val[1];
	c = data.char_val[2];
	d = data.char_val[3];

	data.char_val[0] = d;
	data.char_val[1] = c;
	data.char_val[2] = b;
	data.char_val[3] = a;

	return data;
}
