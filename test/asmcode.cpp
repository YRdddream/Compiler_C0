//
//  asmcode.cpp     目标代码生成
//  test
//
//  Created by HaoYaru on 2017/12/5.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include "macro.h"
#include "semantic.h"
#include "asmcode.h"

void gen_asm()
{
    int i = 0;
    
    fprintf(ASMOUT, "\t\t.data\n");
    
    for(i = 0; i < str_num; i++)
        fprintf(ASMOUT, "\t\tstr%d:  .asciiz \"%s\"\n", i, StringList[i]);   // 初始化程序中出现过的字符串
    
    fprintf(ASMOUT, "\n");
    
    for(i = tableindex[0]; i < tableindex[1]; i++)     // 全局数据区(全局const和全局变量)
    {
        if(table[i].type == CONSTTYPE)    // 全局常量
        {
            if(table[i].kind == CHARSY)
                fprintf(ASMOUT, "\t\t%s:  .word %d\n", table[i].name, table[i].charval);
            else
                fprintf(ASMOUT, "\t\t%s:  .word %d\n", table[i].name, table[i].intval);
        }
        else       // 全局变量
        {
            if(table[i].length == 0)
                fprintf(ASMOUT, "\t\t%s:  .word 0\n", table[i].name);
            else
                fprintf(ASMOUT, "\t\t%s:  .space %d\n", table[i].name, 4*table[i].length);
        }
    }
    
    fprintf(ASMOUT, "\n");
    fprintf(ASMOUT, "\t\t.text\n");
    fprintf(ASMOUT, "\t\t.globl main\n");
    
    while(midpointer < midcnt)
    {
        if(strcmp(MIDLIST[midpointer], "function") == 0)
        {
            if(strcmp(MIDLIST[midpointer+3], "main") == 0)
                mainFlag = 1;
            func_asm();
        }
    }
}

void func_asm()    // 以函数为单位生成目标代码
{
    
}
