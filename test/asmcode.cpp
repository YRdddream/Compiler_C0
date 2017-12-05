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
#include "asmcode.h"

void gen_asm()
{
    int i = 0;
    int j = 0;
    
    fprintf(ASMOUT, "\t\t.data\n");
    
    for(i = 0; i < str_num; i++)
        fprintf(ASMOUT, "\t\tstr%d:  .asciiz \"%s\"\n", i, StringList[i]);
    
}
