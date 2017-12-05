//
//  midcode.cpp
//  test
//
//  Created by HaoYaru on 2017/12/2.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include "macro.h"
#include "midcode.h"

void gen_midcode(char *op, char *a, char *b, char *c)
{
    memset(midcode, 0, llMAX);
    strcat(midcode, op);
    strcat(midcode, ", ");      // 1
    
    if(a != 0)
    {
        strcat(midcode, a);
        strcat(midcode, ", ");      // 2
    }
    else
        strcat(midcode, " , ");
    
    if(b != 0)
    {
        strcat(midcode, b);      // 3
        strcat(midcode, ", ");
    }
    else
        strcat(midcode, " , ");
    
    if(c != 0)
        strcat(midcode, c);       // 4
    
    fprintf(midcode_out, "%s\n", midcode);
}
