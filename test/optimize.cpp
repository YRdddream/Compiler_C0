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
#include "lex.h"
#include "midcode.h"
#include "optimize.h"
#include "error.h"

int belong_block(char a[])   // 这个op是不是属于运算的op
{
    if(strcmp(a, mid_op[PLUSOP])==0 || strcmp(a, mid_op[MINUSOP])==0 || strcmp(a, mid_op[MULTIOP])==0 || strcmp(a, mid_op[DIVOP])==0 || strcmp(a, mid_op[EQLCON])==0 || strcmp(a, mid_op[NEQCON])==0 || strcmp(a, mid_op[GTCON])==0 || strcmp(a, mid_op[GTECON])==0 || strcmp(a, mid_op[LSCON])==0 || strcmp(a, mid_op[LSECON])==0 || strcmp(a, mid_op[ASSIGNOP])==0 || strcmp(a, mid_op[GETARRAY])==0 || strcmp(a, mid_op[ASSIGNARRAY])==0 )
        return 1;
    else
        return 0;
}

void opt()
{
    //int func_num = 0;
    midpointer = 0;
    
    while(midpointer < midcnt)
    {
        if(strcmp(MIDLIST_OLD[midpointer], mid_op[FUNCOP]) == 0)    // 首先划分基本块
        {
            gen_midcode(MIDLIST_OLD[midpointer], MIDLIST_OLD[midpointer+1], MIDLIST_OLD[midpointer+2], MIDLIST_OLD[midpointer+3]);
            midpointer += 4;
            while(strcmp(MIDLIST_OLD[midpointer], mid_op[CONSTOP])==0 || strcmp(MIDLIST_OLD[midpointer], mid_op[INTOP])==0 || strcmp(MIDLIST_OLD[midpointer], mid_op[CHAROP])==0 || strcmp(MIDLIST_OLD[midpointer], mid_op[PARAOP])==0)
            {
                gen_midcode(MIDLIST_OLD[midpointer], MIDLIST_OLD[midpointer+1], MIDLIST_OLD[midpointer+2], MIDLIST_OLD[midpointer+3]);
                midpointer += 4;
            }
            func_block();
        }
        gen_midcode(MIDLIST_OLD[midpointer], MIDLIST_OLD[midpointer+1], MIDLIST_OLD[midpointer+2], MIDLIST_OLD[midpointer+3]); // endfunction和全局数据声明
        midpointer += 4;
    }
}

void func_block()
{
    int if_entry[midcodeMAX/4]={0};  // 从常量变量声明后的第一条语句开始  4个为一个单位
    int midcode_len = 0;   // 函数内中间代码的总长度，不包括参数和变量常量定义的部分
    int len_cnt = 0;
    int midtmp_pointer = 0;
    // int block_size = 0;    // 基本块大小
    int dag_in_pos = 0;    // midlist_old中基本块入口的pos
    int dag_out_pos = 0;   // 出口的pos
    
    midtmp_pointer = midpointer;
    while(strcmp(MIDLIST[midpointer], mid_op[ENDFUNC]) != 0)   // 确定入口语句
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
        midpointer += 4;
        midcode_len++;
    }
    
    while(dag_out_pos < midpointer)
    {
        dag_in_pos = midtmp_pointer;
        len_cnt++;
        midtmp_pointer += 4;
        while((if_entry[len_cnt] == 0) && (midtmp_pointer < midpointer))
        {
            midtmp_pointer += 4;
            len_cnt++;
        }
        dag_out_pos = midtmp_pointer;
        dag_proc(dag_in_pos, dag_out_pos);
        midtmp_pointer += 4;
        len_cnt++;
    }
}

void dag_proc(int in_pos, int out_pos)   // 基本块再按函数调用分子块
{
    int i = in_pos;
    int start = 0;
    int end = 0;
    
    while(i < out_pos)
    {
        if(belong_block(in_dag[i]) == 1)
        {
            start = i;
            i += 4;
            while((belong_block(in_dag[i]) == 1) && (i < out_pos))
                i += 4;
            end = i;
            dag_subproc(start, end);
        }
        else
        {
            print_subproc(i);
            i += 4;
        }
    }
}

void dag_subproc(int start, int end)    // in_dag的start和end
{
    int node_cnt = 0;
    int i = 0;
    int tmp_value = 0;
    char tmp_var[100];
    int find_const_var = 0;   // 是寻找常量还是变量(标识符或者是寄存器)
    
    int lchild_position = 0;
    int rchild_position = 0;
    int dagnode_position = 0;
    int nodelist_position = 0;
    int find = 0;   // 在结点列表中找没找到
    int no_rchild = 0;   // 为1代表没有右孩子
    int op_type = 0;   // op的类型（序号）
    node_cnt = start;
    NodeListNum = 0;
    dagNodeNum = 0;
    
    while(node_cnt < end)
    {
        if(strcmp(in_dag[node_cnt], mid_op[PLUSOP])==0 || strcmp(in_dag[node_cnt], mid_op[MULTIOP])==0 || strcmp(in_dag[node_cnt], mid_op[DIVOP])==0 || strcmp(in_dag[node_cnt], mid_op[MINUSOP])==0 || strcmp(in_dag[node_cnt], mid_op[EQLCON])==0 || strcmp(in_dag[node_cnt], mid_op[NEQCON])==0 || strcmp(in_dag[node_cnt], mid_op[GTCON])==0 || strcmp(in_dag[node_cnt], mid_op[GTECON])==0 || strcmp(in_dag[node_cnt], mid_op[LSCON])==0 || strcmp(in_dag[node_cnt], mid_op[LSECON])==0)
        {        // 如果是+，/，*则必有两个操作数
            find = 0;
            i = 0;
            // 先处理左孩子
            if(isDigit(in_dag[node_cnt+1][0]) || in_dag[node_cnt+1][0]=='-')  // 如果左孩子是数字
            {
                tmp_value = atoi(in_dag[node_cnt+1]);
                find_const_var = 0;
            }
            else if(isLetter(in_dag[node_cnt+1][0]) || in_dag[node_cnt+1][0]=='~')    // 如果左孩子是标识符或寄存器
            {
                strcpy(tmp_var, in_dag[node_cnt+1]);
                find_const_var = 1;
            }
            while(i < NodeListNum)    // 在结点列表中寻找其左孩子
            {
                if(find_const_var == 0)
                {
                    if((NodeListSet[i].constorvar==0) && (NodeListSet[i].constvalue==tmp_value))
                    {
                        find = 1;
                        lchild_position = NodeListSet[i].position;
                        break;
                    }
                    else
                    {
                        i++;
                        continue;
                    }
                }
                else
                {
                    if((NodeListSet[i].constorvar==1) && (strcmp(tmp_var, NodeListSet[i].var_name)==0))
                    {
                        find = 1;
                        lchild_position = NodeListSet[i].position;
                        break;
                    }
                    else
                    {
                        i++;
                        continue;
                    }
                }
            }
            if(find == 0)   // 新建一个结点存放左孩子,dag图中和结点列表中都需要新建
            {
                dagNodeSet[dagNodeNum].op = 0;    // 代表是叶子节点    // 这里dagnodenum还不能++
                if(find_const_var == 0)
                {
                    NodeListSet[NodeListNum].constorvar = 0;
                    NodeListSet[NodeListNum].constvalue = tmp_value;
                    NodeListSet[NodeListNum].position = dagNodeNum;
                }
                else
                {
                    NodeListSet[NodeListNum].constorvar = 1;
                    strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                    NodeListSet[NodeListNum].position = dagNodeNum;
                }
                lchild_position = dagNodeNum;
                NodeListNum++;
                dagNodeNum++;
            }
            
            find = 0;
            i = 0;
            // 再处理右孩子
            if(isDigit(in_dag[node_cnt+2][0]) || in_dag[node_cnt+2][0]=='-')  // 如果右孩子是数字
            {
                tmp_value = atoi(in_dag[node_cnt+2]);
                find_const_var = 0;
            }
            else if(isLetter(in_dag[node_cnt+2][0]) || in_dag[node_cnt+2][0]=='~')     // 如果右孩子是标识符或寄存器
            {
                strcpy(tmp_var, in_dag[node_cnt+2]);
                find_const_var = 1;
            }
            else if(in_dag[node_cnt+2][0] == '\0')   // 没有右孩子
                no_rchild = 1;
            if(no_rchild == 0)      // 如果有右孩子，则开始寻找
            {
                while(i < NodeListNum)    // 在结点列表中寻找其右孩子
                {
                    if(find_const_var == 0)
                    {
                        if((NodeListSet[i].constorvar==0) && (NodeListSet[i].constvalue==tmp_value))
                        {
                            find = 1;
                            rchild_position = NodeListSet[i].position;
                            break;
                        }
                        else
                        {
                            i++;
                            continue;
                        }
                    }
                    else
                    {
                        if((NodeListSet[i].constorvar==1) && (strcmp(tmp_var, NodeListSet[i].var_name)==0))
                        {
                            find = 1;
                            rchild_position = NodeListSet[i].position;
                            break;
                        }
                        else
                        {
                            i++;
                            continue;
                        }
                    }
                }
                if(find == 0)   // 新建一个结点存放右孩子,dag图中和结点列表中都需要新建
                {
                    dagNodeSet[dagNodeNum].op = 0;    // 代表是叶子节点    // 这里dagnodenum还不能++
                    if(find_const_var == 0)
                    {
                        NodeListSet[NodeListNum].constorvar = 0;
                        NodeListSet[NodeListNum].constvalue = tmp_value;
                        NodeListSet[NodeListNum].position = dagNodeNum;
                    }
                    else
                    {
                        NodeListSet[NodeListNum].constorvar = 1;
                        strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                        NodeListSet[NodeListNum].position = dagNodeNum;
                    }
                    rchild_position = dagNodeNum;
                    NodeListNum++;
                    dagNodeNum++;
                }
            }
            
            find = 0;
            i = 0;
            op_type = 0;
            // 处理dag图中的节点 即寻找op
            if(strcmp(in_dag[node_cnt], mid_op[PLUSOP]) == 0)
                op_type = PLUSOP;
            else if(strcmp(in_dag[node_cnt], mid_op[MINUSOP])==0 || strcmp(in_dag[node_cnt], mid_op[EQLCON])==0 || strcmp(in_dag[node_cnt], mid_op[NEQCON])==0 || strcmp(in_dag[node_cnt], mid_op[GTCON])==0 || strcmp(in_dag[node_cnt], mid_op[GTECON])==0 || strcmp(in_dag[node_cnt], mid_op[LSCON])==0 || strcmp(in_dag[node_cnt], mid_op[LSECON])==0)
                op_type = MINUSOP;
            else if(strcmp(in_dag[node_cnt], mid_op[MULTIOP]) == 0)
                op_type = MULTIOP;
            else if(strcmp(in_dag[node_cnt], mid_op[DIVOP]) == 0)
                op_type = DIVOP;
            else if(strcmp(in_dag[node_cnt], mid_op[ASSIGNOP]) == 0)
                op_type = ASSIGNOP;
            else if(strcmp(in_dag[node_cnt], mid_op[GETARRAY]) == 0)
                op_type = GETARRAY;
            else if(strcmp(in_dag[node_cnt], mid_op[ASSIGNARRAY]) == 0)
                op_type = ASSIGNARRAY;
            while(i < dagNodeNum)
            {
                if(no_rchild == 0)   // 如果有右孩子
                {
                    if(dagNodeSet[i].op==op_type && dagNodeSet[i].left_child==lchild_position && dagNodeSet[i].right_child==rchild_position)
                    {
                        find = 1;
                        dagnode_position = i;
                        break;
                    }
                    else
                    {
                        i++;
                        continue;
                    }
                }
                else      // 如果没有右孩子
                {
                    if(dagNodeSet[i].op==op_type && dagNodeSet[i].left_child==lchild_position)
                    {
                        find = 1;
                        dagnode_position = i;
                        break;
                    }
                    else
                    {
                        i++;
                        continue;
                    }
                }
            }
            if(find == 0)    // 如果没找到，DAG图中新建一个中间节点，操作为op_type
            {
                dagNodeSet[dagNodeNum].op = op_type;
                dagNodeSet[dagNodeNum].left_child = lchild_position;
                dagNodeSet[dagNodeNum].right_child = rchild_position;
                dagnode_position = dagNodeNum;
                dagNodeNum++;
            }
            
            find = 0;
            i = 0;
            // 处理第三个操作数，即结果。第三个操作数不可能是数字,只能是标识符或者寄存器
            strcpy(tmp_var, in_dag[node_cnt+1]);
            find_const_var = 1;
            while(i < NodeListNum)
            {
                if(NodeListSet[i].constorvar==1 && (strcmp(tmp_var, NodeListSet[i].var_name)==0))
                {
                    find = 1;
                    nodelist_position = i;
                    break;
                }
                else
                {
                    i++;
                    continue;
                }
            }
            if(find == 0)  // 如果未找到，则在结点表中新建一项对应关系
            {
                NodeListSet[NodeListNum].constorvar = 1;
                strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                NodeListSet[NodeListNum].position = dagnode_position;
                NodeListNum++;
            }
            else   // 如果找到了，将其节点号更改
            {
                NodeListSet[nodelist_position].position = dagnode_position;
            }
        }
        else if(strcmp(in_dag[node_cnt], mid_op[ASSIGNOP]) == 0)   // 赋值没有右孩子
        {
            find = 0;
            i = 0;
            if(isDigit(in_dag[node_cnt+1][0]) || in_dag[node_cnt+1][0]=='-')  // 如果左孩子是数字
            {
                tmp_value = atoi(in_dag[node_cnt+1]);
                find_const_var = 0;
            }
            else if(isLetter(in_dag[node_cnt+1][0]) || in_dag[node_cnt+1][0]=='~')    // 如果左孩子是标识符或寄存器
            {
                strcpy(tmp_var, in_dag[node_cnt+1]);
                find_const_var = 1;
            }
            while(i < NodeListNum)    // 在结点列表中寻找其左孩子
            {
                if(find_const_var == 0)
                {
                    if((NodeListSet[i].constorvar==0) && (NodeListSet[i].constvalue==tmp_value))
                    {
                        find = 1;
                        lchild_position = NodeListSet[i].position;
                        break;
                    }
                    else
                    {
                        i++;
                        continue;
                    }
                }
                else
                {
                    if((NodeListSet[i].constorvar==1) && (strcmp(tmp_var, NodeListSet[i].var_name)==0))
                    {
                        find = 1;
                        lchild_position = NodeListSet[i].position;
                        break;
                    }
                    else
                    {
                        i++;
                        continue;
                    }
                }
            }
            if(find == 0)   // 新建一个结点存放左孩子,dag图中和结点列表中都需要新建
            {
                dagNodeSet[dagNodeNum].op = 0;    // 代表是叶子节点    // 这里dagnodenum还不能++
                if(find_const_var == 0)
                {
                    NodeListSet[NodeListNum].constorvar = 0;
                    NodeListSet[NodeListNum].constvalue = tmp_value;
                    NodeListSet[NodeListNum].position = dagNodeNum;
                }
                else
                {
                    NodeListSet[NodeListNum].constorvar = 1;
                    strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                    NodeListSet[NodeListNum].position = dagNodeNum;
                }
                lchild_position = dagNodeNum;
                NodeListNum++;
                dagNodeNum++;
            }
        }
        
        node_cnt += 4;
    }
}

void print_subproc(int i)   // 直接输出语句，比如scanf，printf，return，call，valueparameter等等
{
    
}
