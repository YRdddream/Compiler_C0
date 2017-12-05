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

SymItem table[tablelMAX];
int tableindex[tablelMAX];
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
    
    mid_op[CONSTOP] = "const";
    mid_op[INTOP] = "int";
    mid_op[CHAROP] = "char";
    mid_op[FUNCOP] = "function";
    mid_op[PARAOP] = "parameter";
    mid_op[VALUEPARAOP] = "valuepara";
    mid_op[CALLOP] = "call";
    mid_op[RETURNOP] = "return";
    mid_op[PLUSOP] = "+";
    mid_op[MINUSOP] = "-";
    mid_op[MULTIOP] = "*";
    mid_op[DIVOP] = "/";
    mid_op[ASSIGNOP] = "=";
    mid_op[ASSIGNARRAY] = "[]=";
    mid_op[GETARRAY] = "=[]";
    mid_op[EQLCON] = "==";
    mid_op[NEQCON] = "!=";
    mid_op[GTCON] = ">";
    mid_op[GTECON] = ">=";
    mid_op[LSCON] = "<";
    mid_op[LSECON] = "<=";
    mid_op[JUMPOP] = "jump";
    mid_op[BNEOP] = "bne";
    mid_op[BNEZOP] = "bnez";
    mid_op[BEQZOP] = "beqz";
    mid_op[BGTZOP] = "bgtz";
    mid_op[BGEZOP] = "bgez";
    mid_op[BLTZOP] = "bltz";
    mid_op[BLEZOP] = "blez";
    mid_op[SETLABELOP] = "setlabel";
    mid_op[SCANFOP] = "scanf";
    mid_op[PRINTFOP] = "printf";
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
    midcode_out = fopen("midcode.txt", "w");
    ASMOUT = fopen("asmcode.asm", "w");
    
    
    getch();
    program();
    gen_asm();
    
    fclose(file);
    fclose(midcode_out);
    fclose(ASMOUT);
    
    return 0;
}
