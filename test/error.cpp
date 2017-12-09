//
//  error.cpp
//  test
//
//  Created by HaoYaru on 2017/11/29.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#include <stdio.h>
#include "macro.h"
#include <string.h>
#include <stdlib.h>
#include "error.h"
#include "lex.h"
#include "semantic.h"

void error(int i)
{
    switch (i) {
        case FILE_ERROR:
            printf("ERROR[%d] in LINE%d: File NOT exists!\n", i, lc);
            exit(0);
            break;
            
        case TOOLONG_LL:
            printf("ERROR[%d] in LINE%d: The length of a line is TOO LONG!\n", i, lc);
            exit(0);
            break;
            
        case TOOLONG_WL:
            printf("ERROR[%d] in LINE%d: The length of a word/string is TOO LONG!\n", i, lc);
            exit(0);
            break;
            
        case TOOBIG_NUMBER:
            printf("ERROR[%d] in LINE%d: The number value is TOO BIG!\n", i, lc);
            exit(0);
            break;
            
        case UNDEFINED_IDENT:
            printf("ERROR[%d] in LINE%d: Undefined identifier [%s]!\n", i, lc, token);
            break;
            
        default:
            break;
    }
}
