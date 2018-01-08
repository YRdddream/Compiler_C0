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

int trans_regnum(char a[])
{
    int temp = 0;
    int i = 2;
    while(a[i])
    {
        temp = temp*10 + a[i] - '0';
        i++;
    }
    return temp;
}

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
            while((strcmp(MIDLIST_OLD[midpointer], mid_op[CONSTOP])==0 || strcmp(MIDLIST_OLD[midpointer], mid_op[INTOP])==0 || strcmp(MIDLIST_OLD[midpointer], mid_op[CHAROP])==0 || strcmp(MIDLIST_OLD[midpointer], mid_op[PARAOP])==0) && (midpointer < midcnt))
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
    while(strcmp(MIDLIST_OLD[midpointer], mid_op[ENDFUNC]) != 0)   // 确定入口语句
    {
        if(midcode_len == 0)
            if_entry[midcode_len] = 1;
        else
        {
            if((strcmp(MIDLIST_OLD[midpointer], mid_op[BEQZOP]) == 0) || (strcmp(MIDLIST_OLD[midpointer], mid_op[BNEZOP]) == 0) || (strcmp(MIDLIST_OLD[midpointer], mid_op[BGTZOP]) == 0) || (strcmp(MIDLIST_OLD[midpointer], mid_op[BGEZOP]) == 0) || (strcmp(MIDLIST_OLD[midpointer], mid_op[BLTZOP]) == 0) || (strcmp(MIDLIST_OLD[midpointer], mid_op[BLEZOP]) == 0) || (strcmp(MIDLIST_OLD[midpointer], mid_op[BNEOP]) == 0) || (strcmp(MIDLIST_OLD[midpointer], mid_op[JUMPOP]) == 0))
                if_entry[midcode_len+1] = 1;
            else if(strcmp(MIDLIST_OLD[midpointer], mid_op[SETLABELOP]) == 0)
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
        //midtmp_pointer += 4;
        //len_cnt++;
    }
}

void dag_proc(int in_pos, int out_pos)   // 基本块再按函数调用等分子块
{
    int i = in_pos;
    int start = 0;
    int end = 0;
    
    while(i < out_pos)
    {
        if(belong_block(MIDLIST_OLD[i]) == 1)
        {
            start = i;
            i += 4;
            while((belong_block(MIDLIST_OLD[i]) == 1) && (i < out_pos))
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

void dag_subproc(int start, int end)    // MIDLIST_OLD的start和end
{
    int node_cnt = 0;
    int i = 0;
    int j = 0;
    int tmp = 0;
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
    node_cnt = start; //*****
    NodeListNum = 0;
    dagNodeNum = 0;
    leafvarNum = 0;
    midnode_num = 0;
    int midnode_end = 0;
    
    char temp1[wlMAX];
    char temp2[wlMAX];
    char temp3[wlMAX];
    
    while(node_cnt < end)
    {
        no_rchild = 0;
        if(strcmp(MIDLIST_OLD[node_cnt], mid_op[PLUSOP])==0 || strcmp(MIDLIST_OLD[node_cnt], mid_op[MULTIOP])==0 || strcmp(MIDLIST_OLD[node_cnt], mid_op[DIVOP])==0 || strcmp(MIDLIST_OLD[node_cnt], mid_op[MINUSOP])==0 || strcmp(MIDLIST_OLD[node_cnt], mid_op[EQLCON])==0 || strcmp(MIDLIST_OLD[node_cnt], mid_op[NEQCON])==0 || strcmp(MIDLIST_OLD[node_cnt], mid_op[GTCON])==0 || strcmp(MIDLIST_OLD[node_cnt], mid_op[GTECON])==0 || strcmp(MIDLIST_OLD[node_cnt], mid_op[LSCON])==0 || strcmp(MIDLIST_OLD[node_cnt], mid_op[LSECON])==0)
        {        // 如果是+，/，*则必有两个操作数     + - * / 的运算
            find = 0;
            i = 0;
            // 先处理左孩子
            if(isDigit(MIDLIST_OLD[node_cnt+1][0]) || MIDLIST_OLD[node_cnt+1][0]=='-')  // 如果左孩子是数字
            {
                tmp_value = atoi(MIDLIST_OLD[node_cnt+1]);
                find_const_var = 0;
            }
            else if(isLetter(MIDLIST_OLD[node_cnt+1][0]) || MIDLIST_OLD[node_cnt+1][0]=='~')    // 如果左孩子是标识符或寄存器
            {
                strcpy(tmp_var, MIDLIST_OLD[node_cnt+1]);
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
            
            if(find == 0)   // 新建一个结点存放左孩子,dag图中和结点列表中都需要新建  // 如果没有找到就说明是个叶子节点,需要给其赋初值
            {
                dagNodeSet[dagNodeNum].op = 0;    // 代表是叶子节点    // 这里dagnodenum还不能++
                dagNodeSet[dagNodeNum].dadnum = 0;
                dagNodeSet[dagNodeNum].if_out = 0;
                dagNodeSet[dagNodeNum].constorvar = find_const_var;
                if(find_const_var == 0)
                {
                    NodeListSet[NodeListNum].constorvar = 0;
                    NodeListSet[NodeListNum].constvalue = tmp_value;
                    NodeListSet[NodeListNum].position = dagNodeNum;
                    dagNodeSet[dagNodeNum].constvalue = tmp_value;
                }
                else
                {
                    strcpy(dagNodeSet[dagNodeNum].dag_name, tmp_var);
                    NodeListSet[NodeListNum].constorvar = 1;
                    strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                    NodeListSet[NodeListNum].position = dagNodeNum;
                    
                    if(isLetter(MIDLIST_OLD[node_cnt+1][0]))   // 如果叶子节点是一个变量名，那么就记录到叶子变量集合中（这时候没办法判断其是常量还是变量，只好都弄进去）
                    {
                        leafvarSet[leafvarNum].if_change = 0;
                        strcpy(dagNodeSet[dagNodeNum].dag_name, MIDLIST_OLD[node_cnt+1]);
                        strcpy(leafvarSet[leafvarNum].var_name, MIDLIST_OLD[node_cnt+1]);
                        leafvarNum++;
                    }
                    else if(MIDLIST_OLD[node_cnt+1][0]=='~')   // 如果叶子节点是寄存器（说明是函数调用的情况，需要更改其寄存器的位置）
                    {
                        tmp = trans_regnum(MIDLIST_OLD[node_cnt+1]);
                        sprintf(tmp_var, "~t%d", replace_reg[tmp]);
                        strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                        strcpy(dagNodeSet[dagNodeNum].dag_name, tmp_var);
                    }
                }
                lchild_position = dagNodeNum;
                NodeListNum++;
                dagNodeNum++;
            }
            
            find = 0;
            i = 0;
            // 再处理右孩子
            if(isDigit(MIDLIST_OLD[node_cnt+2][0]) || MIDLIST_OLD[node_cnt+2][0]=='-')  // 如果右孩子是数字
            {
                tmp_value = atoi(MIDLIST_OLD[node_cnt+2]);
                find_const_var = 0;
            }
            else if(isLetter(MIDLIST_OLD[node_cnt+2][0]) || MIDLIST_OLD[node_cnt+2][0]=='~')     // 如果右孩子是标识符或寄存器
            {
                strcpy(tmp_var, MIDLIST_OLD[node_cnt+2]);
                find_const_var = 1;
            }
            else if(MIDLIST_OLD[node_cnt+2][0] == '\0')   // 没有右孩子
            {
                no_rchild = 1;
                rchild_position = (-1);
            }
            
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
                    dagNodeSet[dagNodeNum].dadnum = 0;
                    dagNodeSet[dagNodeNum].if_out = 0;
                    dagNodeSet[dagNodeNum].constorvar = find_const_var;
                    if(find_const_var == 0)
                    {
                        NodeListSet[NodeListNum].constorvar = 0;
                        NodeListSet[NodeListNum].constvalue = tmp_value;
                        NodeListSet[NodeListNum].position = dagNodeNum;
                        dagNodeSet[dagNodeNum].constvalue = tmp_value;
                    }
                    else
                    {
                        strcpy(dagNodeSet[dagNodeNum].dag_name, tmp_var);
                        NodeListSet[NodeListNum].constorvar = 1;
                        strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                        NodeListSet[NodeListNum].position = dagNodeNum;
                        
                        if(isLetter(MIDLIST_OLD[node_cnt+2][0]))
                        {
                            leafvarSet[leafvarNum].if_change = 0;
                            strcpy(dagNodeSet[dagNodeNum].dag_name, MIDLIST_OLD[node_cnt+2]);
                            strcpy(leafvarSet[leafvarNum].var_name, MIDLIST_OLD[node_cnt+2]);
                            leafvarNum++;
                        }
                        else if(MIDLIST_OLD[node_cnt+2][0]=='~')   // 如果叶子节点是寄存器（说明是函数调用的情况，需要更改其寄存器的位置）
                        {
                            tmp = trans_regnum(MIDLIST_OLD[node_cnt+2]);
                            sprintf(tmp_var, "~t%d", replace_reg[tmp]);
                            strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                            strcpy(dagNodeSet[dagNodeNum].dag_name, tmp_var);
                        }
                    }
                    rchild_position = dagNodeNum;
                    NodeListNum++;
                    dagNodeNum++;
                }
            }
            
            find = 0;
            i = 0;
            op_type = 0;     // 处理dag图中的节点 即寻找op
            if(strcmp(MIDLIST_OLD[node_cnt], mid_op[PLUSOP]) == 0)
                op_type = PLUSOP;
            else if(strcmp(MIDLIST_OLD[node_cnt], mid_op[MINUSOP])==0 || strcmp(MIDLIST_OLD[node_cnt], mid_op[EQLCON])==0 || strcmp(MIDLIST_OLD[node_cnt], mid_op[NEQCON])==0 || strcmp(MIDLIST_OLD[node_cnt], mid_op[GTCON])==0 || strcmp(MIDLIST_OLD[node_cnt], mid_op[GTECON])==0 || strcmp(MIDLIST_OLD[node_cnt], mid_op[LSCON])==0 || strcmp(MIDLIST_OLD[node_cnt], mid_op[LSECON])==0)
                op_type = MINUSOP;
            else if(strcmp(MIDLIST_OLD[node_cnt], mid_op[MULTIOP]) == 0)
                op_type = MULTIOP;
            else if(strcmp(MIDLIST_OLD[node_cnt], mid_op[DIVOP]) == 0)
                op_type = DIVOP;
            
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
                    if(dagNodeSet[i].op==op_type && dagNodeSet[i].left_child==lchild_position && dagNodeSet[i].right_child==(-1))
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
                dagNodeSet[lchild_position].dadnum++;     // 子节点的爸爸数量增加1
                if(no_rchild == 0)
                    dagNodeSet[rchild_position].dadnum++;
                dagNodeSet[dagNodeNum].op = op_type;
                dagNodeSet[dagNodeNum].left_child = lchild_position;
                dagNodeSet[dagNodeNum].right_child = rchild_position;
                dagNodeSet[dagNodeNum].if_out = 0;
                dagnode_position = dagNodeNum;
                dagNodeNum++;
            }
            
            find = 0;
            i = 0;
            // 处理第三个操作数，即结果。第三个操作数不可能是数字和标识符,只能是寄存器！！！
            strcpy(tmp_var, MIDLIST_OLD[node_cnt+3]);
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
                //printf("Debug/Error:the third should not be found!!!\n");
                NodeListSet[nodelist_position].position = dagnode_position;
            }
        }
        else if(strcmp(MIDLIST_OLD[node_cnt], mid_op[ASSIGNOP]) == 0)   // 赋值没有右孩子
        {
            find = 0;
            i = 0;
            if(isDigit(MIDLIST_OLD[node_cnt+1][0]) || MIDLIST_OLD[node_cnt+1][0]=='-')  // 如果左孩子是数字
            {
                tmp_value = atoi(MIDLIST_OLD[node_cnt+1]);
                find_const_var = 0;
            }
            else if(isLetter(MIDLIST_OLD[node_cnt+1][0]) || MIDLIST_OLD[node_cnt+1][0]=='~')    // 如果左孩子是标识符或寄存器
            {
                strcpy(tmp_var, MIDLIST_OLD[node_cnt+1]);
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
                dagNodeSet[dagNodeNum].dadnum = 0;
                dagNodeSet[dagNodeNum].if_out = 0;
                dagNodeSet[dagNodeNum].constorvar = find_const_var;
                if(find_const_var == 0)
                {
                    NodeListSet[NodeListNum].constorvar = 0;
                    NodeListSet[NodeListNum].constvalue = tmp_value;
                    NodeListSet[NodeListNum].position = dagNodeNum;
                    dagNodeSet[dagNodeNum].constvalue = tmp_value;
                }
                else
                {
                    NodeListSet[NodeListNum].constorvar = 1;
                    strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                    NodeListSet[NodeListNum].position = dagNodeNum;
                    
                    if(isLetter(MIDLIST_OLD[node_cnt+1][0]))
                    {
                        leafvarSet[leafvarNum].if_change = 0;
                        strcpy(dagNodeSet[dagNodeNum].dag_name, MIDLIST_OLD[node_cnt+1]);
                        strcpy(leafvarSet[leafvarNum].var_name, MIDLIST_OLD[node_cnt+1]);
                        leafvarNum++;
                    }
                    else if(MIDLIST_OLD[node_cnt+1][0]=='~')   // 如果叶子节点是寄存器（说明是函数调用的情况，需要更改其寄存器的位置）
                    {
                        tmp = trans_regnum(MIDLIST_OLD[node_cnt+1]);
                        sprintf(tmp_var, "~t%d", replace_reg[tmp]);
                        strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                        strcpy(dagNodeSet[dagNodeNum].dag_name, tmp_var);
                    }
                }
                lchild_position = dagNodeNum;
                NodeListNum++;
                dagNodeNum++;
            }
            
            // 第四个节点只能是标识符
            find = 0;
            i = 0;
            strcpy(tmp_var, MIDLIST_OLD[node_cnt+3]);
            while (i<NodeListNum)
            {
                if((NodeListSet[i].constorvar==1) && (strcmp(NodeListSet[i].var_name, tmp_var)==0))
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
            if(find == 0)
            {
                NodeListSet[NodeListNum].constorvar = 1;
                strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                NodeListSet[NodeListNum].position = lchild_position;
                NodeListNum++;
            }
            else
            {
                NodeListSet[nodelist_position].position = lchild_position;
                i = 0;
                while(i < leafvarNum)
                {
                    if(strcmp(leafvarSet[i].var_name, tmp_var)==0)
                    {
                        leafvarSet[i].if_change = 1;
                        break;
                    }
                    i++;
                }
            }
        }
        else if(strcmp(MIDLIST_OLD[node_cnt], mid_op[GETARRAY]) == 0)
        {
            find = 0;   // 第一个操作数一定是标识符——数组名
            i = 0;
            strcpy(tmp_var, MIDLIST_OLD[node_cnt+1]);
            find_const_var = 1;
            while(i < NodeListNum)
            {
                if((NodeListSet[i].constorvar==1) && (strcmp(NodeListSet[i].var_name, tmp_var)==0))
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
            
            if(find == 0)
            {
                dagNodeSet[dagNodeNum].op = 0;
                dagNodeSet[dagNodeNum].dadnum = 0;
                dagNodeSet[dagNodeNum].if_out = 0;
                dagNodeSet[dagNodeNum].constorvar = find_const_var;
                strcpy(dagNodeSet[dagNodeNum].dag_name, tmp_var);
                
                NodeListSet[NodeListNum].constorvar = 1;    // 这个节点代表数组
                strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                NodeListSet[NodeListNum].position = dagNodeNum;
                
                lchild_position = dagNodeNum;
                NodeListNum++;
                dagNodeNum++;
            }
            
            // 再处理第二个操作数，即数组下标(右孩子)
            find = 0;
            i = 0;
            
            if(isDigit(MIDLIST_OLD[node_cnt+2][0]) || MIDLIST_OLD[node_cnt+2][0]=='-')  // 如果右孩子是数字
            {
                tmp_value = atoi(MIDLIST_OLD[node_cnt+2]);
                find_const_var = 0;
            }
            else if(isLetter(MIDLIST_OLD[node_cnt+2][0]) || MIDLIST_OLD[node_cnt+2][0]=='~')     // 如果右孩子是标识符或寄存器
            {
                strcpy(tmp_var, MIDLIST_OLD[node_cnt+2]);
                find_const_var = 1;
            }
            
            while(i < NodeListNum)
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
                    if((NodeListSet[i].constorvar==1) && (strcmp(NodeListSet[i].var_name, tmp_var)==0))
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
            
            if(find == 0)
            {
                dagNodeSet[dagNodeNum].op = 0;
                dagNodeSet[dagNodeNum].dadnum = 0;
                dagNodeSet[dagNodeNum].if_out = 0;
                dagNodeSet[dagNodeNum].constorvar = find_const_var;
                if(find_const_var == 0)
                {
                    NodeListSet[NodeListNum].constorvar = 0;
                    NodeListSet[NodeListNum].constvalue = atoi(MIDLIST_OLD[node_cnt+2]);
                    NodeListSet[NodeListNum].position = dagNodeNum;
                    dagNodeSet[dagNodeNum].constvalue = tmp_value;
                }
                else
                {
                    NodeListSet[NodeListNum].constorvar = 1;
                    strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                    NodeListSet[NodeListNum].position = dagNodeNum;
                    
                    if(isLetter(MIDLIST_OLD[node_cnt+2][0]))
                    {
                        leafvarSet[leafvarNum].if_change = 0;
                        strcpy(dagNodeSet[dagNodeNum].dag_name, tmp_var);
                        strcpy(leafvarSet[leafvarNum].var_name, tmp_var);
                        leafvarNum++;
                    }
                    else if(MIDLIST_OLD[node_cnt+2][0]=='~')   // 如果叶子节点是寄存器（说明是函数调用的情况，需要更改其寄存器的位置）
                    {
                        tmp = trans_regnum(MIDLIST_OLD[node_cnt+2]);
                        sprintf(tmp_var, "~t%d", replace_reg[tmp]);
                        strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                        strcpy(dagNodeSet[dagNodeNum].dag_name, tmp_var);
                    }
                }
                
                rchild_position = dagNodeNum;
                dagNodeNum++;
                NodeListNum++;
            }
            
            // 处理中间节点，看有无公共子表达式
            find = 0;
            i = 0;
            op_type = GETARRAY;
            while(i < dagNodeNum)
            {
                if((dagNodeSet[i].op == op_type) && (dagNodeSet[i].left_child==lchild_position) && (dagNodeSet[i].right_child==rchild_position))
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
            
            if(find == 0)
            {
                dagNodeSet[lchild_position].dadnum++;
                dagNodeSet[rchild_position].dadnum++;
                dagNodeSet[dagNodeNum].op = op_type;
                dagNodeSet[dagNodeNum].left_child = lchild_position;
                dagNodeSet[dagNodeNum].right_child = rchild_position;
                dagNodeSet[dagNodeNum].if_out = 0;
                dagnode_position = dagNodeNum;
                dagNodeNum++;
            }
            
            // 处理第三个操作数，只能是寄存器！！！
            find = 0;
            i = 0;
            strcpy(tmp_var, MIDLIST_OLD[node_cnt+3]);
            while(i < NodeListNum)
            {
                if((NodeListSet[i].constorvar==1) && (strcmp(tmp_var, NodeListSet[i].var_name)==0))
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
            
            if(find == 0)
            {
                strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                NodeListSet[NodeListNum].position = dagnode_position;
                NodeListSet[NodeListNum].constorvar = 1;
                NodeListNum++;
            }
            else
                NodeListSet[nodelist_position].position = dagnode_position;
        }
        else if(strcmp(MIDLIST_OLD[node_cnt], mid_op[ASSIGNARRAY]) == 0)   // 第一个操作数是数组名，第二个是左孩子，第三个是右孩子
        {
            find = 0;
            i = 0;      // 先处理左孩子
            if(isDigit(MIDLIST_OLD[node_cnt+2][0]) || MIDLIST_OLD[node_cnt+2][0]=='-')  // 如果左孩子是数字
            {
                tmp_value = atoi(MIDLIST_OLD[node_cnt+2]);
                find_const_var = 0;
            }
            else if(isLetter(MIDLIST_OLD[node_cnt+2][0]) || MIDLIST_OLD[node_cnt+2][0]=='~')    // 如果左孩子是标识符或寄存器
            {
                strcpy(tmp_var, MIDLIST_OLD[node_cnt+2]);
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
                dagNodeSet[dagNodeNum].dadnum = 0;
                dagNodeSet[dagNodeNum].if_out = 0;
                dagNodeSet[dagNodeNum].constorvar = find_const_var;
                if(find_const_var == 0)
                {
                    NodeListSet[NodeListNum].constorvar = 0;
                    NodeListSet[NodeListNum].constvalue = tmp_value;
                    NodeListSet[NodeListNum].position = dagNodeNum;
                    dagNodeSet[dagNodeNum].constvalue = tmp_value;
                }
                else
                {
                    NodeListSet[NodeListNum].constorvar = 1;
                    strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                    NodeListSet[NodeListNum].position = dagNodeNum;
                    
                    if(isLetter(tmp_var[0]))   // 如果叶子节点是一个变量名，那么就记录到叶子变量集合中（这时候没办法判断其是常量还是变量，只好都弄进去）
                    {
                        leafvarSet[leafvarNum].if_change = 0;
                        strcpy(dagNodeSet[dagNodeNum].dag_name, tmp_var);
                        strcpy(leafvarSet[leafvarNum].var_name, tmp_var);
                        leafvarNum++;
                    }
                    else if(tmp_var[0]=='~')   // 如果叶子节点是寄存器（说明是函数调用的情况，需要更改其寄存器的位置）
                    {
                        tmp = trans_regnum(tmp_var);
                        sprintf(tmp_var, "~t%d", replace_reg[tmp]);
                        strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                        strcpy(dagNodeSet[dagNodeNum].dag_name, tmp_var);
                    }
                }
                lchild_position = dagNodeNum;
                NodeListNum++;
                dagNodeNum++;
            }
            
            find = 0;    // 再处理右孩子
            i = 0;
            if(isDigit(MIDLIST_OLD[node_cnt+3][0]) || MIDLIST_OLD[node_cnt+3][0]=='-')  // 如果左孩子是数字
            {
                tmp_value = atoi(MIDLIST_OLD[node_cnt+3]);
                find_const_var = 0;
            }
            else if(isLetter(MIDLIST_OLD[node_cnt+3][0]) || MIDLIST_OLD[node_cnt+3][0]=='~')    // 如果左孩子是标识符或寄存器
            {
                strcpy(tmp_var, MIDLIST_OLD[node_cnt+3]);
                find_const_var = 1;
            }
            
            while(i < NodeListNum)
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
            
            if(find == 0)
            {
                dagNodeSet[dagNodeNum].op = 0;
                dagNodeSet[dagNodeNum].dadnum = 0;
                dagNodeSet[dagNodeNum].if_out = 0;
                dagNodeSet[dagNodeNum].constorvar = find_const_var;
                if(find_const_var == 0)
                {
                    NodeListSet[NodeListNum].constorvar = 0;
                    NodeListSet[NodeListNum].constvalue = tmp_value;
                    NodeListSet[NodeListNum].position = dagNodeNum;
                    dagNodeSet[dagNodeNum].constvalue = tmp_value;
                }
                else
                {
                    NodeListSet[NodeListNum].constorvar = 1;
                    strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                    NodeListSet[NodeListNum].position = dagNodeNum;
                    
                    if(isLetter(tmp_var[0]))
                    {
                        leafvarSet[leafvarNum].if_change = 0;
                        strcpy(dagNodeSet[dagNodeNum].dag_name, tmp_var);
                        strcpy(leafvarSet[leafvarNum].var_name, tmp_var);
                        leafvarNum++;
                    }
                    else if(tmp_var[0]=='~')   // 如果叶子节点是寄存器（说明是函数调用的情况，需要更改其寄存器的位置）
                    {
                        tmp = trans_regnum(tmp_var);
                        sprintf(tmp_var, "~t%d", replace_reg[tmp]);
                        strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                        strcpy(dagNodeSet[dagNodeNum].dag_name, tmp_var);
                    }
                }
                rchild_position = dagNodeNum;
                NodeListNum++;
                dagNodeNum++;
            }
            
            find = 0;     // 最后处理数组名，这时必须在dag图中新建节点
            i = 0;
            dagNodeSet[lchild_position].dadnum++;
            dagNodeSet[rchild_position].dadnum++;
            dagNodeSet[dagNodeNum].left_child = lchild_position;
            dagNodeSet[dagNodeNum].right_child = rchild_position;
            dagNodeSet[dagNodeNum].if_out = 0;
            dagNodeSet[dagNodeNum].op = ASSIGNARRAY;
            strcpy(dagNodeSet[dagNodeNum].dag_name, MIDLIST_OLD[node_cnt+1]);
            
            strcpy(tmp_var, MIDLIST_OLD[node_cnt+1]);
            while(i < NodeListNum)
            {
                if((NodeListSet[i].constorvar==1) && (strcmp(tmp_var, NodeListSet[i].var_name)==0))
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
            
            if(find == 0)
            {
                NodeListSet[NodeListNum].constorvar = 1;
                NodeListSet[NodeListNum].position = dagNodeNum;
                strcpy(NodeListSet[NodeListNum].var_name, tmp_var);
                NodeListNum++;
            }
            else
                NodeListSet[nodelist_position].position = dagNodeNum;
            dagNodeNum++;
        }
        node_cnt += 4;
    }
    
    // 将dag图输出到midlist中，即调用gen_midcode函数
    i = dagNodeNum - 1;
    midnode_end = 0;
    while(midnode_end == 0)
    {
        midnode_end = 1;
        i = dagNodeNum - 1;
        while(i >= 0)
        {
            if(dagNodeSet[i].dadnum==0 && dagNodeSet[i].if_out==0 && dagNodeSet[i].op!=0)
            {
                midnode_end = 0;
                dagnode_out_list[midnode_num++] = i;     // 将节点放入输出队列
                dagNodeSet[dagNodeSet[i].left_child].dadnum--;
                if(dagNodeSet[i].right_child != (-1))
                    dagNodeSet[dagNodeSet[i].right_child].dadnum--;
                dagNodeSet[i].if_out = 1;
                j = dagNodeSet[i].left_child;
                while(dagNodeSet[j].dadnum==0 && dagNodeSet[j].if_out==0 && dagNodeSet[j].op!=0)
                {
                    dagnode_out_list[midnode_num++] = j;
                    dagNodeSet[dagNodeSet[j].left_child].dadnum--;
                    if(dagNodeSet[j].right_child != (-1))
                        dagNodeSet[dagNodeSet[j].right_child].dadnum--;
                    dagNodeSet[j].if_out = 1;
                    j = dagNodeSet[j].left_child;
                }
                break;
            }
            i--;
        }
    }
    
    i = 0;
    while(i < leafvarNum)      // 先用临时变量存储初值被改变的变量
    {
        if(leafvarSet[i].if_change == 1)
        {
            leafvarSet[i].reg_pos = reg_num_new;
            sprintf(temp1, "~t%d", reg_num_new++);
            gen_midcode(mid_op[PLUSOP], leafvarSet[i].var_name, "0", temp1);
        }
        i++;
    }
    
    i = midnode_num - 1;    // 由dag图导出中间代码
    while(i >= 0)
    {
        // 先处理节点的左孩子
        tmp = dagnode_out_list[i];
        if(dagNodeSet[dagNodeSet[tmp].left_child].op == 0)   // 如果孩子是叶子节点
        {
            if(dagNodeSet[dagNodeSet[tmp].left_child].constorvar == 0)   // 如果左孩子是数字
                sprintf(temp1, "%d", dagNodeSet[dagNodeSet[tmp].left_child].constvalue);
            else     // 如果左孩子是字母或者寄存器
            {
                if(isLetter(dagNodeSet[dagNodeSet[tmp].left_child].dag_name[0]))    // 如果是标识符，需要检测其初值是不是被改变，如果被改变则用临时reg中的值
                {
                    j = 0;
                    strcpy(temp1, dagNodeSet[dagNodeSet[tmp].left_child].dag_name);
                    while(j < leafvarNum)
                    {
                        if(strcmp(dagNodeSet[dagNodeSet[tmp].left_child].dag_name, leafvarSet[j].var_name)==0 && leafvarSet[j].if_change==1)
                        {
                            sprintf(temp1, "~t%d", leafvarSet[j].reg_pos);
                            break;
                        }
                        j++;
                    }
                }
                else    // 如果是寄存器
                    strcpy(temp1, dagNodeSet[dagNodeSet[tmp].left_child].dag_name);
            }
        }
        else    // 如果孩子是中间节点(寄存器)
            strcpy(temp1, dagNodeSet[dagNodeSet[tmp].left_child].dag_name);
        
        // 再处理节点的右孩子(如果有)
        if(dagNodeSet[tmp].right_child != (-1))
        {
            if(dagNodeSet[dagNodeSet[tmp].right_child].op == 0)   // 如果孩子是叶子节点
            {
                if(dagNodeSet[dagNodeSet[tmp].right_child].constorvar == 0)   // 如果左孩子是数字
                    sprintf(temp2, "%d", dagNodeSet[dagNodeSet[tmp].right_child].constvalue);
                else     // 如果左孩子是字母或者寄存器
                {
                    if(isLetter(dagNodeSet[dagNodeSet[tmp].right_child].dag_name[0]))    // 如果是标识符，需要检测其初值是不是被改变，如果被改变则用临时reg中的值
                    {
                        j = 0;
                        strcpy(temp2, dagNodeSet[dagNodeSet[tmp].right_child].dag_name);
                        while(j < leafvarNum)
                        {
                            if(strcmp(dagNodeSet[dagNodeSet[tmp].right_child].dag_name, leafvarSet[j].var_name)==0 && leafvarSet[j].if_change==1)
                            {
                                sprintf(temp2, "~t%d", leafvarSet[j].reg_pos);
                                break;
                            }
                            j++;
                        }
                    }
                    else    // 如果是寄存器
                        strcpy(temp2, dagNodeSet[dagNodeSet[tmp].right_child].dag_name);
                }
            }
            else    // 如果孩子是中间节点(寄存器)
                strcpy(temp2, dagNodeSet[dagNodeSet[tmp].right_child].dag_name);
        }
        
        if(dagNodeSet[tmp].op==PLUSOP || dagNodeSet[tmp].op==MULTIOP || dagNodeSet[tmp].op==DIVOP)
        {
            sprintf(temp3, "~t%d", reg_num_new++);
            gen_midcode(mid_op[dagNodeSet[tmp].op], temp1, temp2, temp3);
            strcpy(dagNodeSet[tmp].dag_name, temp3);
        }
        else if(dagNodeSet[tmp].op == MINUSOP)
        {
            sprintf(temp3, "~t%d", reg_num_new++);
            if(dagNodeSet[tmp].right_child != (-1))   // 如果有右孩子
                gen_midcode(mid_op[MINUSOP], temp1, temp2, temp3);
            else      // 如果没有右孩子
                gen_midcode(mid_op[MINUSOP], temp1, 0, temp3);
            strcpy(dagNodeSet[tmp].dag_name, temp3);
        }
        else if(dagNodeSet[tmp].op == GETARRAY)
        {
            sprintf(temp3, "~t%d", reg_num_new++);
            gen_midcode(mid_op[GETARRAY], temp1, temp2, temp3);
            strcpy(dagNodeSet[tmp].dag_name, temp3);
        }
        else if(dagNodeSet[tmp].op == ASSIGNARRAY)
            gen_midcode(mid_op[ASSIGNARRAY], dagNodeSet[tmp].dag_name, temp1, temp2);
        i--;
    }
    
    // 给标识符赋值，并且把寄存器的对应关系放到replace_reg数组中，代表原来的寄存器现在的寄存器编号
    i = NodeListNum - 1;
    while(i >= 0)
    {
        if(NodeListSet[i].constorvar == 1)    // NodeList中只有标识符和寄存器才有资格被处理
        {
            if(isLetter(NodeListSet[i].var_name[0]))    // 如果是个标识符
            {
                if(dagNodeSet[NodeListSet[i].position].if_out==1 && dagNodeSet[NodeListSet[i].position].op!=ASSIGNARRAY)  // 如果是中间节点（不是数组的前提下）
                    gen_midcode(mid_op[ASSIGNOP], dagNodeSet[NodeListSet[i].position].dag_name, 0, NodeListSet[i].var_name);
                else if(dagNodeSet[NodeListSet[i].position].if_out == 0)   // 如果是叶子节点
                {
                    if(dagNodeSet[NodeListSet[i].position].constorvar == 0)    // 如果叶子节点是个数字
                    {
                        sprintf(temp1, "%d", dagNodeSet[NodeListSet[i].position].constvalue);
                        gen_midcode(mid_op[ASSIGNOP], temp1, 0, NodeListSet[i].var_name);
                    }
                    else if(strcmp(dagNodeSet[NodeListSet[i].position].dag_name, NodeListSet[i].var_name) != 0)  // 如果是标识符且和它本身不同
                        gen_midcode(mid_op[ASSIGNOP], dagNodeSet[NodeListSet[i].position].dag_name, 0, NodeListSet[i].var_name);
                }
            }
            else     // 如果是个寄存器
            {
                if(dagNodeSet[NodeListSet[i].position].if_out==1 && dagNodeSet[NodeListSet[i].position].op!=ASSIGNARRAY)
                    replace_reg[trans_regnum(NodeListSet[i].var_name)] = trans_regnum(dagNodeSet[NodeListSet[i].position].dag_name);
                else if(dagNodeSet[NodeListSet[i].position].if_out == 0)   // 如果是叶子节点
                {
                    /*if(dagNodeSet[NodeListSet[i].position].constorvar == 0)
                    {
                        sprintf(temp1, "%d", dagNodeSet[NodeListSet[i].position].constvalue);
                        gen_midcode(mid_op[PLUSOP], temp1, "0", NodeListSet[i].var_name);
                    }
                    else     // 如果是标识符
                        gen_midcode(mid_op[PLUSOP], dagNodeSet[NodeListSet[i].position].dag_name, "0", NodeListSet[i].var_name);*/
                }
            }
        }
        i--;
    }
    
    // 结束了吧
}

void print_subproc(int i)   // 直接输出语句，比如scanf，printf，return，call，valueparameter等等
{
    int tmp = 0;
    char temp1[100];
    
    if(strcmp(MIDLIST_OLD[i], mid_op[CONSTOP])==0 || strcmp(MIDLIST_OLD[i], mid_op[INTOP])==0 || strcmp(MIDLIST_OLD[i], mid_op[CHAROP])==0 || strcmp(MIDLIST_OLD[i], mid_op[FUNCOP])==0 || strcmp(MIDLIST_OLD[i], mid_op[PARAOP])==0 || strcmp(MIDLIST_OLD[i], mid_op[JUMPOP])==0 || strcmp(MIDLIST_OLD[i], mid_op[SETLABELOP])==0 || strcmp(MIDLIST_OLD[i], mid_op[SCANFOP])==0 || strcmp(MIDLIST_OLD[i], mid_op[ENDFUNC])==0)
        gen_midcode(MIDLIST_OLD[i], MIDLIST_OLD[i+1], MIDLIST_OLD[i+2], MIDLIST_OLD[i+3]);
    else if(strcmp(MIDLIST_OLD[i], mid_op[VALUEPARAOP]) == 0)
    {
        if(isLetter(MIDLIST_OLD[i+3][0]) || isDigit(MIDLIST_OLD[i+3][0]) || MIDLIST_OLD[i+3][0] == '-')
            gen_midcode(MIDLIST_OLD[i], MIDLIST_OLD[i+1], MIDLIST_OLD[i+2], MIDLIST_OLD[i+3]);
        else
        {
            tmp = trans_regnum(MIDLIST_OLD[i+3]);
            sprintf(temp1, "~t%d", replace_reg[tmp]);
            gen_midcode(MIDLIST_OLD[i], MIDLIST_OLD[i+1], MIDLIST_OLD[i+2], temp1);
        }
    }
    else if(strcmp(MIDLIST_OLD[i], mid_op[CALLOP]) == 0)    // !!!
    {
        if(MIDLIST_OLD[i+3][0] == '\0')
            gen_midcode(MIDLIST_OLD[i], MIDLIST_OLD[i+1], MIDLIST_OLD[i+2], MIDLIST_OLD[i+3]);
        else
        {
            tmp = reg_num_new++;
            sprintf(temp1, "~t%d", tmp);
            gen_midcode(MIDLIST_OLD[i], MIDLIST_OLD[i+1], MIDLIST_OLD[i+2], temp1);
            replace_reg[trans_regnum(MIDLIST_OLD[i+3])] = tmp;
        }
    }
    else if(strcmp(MIDLIST_OLD[i], mid_op[RETURNOP]) == 0)
    {
        if(isLetter(MIDLIST_OLD[i+3][0]) || isDigit(MIDLIST_OLD[i+3][0]) || MIDLIST_OLD[i+3][0] == '-' || MIDLIST_OLD[i+3][0] == '\0')
            gen_midcode(MIDLIST_OLD[i], MIDLIST_OLD[i+1], MIDLIST_OLD[i+2], MIDLIST_OLD[i+3]);
        else
        {
            tmp = trans_regnum(MIDLIST_OLD[i+3]);
            sprintf(temp1, "~t%d", replace_reg[tmp]);
            gen_midcode(MIDLIST_OLD[i], MIDLIST_OLD[i+1], MIDLIST_OLD[i+2], temp1);
        }
    }
    else if(strcmp(MIDLIST_OLD[i], mid_op[BNEOP]) == 0)
    {
        if(isLetter(MIDLIST_OLD[i+1][0]) || isDigit(MIDLIST_OLD[i+1][0]) || MIDLIST_OLD[i+1][0] == '-')
            gen_midcode(MIDLIST_OLD[i], MIDLIST_OLD[i+1], MIDLIST_OLD[i+2], MIDLIST_OLD[i+3]);
        else
        {
            tmp = trans_regnum(MIDLIST_OLD[i+1]);
            sprintf(temp1, "~t%d", replace_reg[tmp]);
            gen_midcode(MIDLIST_OLD[i], temp1, MIDLIST_OLD[i+2], MIDLIST_OLD[i+3]);
        }
    }
    else if(strcmp(MIDLIST_OLD[i], mid_op[BNEZOP])==0 || strcmp(MIDLIST_OLD[i], mid_op[BEQZOP])==0 || strcmp(MIDLIST_OLD[i], mid_op[BGTZOP])==0 || strcmp(MIDLIST_OLD[i], mid_op[BGEZOP])==0 || strcmp(MIDLIST_OLD[i], mid_op[BLTZOP])==0 || strcmp(MIDLIST_OLD[i], mid_op[BLEZOP])==0)
    {
        if(isLetter(MIDLIST_OLD[i+1][0]) || isDigit(MIDLIST_OLD[i+1][0]) || MIDLIST_OLD[i+1][0] == '-')
            gen_midcode(MIDLIST_OLD[i], MIDLIST_OLD[i+1], MIDLIST_OLD[i+2], MIDLIST_OLD[i+3]);
        else
        {
            tmp = trans_regnum(MIDLIST_OLD[i+1]);
            sprintf(temp1, "~t%d", replace_reg[tmp]);
            gen_midcode(MIDLIST_OLD[i], temp1, MIDLIST_OLD[i+2], MIDLIST_OLD[i+3]);
        }
    }
    else if(strcmp(MIDLIST_OLD[i], mid_op[PRINTFOP])==0)
    {
        if(MIDLIST_OLD[i+2][0] == '\0')
        {
            if(MIDLIST_OLD[i+1][0]=='~' && MIDLIST_OLD[i+1][1]=='t')
            {
                tmp = trans_regnum(MIDLIST_OLD[i+1]);
                sprintf(temp1, "~t%d", replace_reg[tmp]);
                gen_midcode(MIDLIST_OLD[i], temp1, MIDLIST_OLD[i+2], MIDLIST_OLD[i+3]);
            }
            else
                gen_midcode(MIDLIST_OLD[i], MIDLIST_OLD[i+1], MIDLIST_OLD[i+2], MIDLIST_OLD[i+3]);
        }
        else
        {
            if(isLetter(MIDLIST_OLD[i+2][0]) || isDigit(MIDLIST_OLD[i+2][0]) || MIDLIST_OLD[i+2][0] == '-')
                gen_midcode(MIDLIST_OLD[i], MIDLIST_OLD[i+1], MIDLIST_OLD[i+2], MIDLIST_OLD[i+3]);
            else
            {
                tmp = trans_regnum(MIDLIST_OLD[i+2]);
                sprintf(temp1, "~t%d", replace_reg[tmp]);
                gen_midcode(MIDLIST_OLD[i], MIDLIST_OLD[i+1], temp1, MIDLIST_OLD[i+3]);
            }
        }
    }
    else if(strcmp(MIDLIST_OLD[i], mid_op[SWTICHOP])==0)
    {
        if(isLetter(MIDLIST_OLD[i+3][0]) || isDigit(MIDLIST_OLD[i+3][0]) || MIDLIST_OLD[i+3][0] == '-')
            gen_midcode(MIDLIST_OLD[i], MIDLIST_OLD[i+1], MIDLIST_OLD[i+2], MIDLIST_OLD[i+3]);
        else
        {
            tmp = trans_regnum(MIDLIST_OLD[i+3]);
            sprintf(temp1, "~t%d", replace_reg[tmp]);
            gen_midcode(MIDLIST_OLD[i], MIDLIST_OLD[i+1], MIDLIST_OLD[i+2], temp1);
        }
    }
}
