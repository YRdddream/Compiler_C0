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
    int dadnum;    // 节点孩子的数量
    int if_out;    // 这个节点是不是已经输出了
}dagNode;

typedef struct NodeList {
    int constorvar;   // 这个节点是常量还是变量  常量只有字符型常量和数字型常量
    int constvalue;   // 常量的值
    char var_name[100];   // 变量的名称
    int position;    // 处在DAG图中节点的序号
}NodeList;

extern int midpointer;
extern int midcnt;
extern char *MIDLIST[midcodeMAX];
extern char* mid_op[50];
extern char *out_dag[midcodeMAX];
extern int dagoutcnt;
extern char *in_dag[midcodeMAX];
extern int dagincnt;
extern char *mid_op[50];
extern dagNode dagNodeSet[200];
extern NodeList NodeListSet[200];
extern int dagNodeNum;
extern int NodeListNum;

void opt();
void func_block();
void dag_proc(int block_size);
void dag_subproc(int start, int end);
int belong_block(char a[]);
void print_subproc(int i);

#endif /* optimize_h */
