//
//  optimize.cpp
//  test
//
//  Created by HaoYaru on 2017/12/14.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "macro.h"
#include "optimize.h"

void opt()
{
    //int func_num = 0;
    int i = 0;
    midpointer = 0;
    
    while(midpointer < midcnt)
    {
        if(strcmp(MIDLIST[midpointer], mid_op[FUNCOP]) == 0)    // 首先划分基本块
        {
            i = 0;
            while(i<4)
            {
                out_dag[dagoutcnt+i] = (char *)malloc(50*sizeof(char));
                strcpy(out_dag[dagoutcnt+i], MIDLIST[midpointer+i]);
            }
            dagoutcnt += 4;
            midpointer += 4;
            while(strcmp(MIDLIST[midpointer], mid_op[CONSTOP])==0 || strcmp(MIDLIST[midpointer], mid_op[INTOP])==0 || strcmp(MIDLIST[midpointer], mid_op[CHAROP])==0)
            {
                i = 0;
                while(i<4)
                {
                    out_dag[dagoutcnt+i] = (char *)malloc(50*sizeof(char));
                    strcpy(out_dag[dagoutcnt+i], MIDLIST[midpointer+i]);
                }
                dagoutcnt += 4;
                midpointer += 4;
            }
            func_block();
        }
        // dagoutcnt += 4;
        midpointer += 4;
    }
}

void func_block()
{
    int if_entry[midcodeMAX]={0};
    int midcode_len = 0;
    int len_cnt = 0;
    int midtmp_pointer = 0;
    int block_size = 0;    // 基本块大小
    int i = 0;
    
    midtmp_pointer = midpointer;
    while(strcmp(MIDLIST[midpointer], mid_op[ENDFUNC]) != 0)
    {
        if(midcode_len == 0)
            if_entry[midcode_len] = 1;
        else
        {
            if((strcmp(MIDLIST[midpointer], mid_op[BEQZOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[BNEZOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[BGTZOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[BGEZOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[BLTZOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[BLEZOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[BNEOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[JUMPOP]) == 0))
                if_entry[midcode_len+1] = 1;
            else if(strcmp(MIDLIST[midpointer], mid_op[SETLABELOP]) == 0)
                if_entry[midcode_len] = 1;
        }
        midcode_len++;
    }
    
    while(len_cnt < midcode_len)
    {
        block_size = 0;
        if(if_entry[len_cnt] == 1)     // ???
        {
            i = 0;
            while(i < 4)
            {
                in_dag[dagincnt+i] = (char *)malloc(50*sizeof(char));
                strcpy(in_dag[dagincnt+i], MIDLIST[midtmp_pointer+i]);
            }
            dagincnt += 4;
            midtmp_pointer += 4;
            len_cnt++;
            block_size++;
            
            while(if_entry[len_cnt] == 0)
            {
                i = 0;
                while(i < 4)
                {
                    in_dag[dagincnt+i] = (char *)malloc(50*sizeof(char));
                    strcpy(in_dag[dagincnt+i], MIDLIST[midtmp_pointer+i]);
                }
                dagincnt += 4;
                midtmp_pointer += 4;
                len_cnt++;
                block_size++;
            }
            dag_proc(block_size);
            
            for (i=0; i<block_size; i++)
                free(in_dag[i]);
        }
    }
}

void dag_proc(int block_size)
{
    
}
