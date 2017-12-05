//
//  semantic.cpp
//  test
//
//  Created by HaoYaru on 2017/11/26.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include "macro.h"
#include "semantic.h"
#include "grammar.h"
#include "lex.h"
#include "error.h"

int LookupTab(char* name, int use_or_def)    // 0代表使用，def代表定义
{
    int position = elenum - 1;
    int find = 0;   // find为1表示找到
    transfer(name);
    
    while(position >= tableindex[levelnum])     // 先在本函数内部找
    {
        if(strcmp(name, table[position].name) == 0)
        {
            find = 1;
            break;
        }
        position--;
    }
    
    if(use_or_def == 1)    // 如果是定义，则在本函数内部查找完就可返回
    {
        if(find == 0)
            return (-1);
        else
            return position;
    }
    
    if(find == 0)     // 开始在全局常量和变量定义里找(先在分程序索引中找第一次出现函数的地方)
    {
        position = 0;
        int firstfuncpos = 0;   // 函数第一次出现的位置
        while(table[firstfuncpos].type != FUNCTIONTYPE)
            firstfuncpos++;
        
        for(position=0; position<firstfuncpos; position++)
        {
            if(strcmp(name, table[position].name) == 0)
            {
                find = 1;
                break;
            }
        }
    }
    
    if(find == 0)     // 最后找函数
    {
        int i = 1;
        while(i <= levelnum)
        {
            if(strcmp(name, table[tableindex[i]].name) == 0)
            {
                find = 1;
                position = tableindex[i];
                break;
            }
            i++;
        }
    }
    
    if(find == 1)
        return position;
    else
        return (-1);
}

int EnterTab(char* name, int type, int kind, int intval, char chval, int address, int length)
{
    transfer(name);
    if(LookupTab(name, 1) != (-1))
    {
        error(REPEATDEF_IDENT);
        return (-1);
    }
    else if(elenum >= tablelMAX)
        error(TABLE_FULL);
    else
    {
        strcpy(table[elenum].name, name);
        table[elenum].type = type;
        table[elenum].kind = kind;         // voidsy, intsy, charsy
        table[elenum].intval = intval;
        table[elenum].charval = chval;
        table[elenum].address = address;
        table[elenum].length = length;
        elenum++;
        
        return 0;
    }
    return 0;
}
