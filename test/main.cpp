//
//  main.cpp
//  test
//
//  Created by HaoYaru on 2017/11/15.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include "macro.h"
#include "lex.h"
#include "grammar.h"
#include "error.h"
#include "semantic.h"
#include "midcode.h"
#include "asmcode.h"

char ch = ' ';   // 当前字符
int num = 0;   // 存放当前的数值
int symbol = 0;   // 当前识别出的单词类型
int EF = 0;
char token[wlMAX];   // 存放单词的字符串
char tokenmid[wlMAX];  // 存放当前四元式操作数
char line[llMAX];    // 当前行的内容
FILE *file;     // 全局的文件指针，为需要编译的文件
FILE *midcode_out;   // 中间代码(四元式)
FILE *ASMOUT;

char* sym_name[50];   // 需要输出的信息
char* op[50];    // 操作符和关系符的内容
char* mid_op[50];     // 和四元式生成有关的内容

symset stateBegSet;
symset item_fac_exprBegSet;
symset case_errorBegSet;
symset undefined_identEndSet;
symset expr_arrayerrorEndSet;
symset casenotableEndSet;
symset conditionerrorEndSet;
symset identtypeEndSet;

SymItem table[tablelMAX];
int tableindex[tablelMAX];
int func_stacksize[100]={0};   // 和tableindex表对应，代表函数需要多开的栈的空间
int elenum = 0;   // 符号表栈顶指针
int levelnum = 0;   // 分程序总数，及索引表栈顶指针

int ll = 0;   // 当前行长度
int cc = 0;   // character counter
int lc = 0;   // 当前行数

// midcode相关
int IOC = 0;   // 表达式结果类型是int还是char
int reg_num = 0;     // 寄存器编号
int str_num = 0;     // 字符串编号
int label_num = 0;   // label编号
char midcode[llMAX];   // 中间代码的内容
char *StringList[200];  // 程序中出现过的字符串集合
int funcFlag = 0;   // 函数开始的标记

// mips汇编码相关
int if_return = 0;     // 有无返回值标记
int tempReg = 0;   // 当前用了多少临时寄存器
int moveReg = 0;   // 需要被挪走的寄存器
char *MIDLIST[midcodeMAX];  // 从第一个function开始的midcode序列
int midcnt = 0;    // MIDLIST的计数指针
int midpointer = 0;   // MIDLIST的读取指针(汇编到了哪里)
int mainFlag = 0;    // 汇编是否编到了main函数
int t_register[8] = {0};   // $t0-$t7的内容
int loc_t_reg[1000][2] = {0};  // 中间代码中出现过的~txx的位置
int mid_reg_num = 0;   // 中间代码中的~txx后面的xx
char base_data[wlMAX];  // 全局数据区最后一个变量名
int base_address = 4;    // 盛不下的临时变量相对于base_data的地址，初始化为4
int base_addr_offset = 0;   // base_address的偏移，主要处理最后一个全局数据是数组的情况

int round = 1;    // 第几遍扫描(总共两遍扫描)
int func_cnt = 0;

// 出错处理相关
int if_has_error = 0;   // 有error就不生成汇编码
// int casetable[100] = {0};   // 主要是为了看有没有相同的case，！！不应该定义成全局的

void new_to_scan()
{
    if_return = 0;
    tempReg = 0;
    moveReg = 0;
    midpointer = 0;
    mainFlag = 0;
    memset(t_register, 0, 8*sizeof(int));
    memset(loc_t_reg, 0, 2000*sizeof(int));
    mid_reg_num = 0;
    memset(base_data, 0, wlMAX);
    base_address = 4;
    base_addr_offset = 0;
    func_cnt = 0;
}

void init_symname()    // 初始化类别码
{
    sym_name[MAIN] = "main";
    sym_name[CONSTSY] = "const";
    sym_name[INTSY] = "int";
    sym_name[CHARSY] = "char";
    sym_name[VOIDSY] = "void";
    sym_name[IFSY] = "if";
    sym_name[DOSY] = "do";
    sym_name[WHILESY] = "while";
    sym_name[SWITCHSY] = "switch";
    sym_name[CASESY] = "case";
    sym_name[SCANFSY] = "scanf";
    sym_name[PRINTFSY] = "printf";
    sym_name[RETURNSY] = "return";
    sym_name[PLUS] = "plus";
    sym_name[MINUS] = "minus";
    sym_name[MULTI] = "multi";
    sym_name[DIVISION] = "division";
    sym_name[LSS] = "less";
    sym_name[LEQ] = "lequal";
    sym_name[GTR] = "greater";
    sym_name[GEQ] = "gequal";
    sym_name[NEQ] = "notequal";
    sym_name[EQL] = "equal";
    sym_name[SEMICOLON] = "semicolon";
    sym_name[BECOMES] = "becomes";
    sym_name[COMMA] = "comma";
    sym_name[LBRACK] = "lbrack";
    sym_name[RBRACK] = "rbrack";
    sym_name[LPARENT] = "lparent";
    sym_name[RPARENT] = "rparent";
    sym_name[LCURLY] = "lcurly";
    sym_name[RCURLY] = "rcurly";
    sym_name[COLON] = "colon";
    sym_name[IDENT] = "identifier";
    sym_name[CHAR] = "char";
    sym_name[STRING] = "string";
    sym_name[NUMBER] = "number";
    
    op[PLUS] = "+";
    op[MINUS] = "-";
    op[MULTI] = "*";
    op[DIVISION] = "/";
    op[LSS] = "<";
    op[LEQ] = "<=";
    op[GTR] = ">";
    op[GEQ] = ">=";
    op[NEQ] = "!=";
    op[EQL] = "==";
    op[SEMICOLON] = ";";
    op[BECOMES] = "=";
    op[COMMA] = ",";
    op[LBRACK] = "[";
    op[RBRACK] = "]";
    op[LPARENT] = "(";
    op[RPARENT] = ")";
    op[LCURLY] = "{";
    op[RCURLY] = "}";
    op[COLON] = ":";
    
    mid_op[CONSTOP] = "const";//1
    mid_op[INTOP] = "int";//1
    mid_op[CHAROP] = "char";//1
    mid_op[FUNCOP] = "function";//1
    mid_op[PARAOP] = "parameter";//1
    mid_op[VALUEPARAOP] = "valuepara";//1
    mid_op[CALLOP] = "call";//1
    mid_op[RETURNOP] = "return";// 1
    mid_op[PLUSOP] = "+";//1
    mid_op[MINUSOP] = "-";//1
    mid_op[MULTIOP] = "*";//1
    mid_op[DIVOP] = "/";//1
    mid_op[ASSIGNOP] = "=";//1
    mid_op[ASSIGNARRAY] = "[]=";//1
    mid_op[GETARRAY] = "=[]";//1
    mid_op[EQLCON] = "==";//1
    mid_op[NEQCON] = "!=";//1
    mid_op[GTCON] = ">";//1
    mid_op[GTECON] = ">=";//1
    mid_op[LSCON] = "<";//1
    mid_op[LSECON] = "<=";//1
    mid_op[JUMPOP] = "jump";//1
    mid_op[BNEOP] = "bne";//1
    mid_op[BNEZOP] = "bnez";//1
    mid_op[BEQZOP] = "beqz";//1
    mid_op[BGTZOP] = "bgtz";//1
    mid_op[BGEZOP] = "bgez";//1
    mid_op[BLTZOP] = "bltz";//1
    mid_op[BLEZOP] = "blez";//1
    mid_op[SETLABELOP] = "setlabel";//1
    mid_op[SCANFOP] = "scanf";//1
    mid_op[PRINTFOP] = "printf";//1
    mid_op[ENDFUNC] = "endfunction";
    mid_op[VOIDOP] = "void";
    mid_op[SWTICHOP] = "switchhead";
}

int main() {
    
    char file_name[100];    // 需要读取的文件名
    char *hao_test;
    hao_test = 0;
    
    init_symname();
    
    printf("Please input a filename:\n");
    scanf("%s",file_name);
    file = fopen(file_name, "r");
    if(file == NULL)
        error(FILE_ERROR);
    
    midcode_out = fopen("midcode.txt", "w");
    ASMOUT = fopen("asmcode.asm", "w");
    
    getch();
    program();
    
    // 这里放优化的函数
    if(if_has_error != 0)   //  如果源程序出错
    {
        fclose(file);
        fclose(midcode_out);
        fclose(ASMOUT);
        return 0;
    }
    
    gen_asm();
    
    fclose(ASMOUT);    // 第二遍
    ASMOUT = fopen("asmcode.asm", "w");
    round++;
    new_to_scan();
    gen_asm();
    
    fclose(file);
    fclose(midcode_out);
    fclose(ASMOUT);
    
    return 0;
}
