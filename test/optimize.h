//
//  optimize.h
//  test
//
//  Created by HaoYaru on 2017/12/14.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#ifndef optimize_h
#define optimize_h

typedef struct dagNode {
    int op;    // op为0代表是叶节点  op只会出现+  -  *  /  =[]  []=  =
    int left_child;
    int right_child;    // right_child为-1代表没有右孩子
    int dadnum;    // 节点爸爸的数量
    int if_out;    // 这个节点是不是已经输出到队列里面了（只对中间节点有用）
    
    // 叶子节点的时候才会有效
    int constorvar;  // 1代表常数，2代表值
    int constvalue;    // 节点是叶子节点（即op为0的时候才有效），代表这个叶子节点的常量值
    char dag_name[100];   // 仅针对op为assignarray的时候使用，用来记录他assign的是哪个array   是这个节点的名字，都是临时变量（除了叶子节点）!!!,赋值等最后dag图都导出了再赋值
}dagNode;

typedef struct NodeList {
    int constorvar;   // 这个节点是常量还是变量  常量只有字符型常量和数字型常量
    int constvalue;   // 常量的值
    char var_name[100];   // 变量的名称
    int position;    // 处在DAG图中节点的序号
}NodeList;

// 记录初值被改变的叶子节点
typedef struct initNode {
    char var_name[100];
    int if_change = 0;    // 其初值有没有被改变
    int reg_pos = 0;
}initNode;

extern int midpointer;
extern int midcnt;
extern int midnewcnt;
extern char *MIDLIST_OLD[midcodeMAX];
extern char *MIDLIST[midcodeMAX];
extern char* mid_op[50];
// extern char *out_dag[midcodeMAX];
// extern int dagoutcnt;
// extern char *in_dag[midcodeMAX];
// extern int dagincnt;
extern char *mid_op[50];
extern dagNode dagNodeSet[200];
extern NodeList NodeListSet[200];
extern int dagNodeNum;
extern int NodeListNum;
extern initNode leafvarSet[200];
extern int leafvarNum;
extern int reg_num_new;    // 新的寄存器计数变量
extern int dagnode_out_list[200];
extern int midnode_num;
extern int replace_reg[1000];

int trans_regnum(char a[]);
void opt();
void func_block();
void dag_proc(int in_pos, int out_pos);
void dag_subproc(int start, int end);
int belong_block(char a[]);
void print_subproc(int i);

#endif /* optimize_h */
