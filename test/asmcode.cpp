//
//  asmcode.cpp     目标代码生成
//  test
//
//  Created by HaoYaru on 2017/12/5.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "macro.h"
#include "semantic.h"
#include "asmcode.h"
#include "lex.h"

void store_on_data(int num)
{
    int tempreg = t_register[num];
    loc_t_reg[tempreg][1] = 1;
    fprintf(ASMOUT, "\t\tla $t8, %s\n", base_data);
    fprintf(ASMOUT, "\t\tsw $t%d, %d($t8)\n", num, base_address);
    loc_t_reg[tempreg][0] = base_address;
    base_address += 4;
}

void Transfer_midreg(char a[])
{
    mid_reg_num = 0;
    int i = 2;
    while(a[i])
    {
        mid_reg_num = mid_reg_num*10 + a[i] - '0';
        i++;
    }
}

void delete_wave_line(char a[])   // 把~label0和~string0的~都去掉
{
    int i = 1;
    while (i<=strlen(a))
    {
        a[i-1] = a[i];
        i++;
    }
}

int max_valuepara_num(int position)   // 函数中出现的最大值参数的个数，要在栈中开辟这块空间
{
    int num = 0;
    int max_num = 0;
    
    while(strcmp(MIDLIST[position], mid_op[ENDFUNC]) != 0)
    {
        if(strcmp(MIDLIST[position], mid_op[VALUEPARAOP]) == 0)
        {
            num++;
            position += 4;
            while(strcmp(MIDLIST[position], mid_op[VALUEPARAOP]) == 0)
            {
                num++;
                position += 4;
            }
        }
        else
            position += 4;
        
        if(num > max_num)
        {
            max_num = num;
            num = 0;
        }
    }
    
    return max_num;
}

void gen_asm()
{
    int i = 0;
    levelnum = 0;
    
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
    strcpy(base_data, table[i-1].name);
    base_address += 4*table[i-1].length;
    base_addr_offset = 4*table[i-1].length;
    
    fprintf(ASMOUT, "\n");
    fprintf(ASMOUT, "\t\t.text\n");
    fprintf(ASMOUT, "\t\t.globl main\n");
    
    while(midpointer < midcnt)
    {
        if(strcmp(MIDLIST[midpointer], mid_op[FUNCOP]) == 0)
        {
            if(strcmp(MIDLIST[midpointer+3], "main") == 0)
                mainFlag = 1;
            levelnum++;
            func_asm();
        }
        midpointer += 4;
    }
}

void func_asm()    // 以函数为单位生成目标代码
{
    int var_num = 0;    // 函数的数据(变量和常量)个数
    int valuepara_num = 0;  //函数中出现的最大值参数的个数,由max_valuepara_num返回
    int func_type = 0;     // function的返回类型
    int i = 0;
    int position = 0;
    int para_address = 0;  // 函数参数相对栈底的地址计数
    int data_address = -12;  // 函数数据相对栈底的地址计数，从-12开始
    int sp = 0;    // sp到底应该减多少
    int sp_base = 0;   // sp基
    int loc_reg = 0;
    
    fprintf(ASMOUT, "%s:\t\n", MIDLIST[midpointer+3]);    // 先输出函数名
    /*for(i=0; i<curt_tempReg; i++)     // 保存现场
        fprintf(ASMOUT, "\t\tmove $s%d, $t%d\n", curt_tempReg, curt_tempReg); */
    
    midpointer += 4;
    while(strcmp(MIDLIST[midpointer], mid_op[ENDFUNC]) != 0)
    {
        if(strcmp(MIDLIST[midpointer], mid_op[PARAOP]) == 0)   // 把参数相对栈底的地址填入符号表
        {
            position = LookupTab(MIDLIST[midpointer+3], 0);
            table[position].address = para_address;
            para_address += 4;   // 参数是往上的，局部数据是往下的
        }
        else if(strcmp(MIDLIST[midpointer], mid_op[CONSTOP]) == 0)
        {
            position = LookupTab(MIDLIST[midpointer+3], 0);
            table[position].address = data_address;
            data_address -= 4;
        }
        else if((strcmp(MIDLIST[midpointer], mid_op[INTOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[CHAROP]) == 0))
        {
            if(strcmp(MIDLIST[midpointer+1], "\0") == 0)
            {
                position = LookupTab(MIDLIST[midpointer+3], 0);
                table[position].address = data_address;
                data_address -= 4;
            }
            else
            {
                position = LookupTab(MIDLIST[midpointer+3], 0);
                data_address = data_address - 4*table[position].length;
                table[position].address = data_address + 4;  // 数组起始地址
            }
        }
        else
            break;
        
        midpointer += 4;
    }
    
    valuepara_num = max_valuepara_num(midpointer);
    sp_base = -data_address + 4*valuepara_num;
    sp = sp_base;
    
    fprintf(ASMOUT, "\t\taddi $sp, $sp, %d\n", -sp_base);
    fprintf(ASMOUT, "\t\tsw $ra, %d($sp)\n", sp-4);
    fprintf(ASMOUT, "\t\tsw $fp, %d($sp)\n", sp-8);
    fprintf(ASMOUT, "\t\tmove $fp, $sp\n");      // 存储返回地址和帧指针
    sp -= 12;
    
    position = tableindex[levelnum] + 1;
    if(table[tableindex[levelnum]].length != 0)   // 如果函数有参数,将参数存储在栈上
    {
        int a_num = table[tableindex[levelnum]].length;
        if(a_num <= 4)
        {
            for(i=0; i<a_num; i++)
            {
                fprintf(ASMOUT, "\t\tsw $a%d, %d($sp)\n", i, sp_base+4*i);
                table[position++].address = sp_base+4*i;
            }
        }
        else
        {
            for(i=0; i<4; i++)
            {
                fprintf(ASMOUT, "\t\tsw $a%d, %d($sp)\n", i, sp_base+4*i);
                table[position++].address = sp_base+4*i;
            }
            for(i=4; i<a_num; i++)
                table[position++].address = sp_base+4*i;
        }
    }     // position指到了第一个局部常量(变量)的位置
    
    // 此时的midpointer已经到了变量声明后的第一条语句
    // midpointer += table[tableindex[levelnum]].length*4;   // midpointer指到了第一个局部常量(变量)的位置   WTF??????
    while (table[position].type == CONSTTYPE)    // 将局部常量放到栈上
    {
        if(table[position].kind == CHARSY)
            fprintf(ASMOUT, "\t\tli $v0, %d\n", table[position].charval);
        else
            fprintf(ASMOUT, "\t\tli $v0, %d\n", table[position].intval);
        
        fprintf(ASMOUT, "\t\tsw $v0, %d($sp)\n", sp);
        table[position].address = sp;
        sp -= 4;
        position++;
    }
    
    while (table[position].type == VARIABLETYPE)     // 变量只需要更新其在符号表的位置
    {
        table[position].address += sp_base;
        position++;
    }
    
    char temp1[wlMAX];   // 四元式的三个操作数
    char temp2[wlMAX];
    char temp3[wlMAX];
    
    while (strcmp(MIDLIST[midpointer], mid_op[ENDFUNC]) != 0)
    {
        if((strcmp(MIDLIST[midpointer], mid_op[PLUSOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[MULTIOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[DIVOP]) == 0))    // plus|div|mult
        {
            // 先处理第一个操作数
            if(MIDLIST[midpointer+1][0] == '~')
            {
                Transfer_midreg(MIDLIST[midpointer+1]);
                if(loc_t_reg[mid_reg_num][1]==0)
                    sprintf(temp1, "$t%d", loc_t_reg[mid_reg_num][0]);
                else
                {
                    fprintf(ASMOUT, "\t\tla $v0, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $v0, %d($v0)\n", loc_t_reg[mid_reg_num][0]);
                    sprintf(temp1, "$v0");
                }
            }
            else if(isDigit(MIDLIST[midpointer+1][0]) || MIDLIST[midpointer+1][0]=='-')
            {
                fprintf(ASMOUT, "\t\tli $v0, %d\n", atoi(MIDLIST[midpointer+1]));
                sprintf(temp1, "$v0");
            }
            else if(isLetter(MIDLIST[midpointer+1][0]))
            {
                position = LookupTab(MIDLIST[midpointer+1], 0);
                if(position < tableindex[1])   // 如果是全局的
                {
                    fprintf(ASMOUT, "\t\tla $v0, %s\n", MIDLIST[midpointer+1]);
                    fprintf(ASMOUT, "\t\tlw $v0, 0($v0)\n");
                    sprintf(temp1, "$v0");
                }
                else
                {
                    fprintf(ASMOUT, "\t\tlw $v0, %d($sp)\n", table[position].address);
                    sprintf(temp1, "$v0");
                }
            }
            
            // 再处理第二个操作数
            if(MIDLIST[midpointer+2][0] == '~')
            {
                Transfer_midreg(MIDLIST[midpointer+2]);
                if(loc_t_reg[mid_reg_num][1]==0)
                    sprintf(temp2, "$t%d", loc_t_reg[mid_reg_num][0]);
                else
                {
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $v1, %d($v1)\n", loc_t_reg[mid_reg_num][0]);
                    sprintf(temp2, "$v1");
                }
            }
            else if(isDigit(MIDLIST[midpointer+2][0]) || MIDLIST[midpointer+2][0]=='-')
            {
                fprintf(ASMOUT, "\t\tli $v1, %d\n", atoi(MIDLIST[midpointer+2]));
                sprintf(temp2, "$v1");
            }
            else if(isLetter(MIDLIST[midpointer+2][0]))
            {
                position = LookupTab(MIDLIST[midpointer+2], 0);
                if(position < tableindex[1])   // 如果是全局的
                {
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", MIDLIST[midpointer+2]);
                    fprintf(ASMOUT, "\t\tlw $v1, 0($v1)\n");
                    sprintf(temp2, "$v1");
                }
                else
                {
                    fprintf(ASMOUT, "\t\tlw $v1, %d($sp)\n", table[position].address);
                    sprintf(temp2, "$v1");
                }
            }
            
            // 再处理第三个操作数
            Transfer_midreg(MIDLIST[midpointer+3]);
            if(tempReg == 8)   // 8个临时寄存器全部占满,把第一个挪走
            {
                store_on_data(0);    // 把原来$t0上的数据存到内存上
                sprintf(temp3, "$t0");
                loc_t_reg[mid_reg_num][0] = 0;
                loc_t_reg[mid_reg_num][1] = 0;
            }
            else
            {
                sprintf(temp3, "$t%d", tempReg);
                loc_t_reg[mid_reg_num][0] = tempReg;
                loc_t_reg[mid_reg_num][1] = 0;
                tempReg++;
            }
            
            if(strcmp(MIDLIST[midpointer], mid_op[PLUSOP]) == 0)
                fprintf(ASMOUT, "\t\tadd %s, %s, %s\n", temp3, temp1, temp2);
            else if(strcmp(MIDLIST[midpointer], mid_op[MULTIOP]) == 0)
                fprintf(ASMOUT, "\t\tmul %s, %s, %s\n", temp3, temp1, temp2);
            else if(strcmp(MIDLIST[midpointer], mid_op[DIVOP]) == 0)
                fprintf(ASMOUT, "\t\tdiv %s, %s, %s\n", temp3, temp1, temp2);
        }
        else if(strcmp(MIDLIST[midpointer], mid_op[MINUSOP]) == 0)   // minus
        {
            // 先处理第一个操作数
            if(MIDLIST[midpointer+1][0] == '~')
            {
                Transfer_midreg(MIDLIST[midpointer+1]);
                if(loc_t_reg[mid_reg_num][1]==0)
                    sprintf(temp1, "$t%d", loc_t_reg[mid_reg_num][0]);
                else
                {
                    fprintf(ASMOUT, "\t\tla $v0, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $v0, %d($v0)\n", loc_t_reg[mid_reg_num][0]);
                    sprintf(temp1, "$v0");
                }
            }
            else if(isDigit(MIDLIST[midpointer+1][0]) || MIDLIST[midpointer+1][0]=='-')
            {
                fprintf(ASMOUT, "\t\tli $v0, %d\n", atoi(MIDLIST[midpointer+1]));
                sprintf(temp1, "$v0");
            }
            else if(isLetter(MIDLIST[midpointer+1][0]))
            {
                position = LookupTab(MIDLIST[midpointer+1], 0);
                if(position < tableindex[1])   // 如果是全局的
                {
                    fprintf(ASMOUT, "\t\tla $v0, %s\n", MIDLIST[midpointer+1]);
                    fprintf(ASMOUT, "\t\tlw $v0, 0($v0)\n");
                    sprintf(temp1, "$v0");
                }
                else
                {
                    fprintf(ASMOUT, "\t\tlw $v0, %d($sp)\n", table[position].address);
                    sprintf(temp1, "$v0");
                }
            }
            
            // 再处理第二个操作数
            int minus_flag = 0;
            if(MIDLIST[midpointer+2][2] != '\0')
            {
                if(MIDLIST[midpointer+2][0] == '~')
                {
                    Transfer_midreg(MIDLIST[midpointer+2]);
                    if(loc_t_reg[mid_reg_num][1]==0)
                        sprintf(temp2, "$t%d", loc_t_reg[mid_reg_num][0]);
                    else
                    {
                        fprintf(ASMOUT, "\t\tla $v1, %s\n", base_data);
                        fprintf(ASMOUT, "\t\tlw $v1, %d($v1)\n", loc_t_reg[mid_reg_num][0]);
                        sprintf(temp2, "$v1");
                    }
                }
                else if(isDigit(MIDLIST[midpointer+2][0]) || MIDLIST[midpointer+2][0]=='-')
                {
                    fprintf(ASMOUT, "\t\tli $v1, %d\n", atoi(MIDLIST[midpointer+2]));
                    sprintf(temp2, "$v1");
                }
                else if(isLetter(MIDLIST[midpointer+2][0]))
                {
                    position = LookupTab(MIDLIST[midpointer+2], 0);
                    if(position < tableindex[1])   // 如果是全局的
                    {
                        fprintf(ASMOUT, "\t\tla $v1, %s\n", MIDLIST[midpointer+2]);
                        fprintf(ASMOUT, "\t\tlw $v1, 0($v1)\n");
                        sprintf(temp2, "$v1");
                    }
                    else
                    {
                        fprintf(ASMOUT, "\t\tlw $v1, %d($sp)\n", table[position].address);
                        sprintf(temp2, "$v1");
                    }
                }
            }
            else
                minus_flag = 1;
            
            // 再处理第三个操作数
            Transfer_midreg(MIDLIST[midpointer+3]);
            if(tempReg == 8)   // 8个临时寄存器全部占满,把第一个挪走
            {
                store_on_data(0);    // 把原来$t0上的数据存到内存上
                sprintf(temp3, "$t0");
                loc_t_reg[mid_reg_num][0] = 0;
                loc_t_reg[mid_reg_num][1] = 0;
            }
            else
            {
                sprintf(temp3, "$t%d", tempReg);
                loc_t_reg[mid_reg_num][0] = tempReg;
                loc_t_reg[mid_reg_num][1] = 0;
                tempReg++;
            }
            
            if(minus_flag == 1)
                fprintf(ASMOUT, "\t\tsub %s, $0, %s\n", temp3, temp1);
            else
                fprintf(ASMOUT, "\t\tsub %s, %s, %s\n", temp3, temp1, temp2);
        }
        else if(strcmp(MIDLIST[midpointer], mid_op[GETARRAY]) == 0)   // =[]
        {
            // 先处理第一个操作数，即数组名
            int if_glbarray = 0;    // 是否是全局数组
            int num_or_reg = 0;    // 第二个操作数是数字还是寄存器
            int getarray_addr = 0;
            position = LookupTab(MIDLIST[midpointer+1], 0);
            if(position < tableindex[1])   // 全局数组
            {
                fprintf(ASMOUT, "\t\tla $v0, %s\n", MIDLIST[midpointer+1]);
                if_glbarray = 1;
            }
            else    // 局部数组
            {
                fprintf(ASMOUT, "\t\taddi $v0, $sp, %d\n", table[position].address);
            }
            
            // 再处理第二个操作数，即数组索引  （不是寄存器就是数字）
            if(isDigit(MIDLIST[midpointer+2][0]))
                getarray_addr = atoi(MIDLIST[midpointer+2])*4;
            else if(MIDLIST[midpointer+2][0] == '~')
            {
                num_or_reg = 1;
                Transfer_midreg(MIDLIST[midpointer+2]);
                if(loc_t_reg[mid_reg_num][1] == 1)
                {
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $v1, %d($v1)\n", loc_t_reg[mid_reg_num][0]);
                    fprintf(ASMOUT, "\t\tmulu $v1, $v1, 4\n");
                }
                else
                {
                    fprintf(ASMOUT, "\t\tmulu $v1, $t%d, 4\n", loc_t_reg[mid_reg_num][0]);
                }
            }
            
            // 最后处理第三个操作数（肯定是寄存器）
            Transfer_midreg(MIDLIST[midpointer+3]);
            if(tempReg == 8)   // 8个临时寄存器全部占满,把第一个挪走
            {
                store_on_data(0);    // 把原来$t0上的数据存到内存上
                sprintf(temp3, "$t0");
                loc_t_reg[mid_reg_num][0] = 0;
                loc_t_reg[mid_reg_num][1] = 0;
            }
            else
            {
                sprintf(temp3, "$t%d", tempReg);
                loc_t_reg[mid_reg_num][0] = tempReg;
                loc_t_reg[mid_reg_num][1] = 0;
                tempReg++;
            }
            
            if(num_or_reg == 0)
                fprintf(ASMOUT, "\t\tlw %s, %d($v0)\n", temp3, getarray_addr);
            else
            {
                fprintf(ASMOUT, "\t\tadd $v0, $v0, $v1\n");
                fprintf(ASMOUT, "\t\tlw %s, 0($v0)\n", temp3);
            }
        }
        else if((strcmp(MIDLIST[midpointer], mid_op[EQLCON]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[NEQCON]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[GTCON]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[GTECON]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[LSCON]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[LSECON]) == 0))    // 关系运算符
        {
            // 先处理第一个操作数  temp1
            if(MIDLIST[midpointer+1][0] == '~')
            {
                Transfer_midreg(MIDLIST[midpointer+1]);
                if(loc_t_reg[mid_reg_num][1]==0)
                    sprintf(temp1, "$t%d", loc_t_reg[mid_reg_num][0]);
                else
                {
                    fprintf(ASMOUT, "\t\tla $v0, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $v0, %d($v0)\n", loc_t_reg[mid_reg_num][0]);
                    sprintf(temp1, "$v0");
                }
            }
            else if(isDigit(MIDLIST[midpointer+1][0]) || MIDLIST[midpointer+1][0]=='-')
            {
                fprintf(ASMOUT, "\t\tli $v0, %d\n", atoi(MIDLIST[midpointer+1]));
                sprintf(temp1, "$v0");
            }
            else if(isLetter(MIDLIST[midpointer+1][0]))
            {
                position = LookupTab(MIDLIST[midpointer+1], 0);
                if(position < tableindex[1])   // 如果是全局的
                {
                    fprintf(ASMOUT, "\t\tla $v0, %s\n", MIDLIST[midpointer+1]);
                    fprintf(ASMOUT, "\t\tlw $v0, 0($v0)\n");
                    sprintf(temp1, "$v0");
                }
                else
                {
                    fprintf(ASMOUT, "\t\tlw $v0, %d($sp)\n", table[position].address);
                    sprintf(temp1, "$v0");
                }
            }
            
            // 再处理第二个操作数   temp2
            if(MIDLIST[midpointer+2][0] == '~')
            {
                Transfer_midreg(MIDLIST[midpointer+2]);
                if(loc_t_reg[mid_reg_num][1]==0)
                    sprintf(temp2, "$t%d", loc_t_reg[mid_reg_num][0]);
                else
                {
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $v1, %d($v1)\n", loc_t_reg[mid_reg_num][0]);
                    sprintf(temp2, "$v1");
                }
            }
            else if(isDigit(MIDLIST[midpointer+2][0]) || MIDLIST[midpointer+2][0]=='-')
            {
                fprintf(ASMOUT, "\t\tli $v1, %d\n", atoi(MIDLIST[midpointer+2]));
                sprintf(temp2, "$v1");
            }
            else if(isLetter(MIDLIST[midpointer+2][0]))
            {
                position = LookupTab(MIDLIST[midpointer+2], 0);
                if(position < tableindex[1])   // 如果是全局的
                {
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", MIDLIST[midpointer+2]);
                    fprintf(ASMOUT, "\t\tlw $v1, 0($v1)\n");
                    sprintf(temp2, "$v1");
                }
                else
                {
                    fprintf(ASMOUT, "\t\tlw $v1, %d($sp)\n", table[position].address);
                    sprintf(temp2, "$v1");
                }
            }
            
            // 再处理第三个操作数   temp3
            Transfer_midreg(MIDLIST[midpointer+3]);
            if(tempReg == 8)   // 8个临时寄存器全部占满,把第一个挪走
            {
                store_on_data(0);    // 把原来$t0上的数据存到内存上
                sprintf(temp3, "$t0");
                loc_t_reg[mid_reg_num][0] = 0;
                loc_t_reg[mid_reg_num][1] = 0;
            }
            else
            {
                sprintf(temp3, "$t%d", tempReg);
                loc_t_reg[mid_reg_num][0] = tempReg;
                loc_t_reg[mid_reg_num][1] = 0;
                tempReg++;
            }
            
            fprintf(ASMOUT, "\t\tsub %s, %s, %s\n", temp3, temp1, temp2);
        }
        else if((strcmp(MIDLIST[midpointer], mid_op[BEQZOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[BNEZOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[BGTZOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[BGEZOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[BLTZOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[BLEZOP]) == 0))     // dowhile和if的跳转
        {
            Transfer_midreg(MIDLIST[midpointer+1]);   // 一定是个寄存器而且不可能被挤到内存上
            delete_wave_line(MIDLIST[midpointer+3]);
            fprintf(ASMOUT, "\t\t%s $t%d, %s\n", MIDLIST[midpointer], loc_t_reg[mid_reg_num][0], MIDLIST[midpointer+3]);
            fprintf(ASMOUT, "\t\tnop\n");
            tempReg = 0;
        }
        else if(strcmp(MIDLIST[midpointer], mid_op[SETLABELOP]) == 0)   // setlabel
        {
            delete_wave_line(MIDLIST[midpointer+3]);
            fprintf(ASMOUT, "%s:\t\n", MIDLIST[midpointer+3]);
            tempReg = 0;
        }
        else if(strcmp(MIDLIST[midpointer], mid_op[JUMPOP]) == 0)    // jump
        {
            delete_wave_line(MIDLIST[midpointer+3]);
            fprintf(ASMOUT, "\t\tj %s\n", MIDLIST[midpointer+3]);
            fprintf(ASMOUT, "\t\tnop\n");
            tempReg = 0;
        }
        else if(strcmp(MIDLIST[midpointer], mid_op[ASSIGNOP]) == 0)   // =
        {
            if(MIDLIST[midpointer+1][0] == '~')
            {
                Transfer_midreg(MIDLIST[midpointer+1]);
                if(loc_t_reg[mid_reg_num][1]==0)
                    sprintf(temp1, "$t%d", loc_t_reg[mid_reg_num][0]);
                else
                {
                    fprintf(ASMOUT, "\t\tla $v0, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $v0, %d($v0)\n", loc_t_reg[mid_reg_num][0]);
                    sprintf(temp1, "$v0");
                }
            }
            else if(isDigit(MIDLIST[midpointer+1][0]) || MIDLIST[midpointer+1][0]=='-')
            {
                fprintf(ASMOUT, "\t\tli $v0, %d\n", atoi(MIDLIST[midpointer+1]));
                sprintf(temp1, "$v0");
            }
            else if(isLetter(MIDLIST[midpointer+1][0]))
            {
                position = LookupTab(MIDLIST[midpointer+1], 0);
                if(position < tableindex[1])   // 如果是全局的
                {
                    fprintf(ASMOUT, "\t\tla $v0, %s\n", MIDLIST[midpointer+1]);
                    fprintf(ASMOUT, "\t\tlw $v0, 0($v0)\n");
                    sprintf(temp1, "$v0");
                }
                else
                {
                    fprintf(ASMOUT, "\t\tlw $v0, %d($sp)\n", table[position].address);
                    sprintf(temp1, "$v0");
                }
            }
            
            position = LookupTab(MIDLIST[midpointer+3], 0);
            if(position < tableindex[1])
                fprintf(ASMOUT, "\t\tla $v1, %s\n", MIDLIST[midpointer+3]);
            else
                fprintf(ASMOUT, "\t\taddi $v1, $sp, %d\n", table[position].address);
            fprintf(ASMOUT, "\t\tsw %s, 0($v1)\n", temp1);
            tempReg = 0;
        }
        midpointer += 4;
    }
    /*for(i=0; i<curt_tempReg; i++)   // 恢复现场
        fprintf(ASMOUT, "\t\tmove $t%d, $s%d\n", curt_tempReg, curt_tempReg);*/
}














