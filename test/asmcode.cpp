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
    
    if(round == 1)
    {
        while (i<=strlen(a))
        {
            a[i-1] = a[i];
            i++;
        }
        if(a[0]=='l' || a[0]=='s')
            a[0] -= 32;
    }
    else
        return;
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
    func_cnt = 0;
    
    fprintf(ASMOUT, "\t\t.data\n");
    
    for(i = 0; i < str_num; i++)
        fprintf(ASMOUT, "\t\tStr%d:  .asciiz \"%s\"\n", i, StringList[i]);   // 初始化程序中出现过的字符串
    
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
    /*if(i==0)
    {*/
        fprintf(ASMOUT, "\t\tAHHH:  .word 0\n");
        strcpy(base_data, "AHHH");
        base_address = 0;
        base_addr_offset = 0;
    /*}
    else
    {
        strcpy(base_data, table[i-1].name);   // 如果一个全局常量和变量都没有，那么这个i就是0
        base_address += 4*table[i-1].length;
        base_addr_offset = 4*table[i-1].length;
    }*/
    
    fprintf(ASMOUT, "\n");
    fprintf(ASMOUT, "\t\t.text\n");
    fprintf(ASMOUT, "\t\t.globl main\n");
    midpointer = 0;
    sregcnt = 0;
    
    while(midpointer < midnewcnt)
    {
        if(strcmp(MIDLIST[midpointer], mid_op[FUNCOP]) == 0)
        {
            if(strcmp(MIDLIST[midpointer+3], "main") == 0)
                mainFlag = 1;
            cccnt = 0;
            levelnum++;
            func_asm();
            if(reg_opt != 1)
                sortcnt();      // 将变量排序
            sregcnt++;
            tempReg = 0;
            base_address = 4 + base_addr_offset;
            func_cnt++;
        }
        midpointer += 4;
    }
    
    //if(reg_opt != 1)
        //memset(sreg, 0, sizeof(func_s_reg));
}

void func_asm()    // 以函数为单位生成目标代码
{
    // int var_num = 0;    // 函数的数据(变量和常量)个数
    int valuepara_num = 0;  //函数中出现的最大值参数的个数,由max_valuepara_num返回
    int func_type = 0;     // function的返回类型
    int i = 0;
    int position = 0;
    int para_address = 0;  // 函数参数相对栈底的地址计数
    int data_address = -12;  // 函数数据相对栈底的地址计数，从-12开始
    int sp = 0;    // sp到底应该减多少
    int sp_base = 0;   // sp基
    // int loc_reg = 0;
    int valuepara_cnt = 0;   // 值参数个数计数，存a0-a3，超过4个存内存
    int valuepara_inmmr = 16;   // 值参数超过四个，存到相对sp的地址
    int add_stacksize = 0;
    // 恢复现场空间的基址
    int recv_addr = 0;
    
    fprintf(ASMOUT, "%s:\t\n", MIDLIST[midpointer+3]);    // 先输出函数名
    if(strcmp(MIDLIST[midpointer+1], mid_op[VOIDOP]) == 0)
        func_type = 2;     // 函数类型位void
    
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
    sp_base = -data_address + 4*valuepara_num + func_stacksize[func_cnt];
    sp = sp_base;
    
    fprintf(ASMOUT, "\t\taddi $sp, $sp, %d\n", -sp_base);
    fprintf(ASMOUT, "\t\tsw $ra, %d($sp)\n", sp-4);
    fprintf(ASMOUT, "\t\tsw $fp, %d($sp)\n", sp-8);
    fprintf(ASMOUT, "\t\tmove $fp, $sp\n");      // 存储返回地址和帧指针
    sp -= 12;
    recv_addr = sp;
    
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
            fprintf(ASMOUT, "\t\tli $v1, %d\n", table[position].charval);
        else
            fprintf(ASMOUT, "\t\tli $v1, %d\n", table[position].intval);
        
        fprintf(ASMOUT, "\t\tsw $v1, %d($sp)\n", sp);
        table[position].address = sp;
        sp -= 4;
        position++;
    }
    recv_addr = sp;
    
    int if_have_variable = 0;
    
    while (table[position].type == VARIABLETYPE)     // 变量只需要更新其在符号表的位置
    {
        if_have_variable = 1;
        table[position].address += sp_base;
        position++;
    }
    
    if(if_have_variable == 1)
        recv_addr = table[position-1].address - 4;
    
    int ii = 0;      // 给引用次数最多的变量或常量分配s寄存器
    int find_opt = 0;    // 在s寄存器中找没找到这个变量
    if(reg_opt == 1)
    {
        while(ii < sreg[sregcnt].svarnum)
        {
            position = LookupTab(sreg[sregcnt].s_register[ii], 0);
            fprintf(ASMOUT, "\t\tlw $s%d, %d($sp)\n", ii, table[position].address);
            ii++;
        }
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
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $v1, %d($v1)\n", loc_t_reg[mid_reg_num][0]);
                    sprintf(temp1, "$v1");
                }
            }
            else if(isDigit(MIDLIST[midpointer+1][0]) || MIDLIST[midpointer+1][0]=='-')
            {
                fprintf(ASMOUT, "\t\tli $v1, %d\n", atoi(MIDLIST[midpointer+1]));
                sprintf(temp1, "$v1");
            }
            else if(isLetter(MIDLIST[midpointer+1][0]))
            {
                position = LookupTab(MIDLIST[midpointer+1], 0);
                if(position < tableindex[1])   // 如果是全局的
                {
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", MIDLIST[midpointer+1]);
                    fprintf(ASMOUT, "\t\tlw $v1, 0($v1)\n");
                    sprintf(temp1, "$v1");
                }
                else
                {
                    add_cnt(MIDLIST[midpointer+1]);
                    if(reg_opt == 1)
                    {
                        ii = 0;
                        find_opt = 0;
                        while(ii < sreg[sregcnt].svarnum)
                        {
                            if(strcmp(MIDLIST[midpointer+1], sreg[sregcnt].s_register[ii]) == 0)
                            {
                                find_opt = 1;
                                break;
                            }
                            ii++;
                        }
                        if(find_opt == 0)
                        {
                            fprintf(ASMOUT, "\t\tlw $v1, %d($sp)\n", table[position].address);
                            sprintf(temp1, "$v1");
                        }
                        else
                        {
                            sprintf(temp1, "$s%d", ii);
                        }
                    }
                    else
                    {
                        fprintf(ASMOUT, "\t\tlw $v1, %d($sp)\n", table[position].address);
                        sprintf(temp1, "$v1");
                    }
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
                    fprintf(ASMOUT, "\t\tla $t9, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $t9, %d($t9)\n", loc_t_reg[mid_reg_num][0]);
                    sprintf(temp2, "$t9");
                }
            }
            else if(isDigit(MIDLIST[midpointer+2][0]) || MIDLIST[midpointer+2][0]=='-')
            {
                fprintf(ASMOUT, "\t\tli $t9, %d\n", atoi(MIDLIST[midpointer+2]));
                sprintf(temp2, "$t9");
            }
            else if(isLetter(MIDLIST[midpointer+2][0]))
            {
                position = LookupTab(MIDLIST[midpointer+2], 0);
                if(position < tableindex[1])   // 如果是全局的
                {
                    fprintf(ASMOUT, "\t\tla $t9, %s\n", MIDLIST[midpointer+2]);
                    fprintf(ASMOUT, "\t\tlw $t9, 0($t9)\n");
                    sprintf(temp2, "$t9");
                }
                else
                {
                    add_cnt(MIDLIST[midpointer+2]);
                    if(reg_opt == 1)
                    {
                        ii = 0;
                        find_opt = 0;
                        while(ii < sreg[sregcnt].svarnum)
                        {
                            if(strcmp(MIDLIST[midpointer+2], sreg[sregcnt].s_register[ii]) == 0)
                            {
                                find_opt = 1;
                                break;
                            }
                            ii++;
                        }
                        if(find_opt == 0)
                        {
                            fprintf(ASMOUT, "\t\tlw $t9, %d($sp)\n", table[position].address);
                            sprintf(temp2, "$t9");
                        }
                        else
                        {
                            sprintf(temp2, "$s%d", ii);
                        }
                    }
                    else
                    {
                        fprintf(ASMOUT, "\t\tlw $t9, %d($sp)\n", table[position].address);
                        sprintf(temp2, "$t9");
                    }
                }
            }
            
            // 再处理第三个操作数
            Transfer_midreg(MIDLIST[midpointer+3]);
            if(tempReg == 8)   // 8个临时寄存器全部占满,把第一个挪走
            {
                if(moveReg < 8)
                {
                    store_on_data(moveReg);    // 把原来$t0上的数据存到内存上
                    sprintf(temp3, "$t%d", moveReg);
                    loc_t_reg[mid_reg_num][0] = moveReg;
                    t_register[moveReg] = mid_reg_num;
                    moveReg++;
                }
                else
                {
                    moveReg = 0;
                    store_on_data(moveReg);
                    sprintf(temp3, "$t%d", moveReg);
                    loc_t_reg[mid_reg_num][0] = moveReg;
                    t_register[moveReg] = mid_reg_num;
                    moveReg++;
                }
                loc_t_reg[mid_reg_num][1] = 0;
            }
            else
            {
                sprintf(temp3, "$t%d", tempReg);
                loc_t_reg[mid_reg_num][0] = tempReg;
                loc_t_reg[mid_reg_num][1] = 0;
                t_register[tempReg] = mid_reg_num;
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
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $v1, %d($v1)\n", loc_t_reg[mid_reg_num][0]);
                    sprintf(temp1, "$v1");
                }
            }
            else if(isDigit(MIDLIST[midpointer+1][0]) || MIDLIST[midpointer+1][0]=='-')
            {
                fprintf(ASMOUT, "\t\tli $v1, %d\n", atoi(MIDLIST[midpointer+1]));
                sprintf(temp1, "$v1");
            }
            else if(isLetter(MIDLIST[midpointer+1][0]))
            {
                position = LookupTab(MIDLIST[midpointer+1], 0);
                if(position < tableindex[1])   // 如果是全局的
                {
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", MIDLIST[midpointer+1]);
                    fprintf(ASMOUT, "\t\tlw $v1, 0($v1)\n");
                    sprintf(temp1, "$v1");
                }
                else
                {
                    add_cnt(MIDLIST[midpointer+1]);
                    if(reg_opt == 1)
                    {
                        ii = 0;
                        find_opt = 0;
                        while(ii < sreg[sregcnt].svarnum)
                        {
                            if(strcmp(MIDLIST[midpointer+1], sreg[sregcnt].s_register[ii]) == 0)
                            {
                                find_opt = 1;
                                break;
                            }
                            ii++;
                        }
                        if(find_opt == 0)
                        {
                            fprintf(ASMOUT, "\t\tlw $v1, %d($sp)\n", table[position].address);
                            sprintf(temp1, "$v1");
                        }
                        else
                        {
                            sprintf(temp1, "$s%d", ii);
                        }
                    }
                    else
                    {
                        fprintf(ASMOUT, "\t\tlw $v1, %d($sp)\n", table[position].address);
                        sprintf(temp1, "$v1");
                    }
                }
            }
            
            // 再处理第二个操作数
            int minus_flag = 0;
            if(MIDLIST[midpointer+2][0] != '\0')
            {
                if(MIDLIST[midpointer+2][0] == '~')
                {
                    Transfer_midreg(MIDLIST[midpointer+2]);
                    if(loc_t_reg[mid_reg_num][1]==0)
                        sprintf(temp2, "$t%d", loc_t_reg[mid_reg_num][0]);
                    else
                    {
                        fprintf(ASMOUT, "\t\tla $t9, %s\n", base_data);
                        fprintf(ASMOUT, "\t\tlw $t9, %d($t9)\n", loc_t_reg[mid_reg_num][0]);
                        sprintf(temp2, "$t9");
                    }
                }
                else if(isDigit(MIDLIST[midpointer+2][0]) || MIDLIST[midpointer+2][0]=='-')
                {
                    fprintf(ASMOUT, "\t\tli $t9, %d\n", atoi(MIDLIST[midpointer+2]));
                    sprintf(temp2, "$t9");
                }
                else if(isLetter(MIDLIST[midpointer+2][0]))
                {
                    position = LookupTab(MIDLIST[midpointer+2], 0);
                    if(position < tableindex[1])   // 如果是全局的
                    {
                        fprintf(ASMOUT, "\t\tla $t9, %s\n", MIDLIST[midpointer+2]);
                        fprintf(ASMOUT, "\t\tlw $t9, 0($t9)\n");
                        sprintf(temp2, "$t9");
                    }
                    else
                    {
                        add_cnt(MIDLIST[midpointer+2]);
                        if(reg_opt == 1)
                        {
                            ii = 0;
                            find_opt = 0;
                            while(ii < sreg[sregcnt].svarnum)
                            {
                                if(strcmp(MIDLIST[midpointer+2], sreg[sregcnt].s_register[ii]) == 0)
                                {
                                    find_opt = 1;
                                    break;
                                }
                                ii++;
                            }
                            if(find_opt == 0)
                            {
                                fprintf(ASMOUT, "\t\tlw $t9, %d($sp)\n", table[position].address);
                                sprintf(temp2, "$t9");
                            }
                            else
                            {
                                sprintf(temp2, "$s%d", ii);
                            }
                        }
                        else
                        {
                            fprintf(ASMOUT, "\t\tlw $t9, %d($sp)\n", table[position].address);
                            sprintf(temp2, "$t9");
                        }
                    }
                }
            }
            else
                minus_flag = 1;
            
            // 再处理第三个操作数
            Transfer_midreg(MIDLIST[midpointer+3]);
            if(tempReg == 8)
            {
                if(moveReg == 8)
                    moveReg = 0;
                store_on_data(moveReg);    // 把原来$t0上的数据存到内存上
                sprintf(temp3, "$t%d", moveReg);
                loc_t_reg[mid_reg_num][0] = moveReg;
                loc_t_reg[mid_reg_num][1] = 0;
                t_register[moveReg] = mid_reg_num;
                moveReg++;
            }
            else
            {
                sprintf(temp3, "$t%d", tempReg);
                loc_t_reg[mid_reg_num][0] = tempReg;
                loc_t_reg[mid_reg_num][1] = 0;
                t_register[tempReg] = mid_reg_num;   // 这么一个惊天大bug怎么一直都没测出来！！！
                tempReg++;
            }
            
            if(minus_flag == 1)
                fprintf(ASMOUT, "\t\tsub %s, $0, %s\n", temp3, temp1);
            else
                fprintf(ASMOUT, "\t\tsub %s, %s, %s\n", temp3, temp1, temp2);
        }
        else if(strcmp(MIDLIST[midpointer], mid_op[GETARRAY]) == 0)   // =[] 取数组值，长度应该乘4
        {
            // 先处理第一个操作数，即数组名
            int if_glbarray = 0;    // 是否是全局数组
            int num_or_reg = 0;    // 第二个操作数是数字还是寄存器
            int getarray_addr = 0;
            position = LookupTab(MIDLIST[midpointer+1], 0);
            if(position < tableindex[1])   // 全局数组
            {
                fprintf(ASMOUT, "\t\tla $v1, %s\n", MIDLIST[midpointer+1]);
                if_glbarray = 1;
            }
            else    // 局部数组
            {
                fprintf(ASMOUT, "\t\taddi $v1, $sp, %d\n", table[position].address);
            }
            
            // 再处理第二个操作数，即数组索引  （寄存器，数字，或标识符）
            if(isDigit(MIDLIST[midpointer+2][0]))
                getarray_addr = atoi(MIDLIST[midpointer+2])*4;
            else if(MIDLIST[midpointer+2][0] == '~')
            {
                num_or_reg = 1;
                Transfer_midreg(MIDLIST[midpointer+2]);
                if(loc_t_reg[mid_reg_num][1] == 1)
                {
                    fprintf(ASMOUT, "\t\tla $t9, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $t9, %d($t9)\n", loc_t_reg[mid_reg_num][0]);
                    fprintf(ASMOUT, "\t\tmulu $t9, $t9, 4\n");
                }
                else
                {
                    fprintf(ASMOUT, "\t\tmulu $t9, $t%d, 4\n", loc_t_reg[mid_reg_num][0]);
                }
            }
            else if(isLetter(MIDLIST[midpointer+2][0]))
            {
                num_or_reg = 1;
                position = LookupTab(MIDLIST[midpointer+2], 0);
                if(position < tableindex[1])   // 如果是全局的
                {
                    fprintf(ASMOUT, "\t\tla $t9, %s\n", MIDLIST[midpointer+2]);
                    fprintf(ASMOUT, "\t\tlw $t9, 0($t9)\n");
                    fprintf(ASMOUT, "\t\tmulu $t9, $t9, 4\n");
                }
                else
                {
                    add_cnt(MIDLIST[midpointer+2]);
                    if(reg_opt == 1)
                    {
                        ii = 0;
                        find_opt = 0;
                        while(ii < sreg[sregcnt].svarnum)
                        {
                            if(strcmp(MIDLIST[midpointer+2], sreg[sregcnt].s_register[ii]) == 0)
                            {
                                find_opt = 1;
                                break;
                            }
                            ii++;
                        }
                        if(find_opt == 0)
                        {
                            fprintf(ASMOUT, "\t\tlw $t9, %d($sp)\n", table[position].address);
                            fprintf(ASMOUT, "\t\tmulu $t9, $t9, 4\n");
                        }
                        else
                        {
                            fprintf(ASMOUT, "\t\tmulu $t9, $s%d, 4\n", ii);
                        }
                    }
                    else
                    {
                        fprintf(ASMOUT, "\t\tlw $t9, %d($sp)\n", table[position].address);
                        fprintf(ASMOUT, "\t\tmulu $t9, $t9, 4\n");
                    }
                }
            }
            
            // 最后处理第三个操作数（肯定是寄存器）
            Transfer_midreg(MIDLIST[midpointer+3]);
            if(tempReg == 8)   // 8个临时寄存器全部占满,挪走一个
            {
                if(moveReg < 8)
                {
                    store_on_data(moveReg);
                    sprintf(temp3, "$t%d", moveReg);
                    loc_t_reg[mid_reg_num][0] = moveReg;
                    t_register[moveReg] = mid_reg_num;
                    moveReg++;
                }
                else
                {
                    moveReg = 0;
                    store_on_data(moveReg);
                    sprintf(temp3, "$t%d", moveReg);
                    loc_t_reg[mid_reg_num][0] = moveReg;
                    t_register[moveReg] = mid_reg_num;
                    moveReg++;
                }
                loc_t_reg[mid_reg_num][1] = 0;
            }
            else
            {
                sprintf(temp3, "$t%d", tempReg);
                loc_t_reg[mid_reg_num][0] = tempReg;
                loc_t_reg[mid_reg_num][1] = 0;
                t_register[tempReg] = mid_reg_num;
                tempReg++;
            }
            
            if(num_or_reg == 0)
                fprintf(ASMOUT, "\t\tlw %s, %d($v1)\n", temp3, getarray_addr);
            else
            {
                fprintf(ASMOUT, "\t\tadd $v1, $v1, $t9\n");
                fprintf(ASMOUT, "\t\tlw %s, 0($v1)\n", temp3);
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
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $v1, %d($v1)\n", loc_t_reg[mid_reg_num][0]);
                    sprintf(temp1, "$v1");
                }
            }
            else if(isDigit(MIDLIST[midpointer+1][0]) || MIDLIST[midpointer+1][0]=='-')
            {
                fprintf(ASMOUT, "\t\tli $v1, %d\n", atoi(MIDLIST[midpointer+1]));
                sprintf(temp1, "$v1");
            }
            else if(isLetter(MIDLIST[midpointer+1][0]))
            {
                position = LookupTab(MIDLIST[midpointer+1], 0);
                if(position < tableindex[1])   // 如果是全局的
                {
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", MIDLIST[midpointer+1]);
                    fprintf(ASMOUT, "\t\tlw $v1, 0($v1)\n");
                    sprintf(temp1, "$v1");
                }
                else
                {
                    add_cnt(MIDLIST[midpointer+1]);
                    if(reg_opt == 1)
                    {
                        ii = 0;
                        find_opt = 0;
                        while(ii < sreg[sregcnt].svarnum)
                        {
                            if(strcmp(MIDLIST[midpointer+1], sreg[sregcnt].s_register[ii]) == 0)
                            {
                                find_opt = 1;
                                break;
                            }
                            ii++;
                        }
                        if(find_opt == 0)
                        {
                            fprintf(ASMOUT, "\t\tlw $v1, %d($sp)\n", table[position].address);
                            sprintf(temp1, "$v1");
                        }
                        else
                        {
                            sprintf(temp1, "$s%d", ii);
                        }
                    }
                    else
                    {
                        fprintf(ASMOUT, "\t\tlw $v1, %d($sp)\n", table[position].address);
                        sprintf(temp1, "$v1");
                    }
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
                    fprintf(ASMOUT, "\t\tla $t9, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $t9, %d($t9)\n", loc_t_reg[mid_reg_num][0]);
                    sprintf(temp2, "$t9");
                }
            }
            else if(isDigit(MIDLIST[midpointer+2][0]) || MIDLIST[midpointer+2][0]=='-')
            {
                fprintf(ASMOUT, "\t\tli $t9, %d\n", atoi(MIDLIST[midpointer+2]));
                sprintf(temp2, "$t9");
            }
            else if(isLetter(MIDLIST[midpointer+2][0]))
            {
                position = LookupTab(MIDLIST[midpointer+2], 0);
                if(position < tableindex[1])   // 如果是全局的
                {
                    fprintf(ASMOUT, "\t\tla $t9, %s\n", MIDLIST[midpointer+2]);
                    fprintf(ASMOUT, "\t\tlw $t9, 0($t9)\n");
                    sprintf(temp2, "$t9");
                }
                else
                {
                    add_cnt(MIDLIST[midpointer+2]);
                    if(reg_opt == 1)
                    {
                        ii = 0;
                        find_opt = 0;
                        while(ii < sreg[sregcnt].svarnum)
                        {
                            if(strcmp(MIDLIST[midpointer+2], sreg[sregcnt].s_register[ii]) == 0)
                            {
                                find_opt = 1;
                                break;
                            }
                            ii++;
                        }
                        if(find_opt == 0)
                        {
                            fprintf(ASMOUT, "\t\tlw $t9, %d($sp)\n", table[position].address);
                            sprintf(temp2, "$t9");
                        }
                        else
                        {
                            sprintf(temp2, "$s%d", ii);
                        }
                    }
                    else
                    {
                        fprintf(ASMOUT, "\t\tlw $t9, %d($sp)\n", table[position].address);
                        sprintf(temp2, "$t9");
                    }
                }
            }
            
            // 再处理第三个操作数   temp3
            Transfer_midreg(MIDLIST[midpointer+3]);
            if(tempReg == 8)   // 8个临时寄存器全部占满,把第一个挪走
            {
                if(moveReg < 8)
                {
                    store_on_data(moveReg);
                    sprintf(temp3, "$t%d", moveReg);
                    loc_t_reg[mid_reg_num][0] = moveReg;
                    t_register[moveReg] = mid_reg_num;
                    moveReg++;
                }
                else
                {
                    moveReg = 0;
                    store_on_data(moveReg);
                    sprintf(temp3, "$t%d", moveReg);
                    loc_t_reg[mid_reg_num][0] = moveReg;
                    t_register[moveReg] = mid_reg_num;
                    moveReg++;
                }
                loc_t_reg[mid_reg_num][1] = 0;
            }
            else
            {
                sprintf(temp3, "$t%d", tempReg);
                loc_t_reg[mid_reg_num][0] = tempReg;
                loc_t_reg[mid_reg_num][1] = 0;
                t_register[tempReg] = mid_reg_num;
                tempReg++;
            }
            
            fprintf(ASMOUT, "\t\tsub %s, %s, %s\n", temp3, temp1, temp2);
        }
        else if((strcmp(MIDLIST[midpointer], mid_op[BEQZOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[BNEZOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[BGTZOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[BGEZOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[BLTZOP]) == 0) || (strcmp(MIDLIST[midpointer], mid_op[BLEZOP]) == 0))     // dowhile和if的跳转
        {
            if(MIDLIST[midpointer+1][0] == '~')
            {
                Transfer_midreg(MIDLIST[midpointer+1]);   // 一定是个寄存器而且不可能被挤到内存上
                delete_wave_line(MIDLIST[midpointer+3]);
                fprintf(ASMOUT, "\t\t%s $t%d, %s\n", MIDLIST[midpointer], loc_t_reg[mid_reg_num][0], MIDLIST[midpointer+3]);
                fprintf(ASMOUT, "\t\tnop\n");
                tempReg = 0;
                base_address = 4 + base_addr_offset;
            }
            else if(isDigit(MIDLIST[midpointer+1][0]) || MIDLIST[midpointer+1][0]=='-')   // 数字
            {
                delete_wave_line(MIDLIST[midpointer+3]);
                fprintf(ASMOUT, "\t\tli $t8, %d\n", atoi(MIDLIST[midpointer+1]));
                fprintf(ASMOUT, "\t\t%s $t8, %s\n", MIDLIST[midpointer], MIDLIST[midpointer+3]);
                fprintf(ASMOUT, "\t\tnop\n");
            }
            else if(isLetter(MIDLIST[midpointer+1][0]))
            {
                position = LookupTab(MIDLIST[midpointer+1], 0);
                delete_wave_line(MIDLIST[midpointer+3]);
                if(position < tableindex[1])
                {
                    fprintf(ASMOUT, "\t\tla $t8, %s\n", MIDLIST[midpointer+1]);
                    fprintf(ASMOUT, "\t\tlw $t8, 0($t8)\n");
                    fprintf(ASMOUT, "\t\t%s $t8, %s\n", MIDLIST[midpointer], MIDLIST[midpointer+3]);
                    fprintf(ASMOUT, "\t\tnop\n");
                }
                else
                {
                    add_cnt(MIDLIST[midpointer+1]);
                    if(reg_opt == 1)
                    {
                        ii = 0;
                        find_opt = 0;
                        while(ii < sreg[sregcnt].svarnum)
                        {
                            if(strcmp(MIDLIST[midpointer+1], sreg[sregcnt].s_register[ii]) == 0)
                            {
                                find_opt = 1;
                                break;
                            }
                            ii++;
                        }
                        if(find_opt == 0)
                        {
                            fprintf(ASMOUT, "\t\tlw $t8, %d($sp)\n", table[position].address);
                            fprintf(ASMOUT, "\t\t%s $t8, %s\n", MIDLIST[midpointer], MIDLIST[midpointer+3]);
                            fprintf(ASMOUT, "\t\tnop\n");
                        }
                        else
                        {
                            fprintf(ASMOUT, "\t\t%s $s%d, %s\n", MIDLIST[midpointer], ii, MIDLIST[midpointer+3]);
                            fprintf(ASMOUT, "\t\tnop\n");
                        }
                    }
                    else
                    {
                        fprintf(ASMOUT, "\t\tlw $t8, %d($sp)\n", table[position].address);
                        fprintf(ASMOUT, "\t\t%s $t8, %s\n", MIDLIST[midpointer], MIDLIST[midpointer+3]);
                        fprintf(ASMOUT, "\t\tnop\n");
                    }
                }
            }
        }
        else if(strcmp(MIDLIST[midpointer], mid_op[SETLABELOP]) == 0)   // setlabel
        {
            delete_wave_line(MIDLIST[midpointer+3]);
            fprintf(ASMOUT, "%s:\t\n", MIDLIST[midpointer+3]);
        }
        else if(strcmp(MIDLIST[midpointer], mid_op[JUMPOP]) == 0)    // jump
        {
            delete_wave_line(MIDLIST[midpointer+3]);
            fprintf(ASMOUT, "\t\tj %s\n", MIDLIST[midpointer+3]);
            fprintf(ASMOUT, "\t\tnop\n");
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
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $v1, %d($v1)\n", loc_t_reg[mid_reg_num][0]);
                    sprintf(temp1, "$v1");
                }
            }
            else if(isDigit(MIDLIST[midpointer+1][0]) || MIDLIST[midpointer+1][0]=='-')
            {
                fprintf(ASMOUT, "\t\tli $v1, %d\n", atoi(MIDLIST[midpointer+1]));
                sprintf(temp1, "$v1");
            }
            else if(isLetter(MIDLIST[midpointer+1][0]))
            {
                position = LookupTab(MIDLIST[midpointer+1], 0);
                if(position < tableindex[1])   // 如果是全局的
                {
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", MIDLIST[midpointer+1]);
                    fprintf(ASMOUT, "\t\tlw $v1, 0($v1)\n");
                    sprintf(temp1, "$v1");
                }
                else
                {
                    add_cnt(MIDLIST[midpointer+1]);
                    if(reg_opt == 1)
                    {
                        ii = 0;
                        find_opt = 0;
                        while(ii < sreg[sregcnt].svarnum)
                        {
                            if(strcmp(MIDLIST[midpointer+1], sreg[sregcnt].s_register[ii]) == 0)
                            {
                                find_opt = 1;
                                break;
                            }
                            ii++;
                        }
                        if(find_opt == 0)
                        {
                            fprintf(ASMOUT, "\t\tlw $v1, %d($sp)\n", table[position].address);
                            sprintf(temp1, "$v1");
                        }
                        else
                        {
                            sprintf(temp1, "$s%d", ii);
                        }
                    }
                    else
                    {
                        fprintf(ASMOUT, "\t\tlw $v1, %d($sp)\n", table[position].address);
                        sprintf(temp1, "$v1");
                    }
                }
            }
            
            position = LookupTab(MIDLIST[midpointer+3], 0);
            if(position < tableindex[1])
            {
                fprintf(ASMOUT, "\t\tla $t9, %s\n", MIDLIST[midpointer+3]);
                fprintf(ASMOUT, "\t\tsw %s, 0($t9)\n", temp1);
            }
            else
            {
                add_cnt(MIDLIST[midpointer+3]);
                if(reg_opt == 1)
                {
                    ii = 0;
                    find_opt = 0;
                    while(ii < sreg[sregcnt].svarnum)
                    {
                        if(strcmp(MIDLIST[midpointer+3], sreg[sregcnt].s_register[ii]) == 0)
                        {
                            find_opt = 1;
                            break;
                        }
                        ii++;
                    }
                    if(find_opt == 0)
                    {
                        fprintf(ASMOUT, "\t\taddi $t9, $sp, %d\n", table[position].address);
                        fprintf(ASMOUT, "\t\tsw %s, 0($t9)\n", temp1);
                    }
                    else
                    {
                        fprintf(ASMOUT, "\t\tmove $s%d, %s\n", ii, temp1);
                        //fprintf(ASMOUT, "\t\taddi $t9, $sp, %d\n", table[position].address);
                    }
                }
                else
                {
                    fprintf(ASMOUT, "\t\taddi $t9, $sp, %d\n", table[position].address);
                    fprintf(ASMOUT, "\t\tsw %s, 0($t9)\n", temp1);
                }
            }
            tempReg = 0;
            base_address = 4 + base_addr_offset;
        }
        else if(strcmp(MIDLIST[midpointer], mid_op[BNEOP]) == 0) // bne  第二个操作数一定是数字
        {
            // 先处理第一个操作数  temp1
            if(MIDLIST[midpointer+1][0] == '~')
            {
                Transfer_midreg(MIDLIST[midpointer+1]);
                if(loc_t_reg[mid_reg_num][1]==0)
                    sprintf(temp1, "$t%d", loc_t_reg[mid_reg_num][0]);
                else
                {
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $v1, %d($v1)\n", loc_t_reg[mid_reg_num][0]);
                    sprintf(temp1, "$v1");
                }
            }
            else if(isDigit(MIDLIST[midpointer+1][0]) || MIDLIST[midpointer+1][0]=='-')
            {
                fprintf(ASMOUT, "\t\tli $v1, %d\n", atoi(MIDLIST[midpointer+1]));
                sprintf(temp1, "$v1");
            }
            else if(isLetter(MIDLIST[midpointer+1][0]))
            {
                position = LookupTab(MIDLIST[midpointer+1], 0);
                if(position < tableindex[1])   // 如果是全局的
                {
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", MIDLIST[midpointer+1]);
                    fprintf(ASMOUT, "\t\tlw $v1, 0($v1)\n");
                    sprintf(temp1, "$v1");
                }
                else
                {
                    add_cnt(MIDLIST[midpointer+1]);
                    if(reg_opt == 1)
                    {
                        ii = 0;
                        find_opt = 0;
                        while(ii < sreg[sregcnt].svarnum)
                        {
                            if(strcmp(MIDLIST[midpointer+1], sreg[sregcnt].s_register[ii]) == 0)
                            {
                                find_opt = 1;
                                break;
                            }
                            ii++;
                        }
                        if(find_opt == 0)
                        {
                            fprintf(ASMOUT, "\t\tlw $v1, %d($sp)\n", table[position].address);
                            sprintf(temp1, "$v1");
                        }
                        else
                        {
                            sprintf(temp1, "$s%d", ii);
                        }
                    }
                    else
                    {
                        fprintf(ASMOUT, "\t\tlw $v1, %d($sp)\n", table[position].address);
                        sprintf(temp1, "$v1");
                    }
                }
            }
            
            delete_wave_line(MIDLIST[midpointer+3]);
            fprintf(ASMOUT, "\t\tbne %s, %d, %s\n", temp1, atoi(MIDLIST[midpointer+2]), MIDLIST[midpointer+3]);
            fprintf(ASMOUT, "\t\tnop\n");
            tempReg = 0;
            base_address = 4 + base_addr_offset;
        }
        else if(strcmp(MIDLIST[midpointer], mid_op[ASSIGNARRAY]) == 0)   // []=   给数组赋值
        {
            // 先处理第三个操作数，就是要给数组赋的那个值    temp1   $v1
            if(MIDLIST[midpointer+3][0] == '~')
            {
                Transfer_midreg(MIDLIST[midpointer+3]);
                if(loc_t_reg[mid_reg_num][1]==0)
                    sprintf(temp1, "$t%d", loc_t_reg[mid_reg_num][0]);
                else
                {
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $v1, %d($v1)\n", loc_t_reg[mid_reg_num][0]);
                    sprintf(temp1, "$v1");
                }
            }
            else if(isDigit(MIDLIST[midpointer+3][0]) || MIDLIST[midpointer+3][0]=='-')
            {
                fprintf(ASMOUT, "\t\tli $v1, %d\n", atoi(MIDLIST[midpointer+3]));
                sprintf(temp1, "$v1");
            }
            else if(isLetter(MIDLIST[midpointer+3][0]))
            {
                position = LookupTab(MIDLIST[midpointer+3], 0);
                if(position < tableindex[1])   // 如果是全局的
                {
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", MIDLIST[midpointer+3]);
                    fprintf(ASMOUT, "\t\tlw $v1, 0($v1)\n");
                    sprintf(temp1, "$v1");
                }
                else
                {
                    add_cnt(MIDLIST[midpointer+3]);
                    if(reg_opt == 1)
                    {
                        ii = 0;
                        find_opt = 0;
                        while(ii < sreg[sregcnt].svarnum)
                        {
                            if(strcmp(MIDLIST[midpointer+3], sreg[sregcnt].s_register[ii]) == 0)
                            {
                                find_opt = 1;
                                break;
                            }
                            ii++;
                        }
                        if(find_opt == 0)
                        {
                            fprintf(ASMOUT, "\t\tlw $v1, %d($sp)\n", table[position].address);
                            sprintf(temp1, "$v1");
                        }
                        else
                        {
                            sprintf(temp1, "$s%d", ii);
                        }
                    }
                    else
                    {
                        fprintf(ASMOUT, "\t\tlw $v1, %d($sp)\n", table[position].address);
                        sprintf(temp1, "$v1");
                    }
                }
            }
            
            // 先把数组的基地址load到$t9
            position = LookupTab(MIDLIST[midpointer+1], 0);
            if(position < tableindex[1])   // 全局数组
                fprintf(ASMOUT, "\t\tla $t9, %s\n", MIDLIST[midpointer+1]);
            else    // 局部数组
                fprintf(ASMOUT, "\t\taddi $t9, $sp, %d\n", table[position].address);
            
            // 第二个操作数，标识符，数字，或寄存器
            if(MIDLIST[midpointer+2][0] == '~')
            {
                Transfer_midreg(MIDLIST[midpointer+2]);
                if(loc_t_reg[mid_reg_num][1]==0)
                    sprintf(temp2, "$t%d", loc_t_reg[mid_reg_num][0]);
                else
                {
                    if(moveReg == 8)
                        moveReg = 0;
                    
                    store_on_data(moveReg);    // 把x号寄存器的东西存回内存
                    fprintf(ASMOUT, "\t\tla $t8, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $t%d, %d($t8)\n", moveReg, loc_t_reg[mid_reg_num][0]);
                    loc_t_reg[mid_reg_num][0] = moveReg;
                    loc_t_reg[mid_reg_num][1] = 0;    // 写回了寄存器
                    sprintf(temp2, "$t%d", moveReg);
                    moveReg++;
                }
                fprintf(ASMOUT, "\t\tmulu $t8, %s, 4\n", temp2);
                fprintf(ASMOUT, "\t\tadd $t9, $t9, $t8\n");
            }
            else if(isDigit(MIDLIST[midpointer+2][0]))    // 不可能是负数
                fprintf(ASMOUT, "\t\taddi $t9, $t9, %d\n", atoi(MIDLIST[midpointer+2])*4);
            else if(isLetter(MIDLIST[midpointer+2][0]))
            {
                position = LookupTab(MIDLIST[midpointer+2], 0);
                if(position < tableindex[1])   // 如果是全局的
                    fprintf(ASMOUT, "\t\tlw $t8, %s\n", MIDLIST[midpointer+2]);
                else
                {
                    add_cnt(MIDLIST[midpointer+2]);
                    if(reg_opt == 1)
                    {
                        ii = 0;
                        find_opt = 0;
                        while(ii < sreg[sregcnt].svarnum)
                        {
                            if(strcmp(MIDLIST[midpointer+2], sreg[sregcnt].s_register[ii]) == 0)
                            {
                                find_opt = 1;
                                break;
                            }
                            ii++;
                        }
                        if(find_opt == 0)
                            fprintf(ASMOUT, "\t\tlw $t8, %d($sp)\n", table[position].address);
                        else
                            fprintf(ASMOUT, "\t\tmove $t8, $s%d\n", ii);
                    }
                    else
                        fprintf(ASMOUT, "\t\tlw $t8, %d($sp)\n", table[position].address);
                }
                fprintf(ASMOUT, "\t\tmulu $t8, $t8, 4\n");
                fprintf(ASMOUT, "\t\tadd $t9, $t9, $t8\n");
            }
            
            fprintf(ASMOUT, "\t\tsw %s, 0($t9)\n", temp1);
            /*tempReg = 0;
            base_address = 4 + base_addr_offset;*/
        }
        else if(strcmp(MIDLIST[midpointer], mid_op[SCANFOP]) == 0)   // scanf
        {
            position = LookupTab(MIDLIST[midpointer+1], 0);
            if(atoi(MIDLIST[midpointer+3]) == 0)   // 读取整数
            {
                fprintf(ASMOUT, "\t\tli $v0, 5\n");
                fprintf(ASMOUT, "\t\tsyscall\n");
                if(position < tableindex[1])     //   全局变量
                {
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", MIDLIST[midpointer+1]);
                    fprintf(ASMOUT, "\t\tsw $v0, 0($v1)\n");
                }
                else
                {
                    add_cnt(MIDLIST[midpointer+1]);
                    if(reg_opt == 1)
                    {
                        ii = 0;
                        find_opt = 0;
                        while(ii < sreg[sregcnt].svarnum)
                        {
                            if(strcmp(MIDLIST[midpointer+1], sreg[sregcnt].s_register[ii]) == 0)
                            {
                                find_opt = 1;
                                break;
                            }
                            ii++;
                        }
                        if(find_opt == 0)
                            fprintf(ASMOUT, "\t\tsw $v0, %d($sp)\n", table[position].address);
                        else
                        {
                            fprintf(ASMOUT, "\t\tmove $s%d, $v0\n", ii);
                            // fprintf(ASMOUT, "\t\tsw $v0, %d($sp)\n", table[position].address);
                        }
                    }
                    else
                        fprintf(ASMOUT, "\t\tsw $v0, %d($sp)\n", table[position].address);
                }
            }
            else   // 读取字符
            {
                fprintf(ASMOUT, "\t\tli $v0, 12\n");
                fprintf(ASMOUT, "\t\tsyscall\n");
                if(position < tableindex[1])     //   全局变量
                {
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", MIDLIST[midpointer+1]);
                    fprintf(ASMOUT, "\t\tsw $v0, 0($v1)\n");
                }
                else
                {
                    add_cnt(MIDLIST[midpointer+1]);
                    if(reg_opt == 1)
                    {
                        ii = 0;
                        find_opt = 0;
                        while(ii < sreg[sregcnt].svarnum)
                        {
                            if(strcmp(MIDLIST[midpointer+1], sreg[sregcnt].s_register[ii]) == 0)
                            {
                                find_opt = 1;
                                break;
                            }
                            ii++;
                        }
                        if(find_opt == 0)
                            fprintf(ASMOUT, "\t\tsw $v0, %d($sp)\n", table[position].address);
                        else
                        {
                            fprintf(ASMOUT, "\t\tmove $s%d, $v0\n", ii);
                            // fprintf(ASMOUT, "\t\tsw $v0, %d($sp)\n", table[position].address);
                        }
                    }
                    else
                        fprintf(ASMOUT, "\t\tsw $v0, %d($sp)\n", table[position].address);
                }
            }
            tempReg = 0;
            base_address = 4 + base_addr_offset;
        }
        else if(strcmp(MIDLIST[midpointer], mid_op[PRINTFOP]) == 0)   // printf
        {
            int if_has_string = 0;
            // 有字符串先输出字符串
            if(round == 1)
            {
                if((MIDLIST[midpointer+1][0] == '~') && (MIDLIST[midpointer+1][1] == 's'))    // 第一个操作数是字符串[我怎么能这么傻逼呢？？？]   第一遍就把label和str的第一个字母变成大写,第二遍什么都不做
                {
                    if_has_string = 1;
                    fprintf(ASMOUT, "\t\tli $v0, 4\n");
                    delete_wave_line(MIDLIST[midpointer+1]);  
                    fprintf(ASMOUT, "\t\tla $a0, %s\n", MIDLIST[midpointer+1]);
                    fprintf(ASMOUT, "\t\tsyscall\n");
                }
            }
            else
            {
                if(MIDLIST[midpointer+1][0] == 'S')    // 第一个操作数是字符串
                {
                    if_has_string = 1;
                    fprintf(ASMOUT, "\t\tli $v0, 4\n");
                    delete_wave_line(MIDLIST[midpointer+1]);
                    fprintf(ASMOUT, "\t\tla $a0, %s\n", MIDLIST[midpointer+1]);
                    fprintf(ASMOUT, "\t\tsyscall\n");
                }
            }
            
            if(MIDLIST[midpointer+3][0] != '\0')   // 有要输出的表达式
            {
                if(if_has_string == 0)   // 要输出的是第一个操作数 存在temp1
                {
                    if(MIDLIST[midpointer+1][0] == '~')
                    {
                        Transfer_midreg(MIDLIST[midpointer+1]);
                        if(loc_t_reg[mid_reg_num][1]==0)
                            sprintf(temp1, "$t%d", loc_t_reg[mid_reg_num][0]);
                        else
                        {
                            fprintf(ASMOUT, "\t\tla $t8, %s\n", base_data);
                            fprintf(ASMOUT, "\t\tlw $t8, %d($t8)\n", loc_t_reg[mid_reg_num][0]);
                            sprintf(temp1, "$t8");
                        }
                    }
                    else if(isDigit(MIDLIST[midpointer+1][0]) || MIDLIST[midpointer+1][0]=='-')
                    {
                        fprintf(ASMOUT, "\t\tli $t8, %d\n", atoi(MIDLIST[midpointer+1]));
                        sprintf(temp1, "$t8");
                    }
                    else if(isLetter(MIDLIST[midpointer+1][0]))
                    {
                        position = LookupTab(MIDLIST[midpointer+1], 0);
                        if(position < tableindex[1])   // 如果是全局的
                        {
                            fprintf(ASMOUT, "\t\tla $t8, %s\n", MIDLIST[midpointer+1]);
                            fprintf(ASMOUT, "\t\tlw $t8, 0($t8)\n");
                            sprintf(temp1, "$t8");
                        }
                        else
                        {
                            add_cnt(MIDLIST[midpointer+1]);
                            if(reg_opt == 1)
                            {
                                ii = 0;
                                find_opt = 0;
                                while(ii < sreg[sregcnt].svarnum)
                                {
                                    if(strcmp(MIDLIST[midpointer+1], sreg[sregcnt].s_register[ii]) == 0)
                                    {
                                        find_opt = 1;
                                        break;
                                    }
                                    ii++;
                                }
                                if(find_opt == 0)
                                {
                                    fprintf(ASMOUT, "\t\tlw $t8, %d($sp)\n", table[position].address);
                                    sprintf(temp1, "$t8");
                                }
                                else
                                    sprintf(temp1, "$s%d", ii);
                            }
                            else
                            {
                                fprintf(ASMOUT, "\t\tlw $t8, %d($sp)\n", table[position].address);
                                sprintf(temp1, "$t8");
                            }
                        }
                    }
                    
                    if(atoi(MIDLIST[midpointer+3]) == 0)   // 输出整数
                    {
                        fprintf(ASMOUT, "\t\tli $v0, 1\n");
                        fprintf(ASMOUT, "\t\tmove $a0, %s\n", temp1);
                        fprintf(ASMOUT, "\t\tsyscall\n");
                    }
                    else    // 输出字符
                    {
                        fprintf(ASMOUT, "\t\tli $v0, 11\n");
                        fprintf(ASMOUT, "\t\tmove $a0, %s\n", temp1);
                        fprintf(ASMOUT, "\t\tsyscall\n");
                    }
                }
                else    // 要输出的是第二个操作数
                {
                    if(MIDLIST[midpointer+2][0] == '~')
                    {
                        Transfer_midreg(MIDLIST[midpointer+2]);
                        if(loc_t_reg[mid_reg_num][1]==0)
                            sprintf(temp1, "$t%d", loc_t_reg[mid_reg_num][0]);
                        else
                        {
                            fprintf(ASMOUT, "\t\tla $t8, %s\n", base_data);
                            fprintf(ASMOUT, "\t\tlw $t8, %d($t8)\n", loc_t_reg[mid_reg_num][0]);
                            sprintf(temp1, "$t8");
                        }
                    }
                    else if(isDigit(MIDLIST[midpointer+2][0]) || MIDLIST[midpointer+2][0]=='-')
                    {
                        fprintf(ASMOUT, "\t\tli $t8, %d\n", atoi(MIDLIST[midpointer+2]));
                        sprintf(temp1, "$t8");
                    }
                    else if(isLetter(MIDLIST[midpointer+2][0]))
                    {
                        position = LookupTab(MIDLIST[midpointer+2], 0);
                        if(position < tableindex[1])   // 如果是全局的
                        {
                            fprintf(ASMOUT, "\t\tla $t8, %s\n", MIDLIST[midpointer+2]);
                            fprintf(ASMOUT, "\t\tlw $t8, 0($t8)\n");
                            sprintf(temp1, "$t8");
                        }
                        else
                        {
                            add_cnt(MIDLIST[midpointer+2]);
                            if(reg_opt == 1)
                            {
                                ii = 0;
                                find_opt = 0;
                                while(ii < sreg[sregcnt].svarnum)
                                {
                                    if(strcmp(MIDLIST[midpointer+2], sreg[sregcnt].s_register[ii]) == 0)
                                    {
                                        find_opt = 1;
                                        break;
                                    }
                                    ii++;
                                }
                                if(find_opt == 0)
                                {
                                    fprintf(ASMOUT, "\t\tlw $t8, %d($sp)\n", table[position].address);
                                    sprintf(temp1, "$t8");
                                }
                                else
                                    sprintf(temp1, "$s%d", ii);
                            }
                            else
                            {
                                fprintf(ASMOUT, "\t\tlw $t8, %d($sp)\n", table[position].address);
                                sprintf(temp1, "$t8");
                            }
                        }
                    }
                    
                    if(atoi(MIDLIST[midpointer+3]) == 0)   // 输出整数
                    {
                        fprintf(ASMOUT, "\t\tli $v0, 1\n");
                        fprintf(ASMOUT, "\t\tmove $a0, %s\n", temp1);
                        fprintf(ASMOUT, "\t\tsyscall\n");
                    }
                    else    // 输出字符
                    {
                        fprintf(ASMOUT, "\t\tli $v0, 11\n");
                        fprintf(ASMOUT, "\t\tmove $a0, %s\n", temp1);
                        fprintf(ASMOUT, "\t\tsyscall\n");
                    }
                }
            }
            tempReg = 0;
            base_address = 4 + base_addr_offset;
        }
        else if(strcmp(MIDLIST[midpointer], mid_op[RETURNOP]) == 0)   // return
        {
            if(MIDLIST[midpointer+3][0] != '\0')   // 有返回值
            {
                if(MIDLIST[midpointer+3][0] == '~')
                {
                    Transfer_midreg(MIDLIST[midpointer+3]);
                    if(loc_t_reg[mid_reg_num][1]==0)
                        sprintf(temp1, "$t%d", loc_t_reg[mid_reg_num][0]);
                    else
                    {
                        fprintf(ASMOUT, "\t\tla $t8, %s\n", base_data);
                        fprintf(ASMOUT, "\t\tlw $t8, %d($t8)\n", loc_t_reg[mid_reg_num][0]);
                        sprintf(temp1, "$t8");
                    }
                }
                else if(isDigit(MIDLIST[midpointer+3][0]) || MIDLIST[midpointer+3][0]=='-')
                {
                    fprintf(ASMOUT, "\t\tli $t8, %d\n", atoi(MIDLIST[midpointer+3]));
                    sprintf(temp1, "$t8");
                }
                else if(isLetter(MIDLIST[midpointer+3][0]))
                {
                    position = LookupTab(MIDLIST[midpointer+3], 0);
                    if(position < tableindex[1])   // 如果是全局的
                    {
                        fprintf(ASMOUT, "\t\tla $t8, %s\n", MIDLIST[midpointer+3]);
                        fprintf(ASMOUT, "\t\tlw $t8, 0($t8)\n");
                        sprintf(temp1, "$t8");
                    }
                    else
                    {
                        add_cnt(MIDLIST[midpointer+3]);
                        if(reg_opt == 1)
                        {
                            ii = 0;
                            find_opt = 0;
                            while(ii < sreg[sregcnt].svarnum)
                            {
                                if(strcmp(MIDLIST[midpointer+3], sreg[sregcnt].s_register[ii]) == 0)
                                {
                                    find_opt = 1;
                                    break;
                                }
                                ii++;
                            }
                            if(find_opt == 0)
                            {
                                fprintf(ASMOUT, "\t\tlw $t8, %d($sp)\n", table[position].address);
                                sprintf(temp1, "$t8");
                            }
                            else
                            {
                                sprintf(temp1, "$s%d", ii);
                            }
                        }
                        else
                        {
                            fprintf(ASMOUT, "\t\tlw $t8, %d($sp)\n", table[position].address);
                            sprintf(temp1, "$t8");
                        }
                    }
                }
                
                fprintf(ASMOUT, "\t\tmove $v0, %s\n", temp1);
            }
            
            if(mainFlag == 0)  // main函数的return语句不用管
            {
                fprintf(ASMOUT, "\t\tmove $sp, $fp\n");
                fprintf(ASMOUT, "\t\tlw $ra, %d($sp)\n", sp_base-4);
                fprintf(ASMOUT, "\t\tlw $fp, %d($sp)\n", sp_base-8);
                fprintf(ASMOUT, "\t\taddi $sp, $sp, %d\n", sp_base);
                fprintf(ASMOUT, "\t\tjr $ra\n");
                fprintf(ASMOUT, "\t\tnop\n");
            }
            tempReg = 0;
            base_address = 4 + base_addr_offset;
        }
        else if(strcmp(MIDLIST[midpointer], mid_op[VALUEPARAOP]) == 0)   // valueparameter
        {
            if(MIDLIST[midpointer+3][0] == '~')   // 第三个操作数
            {
                Transfer_midreg(MIDLIST[midpointer+3]);
                if(loc_t_reg[mid_reg_num][1]==0)    // 就存在寄存器里
                {
                    if(valuepara_cnt < 4)
                        fprintf(ASMOUT, "\t\tmove $a%d, $t%d\n", valuepara_cnt++, loc_t_reg[mid_reg_num][0]);
                    else
                    {
                        fprintf(ASMOUT, "\t\tsw $t%d, %d($sp)\n", loc_t_reg[mid_reg_num][0], valuepara_inmmr);
                        valuepara_inmmr += 4;
                    }
                }
                else    // 被挤到了内存上
                {
                    fprintf(ASMOUT, "\t\tla $t8, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $t8, %d($t8)\n", loc_t_reg[mid_reg_num][0]);
                    sprintf(temp1, "$t8");
                    if(valuepara_cnt < 4)
                        fprintf(ASMOUT, "\t\tmove $a%d, $t8\n", valuepara_cnt++);
                    else
                    {
                        fprintf(ASMOUT, "\t\tsw $t8, %d($sp)\n", valuepara_inmmr);
                        valuepara_inmmr += 4;
                    }
                }
            }
            else if(isDigit(MIDLIST[midpointer+3][0]) || MIDLIST[midpointer+3][0]=='-')
            {
                if(valuepara_cnt < 4)
                    fprintf(ASMOUT, "\t\tli $a%d, %d\n", valuepara_cnt++, atoi(MIDLIST[midpointer+3]));
                else
                {
                    fprintf(ASMOUT, "\t\tli $t8, %d\n", atoi(MIDLIST[midpointer+3]));
                    fprintf(ASMOUT, "\t\tsw $t8, %d($sp)\n", valuepara_inmmr);
                    valuepara_inmmr += 4;
                }
            }
            else if(isLetter(MIDLIST[midpointer+3][0]))
            {
                position = LookupTab(MIDLIST[midpointer+3], 0);
                if(position < tableindex[1])   // 如果是全局的
                {
                    fprintf(ASMOUT, "\t\tla $t8, %s\n", MIDLIST[midpointer+3]);
                    fprintf(ASMOUT, "\t\tlw $t8, 0($t8)\n");
                    if(valuepara_cnt < 4)
                        fprintf(ASMOUT, "\t\tmove $a%d, $t8\n", valuepara_cnt++);
                    else
                    {
                        fprintf(ASMOUT, "\t\tsw $t8, %d($sp)\n", valuepara_inmmr);
                        valuepara_inmmr += 4;
                    }
                }
                else
                {
                    add_cnt(MIDLIST[midpointer+3]);
                    if(reg_opt == 1)
                    {
                        ii = 0;
                        find_opt = 0;
                        while(ii < sreg[sregcnt].svarnum)
                        {
                            if(strcmp(MIDLIST[midpointer+3], sreg[sregcnt].s_register[ii]) == 0)
                            {
                                find_opt = 1;
                                break;
                            }
                            ii++;
                        }
                        if(find_opt == 0)
                        {
                            fprintf(ASMOUT, "\t\tlw $t8, %d($sp)\n", table[position].address);
                            if(valuepara_cnt < 4)
                                fprintf(ASMOUT, "\t\tmove $a%d, $t8\n", valuepara_cnt++);
                            else
                            {
                                fprintf(ASMOUT, "\t\tsw $t8, %d($sp)\n", valuepara_inmmr);
                                valuepara_inmmr += 4;
                            }
                        }
                        else
                        {
                            if(valuepara_cnt < 4)
                                fprintf(ASMOUT, "\t\tmove $a%d, $s%d\n", valuepara_cnt++, ii);
                            else
                            {
                                fprintf(ASMOUT, "\t\tsw $s%d, %d($sp)\n", ii, valuepara_inmmr);
                                valuepara_inmmr += 4;
                            }
                        }
                    }
                    else
                    {
                        fprintf(ASMOUT, "\t\tlw $t8, %d($sp)\n", table[position].address);
                        if(valuepara_cnt < 4)
                            fprintf(ASMOUT, "\t\tmove $a%d, $t8\n", valuepara_cnt++);
                        else
                        {
                            fprintf(ASMOUT, "\t\tsw $t8, %d($sp)\n", valuepara_inmmr);
                            valuepara_inmmr += 4;
                        }
                    }
                }
            }
            // tempReg = 0;
            // base_address = 4 + base_addr_offset;
        }
        else if(strcmp(MIDLIST[midpointer], mid_op[CALLOP]) == 0)
        {
            int tempvalue = 0;
            if(round == 1)
            {
                add_stacksize = tempReg*4 + (base_address - 4 - base_addr_offset) + 32;   //4*sreg[sregcnt].svarnum
                if(add_stacksize > func_stacksize[func_cnt])
                    func_stacksize[func_cnt] = add_stacksize;
            }
            else
            {
                tempvalue = recv_addr;
                for (i=0; i<tempReg; i++)    // 保存现场
                {
                    fprintf(ASMOUT, "\t\tsw $t%d, %d($sp)\n", i, tempvalue);
                    tempvalue -= 4;
                }
                for (i=4; i<=base_address - 4 - base_addr_offset; i+=4)
                {
                    fprintf(ASMOUT, "\t\tla $v1, %s\n", base_data);
                    fprintf(ASMOUT, "\t\tlw $t8, %d($v1)\n", i);
                    fprintf(ASMOUT, "\t\tsw $t8, %d($sp)\n", tempvalue);
                    tempvalue -= 4;
                }
                if(reg_opt == 1)
                {
                    for(i=0; i<sreg[sregcnt].svarnum; i++)
                    {
                        fprintf(ASMOUT, "\t\tsw $s%d, %d($sp)\n", i, tempvalue);
                        tempvalue -= 4;
                    }
                }
            }
            
            fprintf(ASMOUT, "\t\tjal %s\n", MIDLIST[midpointer+1]);
            fprintf(ASMOUT, "\t\tnop\n");
            
            tempvalue = recv_addr;
            for (i=0; i<tempReg; i++)    // 恢复现场
            {
                fprintf(ASMOUT, "\t\tlw $t%d, %d($sp)\n", i, tempvalue);
                tempvalue -= 4;
            }
            for (i=4; i<=base_address - 4 - base_addr_offset; i+=4)
            {
                fprintf(ASMOUT, "\t\tlw $t8, %d($sp)\n", tempvalue);
                fprintf(ASMOUT, "\t\tla $v1, %s\n", base_data);
                fprintf(ASMOUT, "\t\tsw $t8, %d($v1)\n", i);
                tempvalue -= 4;
            }
            if(reg_opt == 1)
            {
                for(i=0; i<sreg[sregcnt].svarnum; i++)
                {
                    fprintf(ASMOUT, "\t\tlw $s%d, %d($sp)\n", i, tempvalue);
                    tempvalue -= 4;
                }
            }
            
            if(MIDLIST[midpointer+3][0] != '\0')   // 有返回值
            {
                Transfer_midreg(MIDLIST[midpointer+3]);
                if(tempReg == 8)   // 8个临时寄存器全部占满,把第一个挪走
                {
                    if(moveReg == 8)
                        moveReg = 0;
                    store_on_data(moveReg);    // 把原来$t0上的数据存到内存上
                    sprintf(temp3, "$t%d", moveReg);
                    loc_t_reg[mid_reg_num][0] = moveReg;
                    loc_t_reg[mid_reg_num][1] = 0;
                    moveReg++;
                }
                else
                {
                    sprintf(temp3, "$t%d", tempReg);
                    loc_t_reg[mid_reg_num][0] = tempReg;
                    loc_t_reg[mid_reg_num][1] = 0;
                    tempReg++;
                }
                fprintf(ASMOUT, "\t\tmove %s, $v0\n", temp3);
            }
            
            valuepara_cnt = 0;
            valuepara_inmmr = 16;
        }
        midpointer += 4;
    }
    
    if(mainFlag == 0 && func_type == 2)
    {
        fprintf(ASMOUT, "\t\tmove $sp, $fp\n");
        fprintf(ASMOUT, "\t\tlw $ra, %d($sp)\n", sp_base-4);
        fprintf(ASMOUT, "\t\tlw $fp, %d($sp)\n", sp_base-8);
        fprintf(ASMOUT, "\t\taddi $sp, $sp, %d\n", sp_base);
        fprintf(ASMOUT, "\t\tjr $ra\n");
        fprintf(ASMOUT, "\t\tnop\n");
    }
}


void add_cnt(char *name)
{
    int i = 0;
    int find = 0;
    int pos = 0;
    
    while(i < cccnt)
    {
        if(strcmp(name, cnt_array[i].varname) == 0)
        {
            pos = i;
            find = 1;
            break;
        }
        i++;
    }
    
    if(find == 1)
        cnt_array[pos].cnt++;
    else
    {
        strcpy(cnt_array[cccnt].varname, name);
        cnt_array[cccnt].cnt = 1;
        cccnt++;
    }
}

void sortcnt()     // 针对引用计数对变量们排序
{
    int i = 0;
    int j = 0;
    cite_cnt tmp;
    
    for(i = 0; i < (cccnt-1); i++)
    {
        for(j = i + 1; j<cccnt; j++)
        {
            if(cnt_array[j].cnt > cnt_array[i].cnt)
            {
                tmp = cnt_array[i];
                cnt_array[i] = cnt_array[j];
                cnt_array[j] = tmp;
            }
        }
    }
    
    i = 0;
    while((i < cccnt) && (i<8))
    {
        strcpy(sreg[sregcnt].s_register[i], cnt_array[i].varname);
        i++;
    }
    sreg[sregcnt].svarnum = i;
}
