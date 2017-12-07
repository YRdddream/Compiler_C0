//
//  midcode.cpp
//  test
//
//  Created by HaoYaru on 2017/12/2.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
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
    
    if(strcmp(op, "function") == 0)
        funcFlag = 1;
    
    if(funcFlag == 1)
    {
        MIDLIST[midcnt] = (char *)malloc(50*sizeof(char));
        strcpy(MIDLIST[midcnt], op);
        
        MIDLIST[midcnt+1] = (char *)malloc(50*sizeof(char));
        if(a != 0)
            strcpy(MIDLIST[midcnt+1], a);
        else
            strcpy(MIDLIST[midcnt+1], "\0");
        
        MIDLIST[midcnt+2] = (char *)malloc(50*sizeof(char));
        if(b != 0)
            strcpy(MIDLIST[midcnt+2], b);
        else
            strcpy(MIDLIST[midcnt+2], "\0");
        
        MIDLIST[midcnt+3] = (char *)malloc(50*sizeof(char));
        if(c != 0)
            strcpy(MIDLIST[midcnt+3], c);
        else
            strcpy(MIDLIST[midcnt+3], "\0");
        
        midcnt += 4;
    }
    
    fprintf(midcode_out, "%s\n", midcode);
}
