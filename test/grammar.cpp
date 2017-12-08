//
//  grammar.cpp
//  test
//
//  Created by HaoYaru on 2017/11/26.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "macro.h"
#include "grammar.h"
#include "lex.h"
#include "semantic.h"
#include "error.h"
#include "midcode.h"

void init_symset()
{
    // 语句(statement)的头符号集
    stateBegSet.fsym[0] = IFSY;
    stateBegSet.fsym[1] = DOSY;
    stateBegSet.fsym[2] = SWITCHSY;
    stateBegSet.fsym[3] = LCURLY;
    stateBegSet.fsym[4] = IDENT;
    stateBegSet.fsym[5] = PRINTFSY;
    stateBegSet.fsym[6] = SCANFSY;
    stateBegSet.fsym[7] = SEMICOLON;
    stateBegSet.fsym[8] = RETURNSY;
    stateBegSet.setlen = 9;
    
    // 项(term)/因子(factor)/表达式(expression)的头符号集
    item_fac_exprBegSet.fsym[0] = IDENT;
    item_fac_exprBegSet.fsym[1] = NUMBER;
    item_fac_exprBegSet.fsym[2] = CHAR;
    item_fac_exprBegSet.fsym[3] = LPARENT;
    item_fac_exprBegSet.fsym[4] = PLUS;
    item_fac_exprBegSet.fsym[5] = MINUS;
    item_fac_exprBegSet.setlen = 6;
}

int find_symset(int symvalue, symset Aset)
{
    int i = 0;
    int result = 0;   // 是否找到
    
    for(i=0; i<Aset.setlen; i++)
    {
        if(symvalue == Aset.fsym[i])
        {
            result = 1;
            break;
        }
    }
    
    return result;
}

/*--------------------------------------------------------------------------------------------------*/
// ＜程序＞::=［＜常量说明＞］［＜变量说明＞］{＜有返回值函数定义＞|＜无返回值函数定义＞}＜主函数＞
void program()
{
    int type = 0;    // 标识符种类，是int还是char
    char ident_name[wlMAX];    // 标识符的名字
    
    init_symset();
    getsym();
    if(symbol == CONSTSY)
        constDecl();
    
    if(symbol == INTSY || symbol == CHARSY)
        retfunc_var_dec(symbol);    // 回读判断是变量定义还是函数定义
    
    while(symbol == INTSY || symbol == CHARSY || symbol == VOIDSY)   // 这时候肯定是函数定义
    {
        type = symbol;
        
        getsym();
        if(symbol == IDENT || symbol == MAIN)      // 不是标识符则是main保留字，否则报错
            strcpy(ident_name, token);
        else
            error(LOSE_IDENT);
        
        getsym();     // 进入函数处理的时候就已经读了一个左括号了
        if(symbol == LPARENT)
        {
            if(type == VOIDSY)
            {
                if(strcmp(ident_name, sym_name[MAIN]) == 0)
                    break;        // 说明是main函数，退出，进入主函数处理子程序
                else
                    VoidFuncDef(ident_name);
            }
            else
                RetFuncDef(ident_name, type);
        }
        else
            error(LOSE_LPARENT);
    }
    
    if(strcmp(ident_name, sym_name[MAIN]) != 0)// main function
        error(NO_MAIN);
    else
    {
        levelnum++;
        tableindex[levelnum] = elenum;
        EnterTab(ident_name, FUNCTIONTYPE, VOIDSY, 0, 0, 0, 0);
        MainFunc();
    }
    
    if(symbol != EOFSY)
        error(MAIN_NOTEND);
}

// ＜常量说明＞::= const＜常量定义＞;{ const＜常量定义＞;}   checked
void constDecl()
{
    do{
        getsym();
        if(symbol == INTSY || symbol == CHARSY)
            constDef();
        else
            error(LOSE_TYPE);    // 跳到下一个;
        
        if(symbol == SEMICOLON)
            getsym();
        else
            error(LOSE_SEMICOLON);   // 不处理
    }while(symbol == CONSTSY);
}

// ＜常量定义＞::= int＜标识符＞＝＜整数＞{,＜标识符＞＝＜整数＞} | char＜标识符＞＝＜字符＞{,＜标识符＞＝＜字符＞}  midcode
void constDef()
{
    char constname[wlMAX];
    char constvalue[wlMAX];
    
    if(symbol == INTSY)     // int
    {
        do {
            getsym();
            if(symbol == IDENT)
                strcpy(constname, token);    // 此时token中存放标识符名字，要填符号表
            else
                error(LOSE_IDENT);  // 缺少标识符，跳到下一个,或者;
            
            getsym();
            if(symbol == BECOMES)
                getsym();
            else
                error(LOSE_ASSIGN);   // 缺少=，跳到下一个,或者;
            
            if(symbol == PLUS || symbol == MINUS || symbol == NUMBER)
                Integer();
            else
                error(IDENT_TYPE_ERROR);
            
            EnterTab(constname, CONSTTYPE, INTSY, num, 0, 0, 0);
            
            sprintf(constvalue, "%d", num);
            gen_midcode(mid_op[CONSTOP], mid_op[INTOP], constvalue, constname);
        } while (symbol == COMMA);
    }
    else     // char
    {
        do {
            getsym();
            if(symbol == IDENT)
                strcpy(constname, token);  // 此时token中存放标识符名字，要填符号表
            else
                error(LOSE_IDENT);  // 缺少标识符，跳到下一个,或者;
            
            getsym();
            if(symbol == BECOMES)
                getsym();
            else
                error(LOSE_ASSIGN);   // 缺少=，跳到下一个,或者;
            
            if(symbol == CHAR)
            {
                EnterTab(constname, CONSTTYPE, CHARSY, 0, token[0], 0, 0);    // 登录符号表
                sprintf(constvalue, "%d", token[0]);
                gen_midcode(mid_op[CONSTOP], mid_op[CHAROP], constvalue, constname);
            }
            else
                error(IDENT_TYPE_ERROR);
            
            getsym();
        } while (symbol == COMMA);
    }
}

// ＜整数＞::=［＋｜－］＜无符号整数＞｜０ ------ ＜无符号整数＞::=＜非零数字＞｛＜数字＞｝   checked
void Integer()
{
    int sign = 0;    // 整数的符号
    
    if(symbol == PLUS || symbol == MINUS)
    {
        sign = symbol;
        getsym();
        if(symbol == NUMBER)
        {
            Token2num(token);
            if(num == 0)
                error(CLEAN_OPERATECH);    // 0前面不能有运算符，不处理
            if(token[0] == '0' && strlen(token) > 1)
                error(CLEAN_ZERO);
            
            if(sign == MINUS)
                num = -num;
        }
        else
            error(CLEAN_OPERATECH);     // 多余的正负号
        
        getsym();
    }
    else    // symbol = number
    {
        if(token[0] == '0' && strlen(token) > 1)
            error(CLEAN_ZERO);
        Token2num(token);
        getsym();
    }
}

// 判断这是变量说明还是有返回值函数定义     checked
void retfunc_var_dec(int sym)
{
    int type = 0;    // int还是char
    char ident_name[wlMAX];    // 标识符的名字
    
    type = sym;
    
    getsym();
    if(symbol == IDENT)
        strcpy(ident_name, token);
    else
        error(LOSE_IDENT);
    
    getsym();
    if(symbol == LPARENT)
        RetFuncDef(ident_name, type);
    else     // 变量说明
    {
        varDecl(ident_name, type, 1);
    }
}

// ＜变量说明＞::=＜变量定义＞;{＜变量定义＞;}    checked
void varDecl(char *ident_name, int type, int flag)    // flag为1代表是回读判断的变量说明，为0表示正常进入的变量说明
{
    char Default[] = "null";
    int count = 0;
    
    if(flag == 1)
    {
        varDef(ident_name, type, 1);
        if(symbol == SEMICOLON)
            getsym();
        else
            error(LOSE_SEMICOLON);
        
        if(symbol == INTSY || symbol == CHARSY)
            retfunc_var_dec(symbol);
    }
    else
    {
        do{
            if(count != 0)
                type = symbol;
            
            getsym();
            if(symbol == IDENT)
                varDef(Default, type, 0);
            else
                error(LOSE_IDENT);
            
            if(symbol == SEMICOLON)
                getsym();
            else
                error(LOSE_SEMICOLON);
            count++;
        }while(symbol == INTSY || symbol == CHARSY);
    }
}

// ＜变量定义＞::=＜类型标识符＞(＜标识符＞|＜标识符＞‘[’＜无符号整数＞‘]’){,(＜标识符＞|＜标识符＞‘[’＜无符号整数＞‘]’) }  checked
void varDef(char *ident_name, int type, int flag) //flag为1代表回读判断，此时入口symbol是标识符后面的字符;flag为0，入口symbol为ident
{
    int count = 0;
    int arraylen = 0;   // 数组长度
    char typeop[wlMAX];
    char lengthop[wlMAX];
    
    if(type == INTSY)
        strcpy(typeop, mid_op[INTOP]);
    else
        strcpy(typeop, mid_op[CHAROP]);
    
    if(flag == 0)
    {
        if(symbol == IDENT)
        {
            strcpy(ident_name, token);
            getsym();
        }
        else
            error(LOSE_IDENT);
    }
    // 这时候symbol为第一个标识符后的符号
    do {
        if(count != 0)
        {
            getsym();
            if(symbol == IDENT)
            {
                strcpy(ident_name, token);
                getsym();
            }
            else
                error(LOSE_IDENT);
        }
        switch (symbol) {       // 变量定义中，标识符后面的合法后继符
            case LBRACK:      // 数组处理
                getsym();
                if(symbol == NUMBER)
                {
                    Token2num(token);
                    if(token[0] == '0' && strlen(token)>1)
                        error(CLEAN_ZERO);
                    else if (num == 0)
                        error(ARRAY_ERROR);    // 数组长度不能是0
                    else
                        arraylen = num;
                    
                    getsym();
                    if(symbol != RBRACK)
                        error(LOSE_RBRACK);
                    EnterTab(ident_name, VARIABLETYPE, type, 0, 0, 0, arraylen);
                    sprintf(lengthop, "%d", arraylen);
                    gen_midcode(typeop, lengthop, 0, ident_name);
                    getsym();
                }
                else
                    error(ARRAY_ERROR);   // 数组长度没有定义或者不是无符号整数定义
                break;
                
            case COMMA:
                EnterTab(ident_name, VARIABLETYPE, type, 0, 0, 0, 0);
                gen_midcode(typeop, 0, 0, ident_name);
                break;
            
            case SEMICOLON:
                EnterTab(ident_name, VARIABLETYPE, type, 0, 0, 0, 0);
                gen_midcode(typeop, 0, 0, ident_name);
                break;
                
            default:
                error(ILLEGAL_FOLLOWER);
                break;
        }
        count++;
    } while (symbol == COMMA);
}

// ＜有返回值函数定义＞::=＜声明头部＞‘(’＜参数表＞‘)’ ‘{’＜复合语句＞‘}’      checked
void RetFuncDef(char *ident_name, int type)   // 此时的symbol为LPARENT
{
    char typeop[wlMAX];
    
    if(type == INTSY)
        strcpy(typeop, mid_op[INTOP]);
    else if(type == CHARSY)
        strcpy(typeop, mid_op[CHAROP]);
    
    levelnum++;
    tableindex[levelnum] = elenum;
    EnterTab(ident_name, FUNCTIONTYPE, type, 0, 0, 0, 0);
    gen_midcode(mid_op[FUNCOP], typeop, 0, ident_name);
    
    getsym();
    if(symbol == INTSY || symbol == CHARSY)
        ParaTable();
    
    if(symbol == RPARENT)   // 直接到这步，说明参数表是空的
        getsym();
    else
        error(LOSE_RPARENT);
    
    if(symbol == LCURLY)
    {
        getsym();
        ComplexState();    // 由于复合语句可以完全为空，所以不存在头符号集
    }
    else
        error(LOSE_LCURLY);
    
    if(symbol == RCURLY)
        getsym();
    else
        error(LOSE_RCURLY);
    
    gen_midcode(mid_op[ENDFUNC], 0, 0, 0);
    if(if_return == 1)
        if_return = 0;
    else
        error(LOSE_RETURN);
}

// ＜无返回值函数定义＞::= void＜标识符＞‘(’＜参数表＞‘)’ ‘{’＜复合语句＞‘}’    checked
void VoidFuncDef(char *ident_name)
{
    levelnum++;
    tableindex[levelnum] = elenum;
    EnterTab(ident_name, FUNCTIONTYPE, VOIDSY, 0, 0, 0, 0);
    gen_midcode(mid_op[FUNCOP], mid_op[VOIDOP], 0, ident_name);
    
    getsym();
    if(symbol == INTSY || symbol == CHARSY)
        ParaTable();
    
    if(symbol == RPARENT)
        getsym();
    else
        error(LOSE_RPARENT);
    
    if(symbol == LCURLY)
    {
        getsym();
        ComplexState();
    }
    else
        error(LOSE_LCURLY);
    
    if(symbol == RCURLY)
    {
        getsym();
    }
    else
        error(LOSE_RCURLY);
    gen_midcode(mid_op[ENDFUNC], 0, 0, 0);
}

// ＜参数表＞::=＜类型标识符＞＜标识符＞{,＜类型标识符＞＜标识符＞}|＜空＞ (注：这里不可能是空)    checked
void ParaTable()
{
    int count = 0;    // 入口标志，同时统计[参数个数]
    int type = 0;    // 参数的类型
    char para_name[wlMAX];   // 参数名字
    char typeop[wlMAX];
    
    do {
        if(count != 0)
            getsym();
        
        if(symbol == INTSY || symbol == CHARSY)
            type = symbol;
        else
            error(LOSE_TYPE);   // 缺少类型标识符
        
        if(type == INTSY)
            strcpy(typeop, mid_op[INTOP]);
        else
            strcpy(typeop, mid_op[CHAROP]);
        
        getsym();
        if(symbol == IDENT)
            strcpy(para_name, token);
        else
            error(LOSE_IDENT);
        
        EnterTab(para_name, PARAMETER, type, 0, 0, 0, 0);
        gen_midcode(mid_op[PARAOP], typeop, 0, para_name);
        
        getsym();
        count++;
    } while (symbol == COMMA);
    
    table[tableindex[levelnum]].length = count;   // 参数表分析完后将参数个数登记到符号表
}

// ＜复合语句＞::=［＜常量说明＞］［＜变量说明＞］＜语句列＞    checked
void ComplexState()
{
    char Default[] = "null";
    int type = 0;
    
    if(symbol == CONSTSY)
        constDecl();
    
    if(symbol == INTSY || symbol == CHARSY)
    {
        type = symbol;
        varDecl(Default, type, 0);
    }
    
    StatementList();
}

// ＜语句列＞::=｛＜语句＞｝    checked
void StatementList()
{
    while(find_symset(symbol, stateBegSet) == 1)
        Statement();
}

// ＜语句＞::=＜条件语句＞｜＜循环语句＞｜<情况语句>|‘{’＜语句列＞‘}’｜＜有返回值函数调用语句＞;|
//          ＜无返回值函数调用语句＞;｜＜赋值语句＞;｜＜读语句＞;｜＜写语句＞;｜＜空＞;｜＜返回语句＞;   checked
void Statement()
{
    int assign_or_call = 0;   // 0代表赋值语句，1代表函数调用语句
    int position = 0;    // 查到的符号表的位置
    
    switch (symbol) {
        case IFSY:
            IfState();
            break;
            
        case DOSY:
            DowhileState();
            break;
            
        case SWITCHSY:
            SwitchState();
            break;
            
        case LCURLY:
            getsym();
            StatementList();
            if(symbol == RCURLY)
                getsym();
            else
                error(LOSE_RCURLY);
            break;
            
        case IDENT:
            position = LookupTab(token, 0);
            if(position == (-1))
                error(UNDEFINED_IDENT);
            else if(table[position].type == FUNCTIONTYPE)
                assign_or_call = 1;
            //----------查符号表看是：函数调用1  赋值语句0
            if(assign_or_call == 1)
            {
                if(table[position].kind == VOIDSY)
                    CallState(0, 0);
                else
                    CallState(1, 0);
            }
            else
            {
                if(table[position].type == CONSTTYPE)
                    error(ASSIGN_CONST);
                
                if(table[position].length == 0)
                    AssignState(0);
                else
                    AssignState(1);
            }
            
            if(symbol == SEMICOLON)
                getsym();
            else
                error(LOSE_SEMICOLON);
            break;
        
        case SCANFSY:
            ScanfState();
            if(symbol == SEMICOLON)
                getsym();
            else
                error(LOSE_SEMICOLON);
            break;
            
        case PRINTFSY:
            PrintfState();
            if(symbol == SEMICOLON)
                getsym();
            else
                error(LOSE_SEMICOLON);
            break;
            
        case RETURNSY:
            ReturnState();
            if(symbol == SEMICOLON)
                getsym();
            else
                error(LOSE_SEMICOLON);
            break;
            
        case SEMICOLON:     // 空语句
            getsym();
            break;
            
        default:
            error(STATEMENT_ERROR);   // 应该不会到这里
            break;
    }
}

// ＜主函数＞::= void main‘(’‘)’ ‘{’＜复合语句＞‘}’       checked
void MainFunc()    // 入口symbol是'('
{
    gen_midcode(mid_op[FUNCOP], mid_op[VOIDOP], 0, "main");
    getsym();
    if(symbol == RPARENT)
        getsym();
    else
        error(LOSE_RPARENT);
    
    if(symbol == LCURLY)
        getsym();
    else
        error(LOSE_LCURLY);
    
    ComplexState();
    
    if(symbol == RCURLY)
    {
        getsym();
    }
    else
        error(LOSE_RCURLY);
    gen_midcode(mid_op[ENDFUNC], 0, 0, 0);
}

// ＜表达式＞::=［＋｜－］＜项＞{＜加法运算符＞＜项＞}       checked
void Expression()
{
    int sign = 0;    // 第一个项的正负，0为正，1为负
    char temp1[wlMAX];
    char temp2[wlMAX];
    int type = 0;
    int ifsign = 0;    // 判断第一个项前面是否有正负号
    IOC = 0;
    
    if(symbol == PLUS || symbol == MINUS)    // + - 修饰第一个项
    {
        ifsign = 1;
        if(symbol == MINUS)
            sign = 1;
        getsym();
    }
    
    if(find_symset(symbol, item_fac_exprBegSet) == 1)
    {
        Item();
        strcpy(temp1, tokenmid);
        if(sign == 1)
        {
            sprintf(tokenmid, "~t%d", reg_num++);
            gen_midcode("-", temp1, 0, tokenmid);
            strcpy(temp1, tokenmid);
        }
    }
    else
        error(EXPRESSION_ERROR);
    
    while(symbol == PLUS || symbol == MINUS)
    {
        type = symbol;
        getsym();
        if(find_symset(symbol, item_fac_exprBegSet) == 1)
        {
            Item();
            strcpy(temp2, tokenmid);
        }
        else
            error(EXPRESSION_ERROR);
        
        sprintf(tokenmid, "~t%d", reg_num++);
        if(type == PLUS)
            gen_midcode(mid_op[PLUSOP], temp1, temp2, tokenmid);
        else
            gen_midcode(mid_op[MINUSOP], temp1, temp2, tokenmid);
        strcpy(temp1, tokenmid);
        IOC = 0;
    }
    
    if(ifsign == 1)
        IOC = 0;     // 考验一下+'a'的表达式
}

// ＜项＞::=＜因子＞{＜乘法运算符＞＜因子＞}      midcode
void Item()
{
    char temp1[wlMAX];
    char temp2[wlMAX];
    int type = 0;
    
    if(find_symset(symbol, item_fac_exprBegSet) == 1)
    {
        Factor();
        strcpy(temp1, tokenmid);
    }
    else
        error(EXPRESSION_ERROR);
    
    while(symbol == MULTI || symbol == DIVISION)
    {
        type = symbol;
        getsym();
        if(find_symset(symbol, item_fac_exprBegSet) == 1)
        {
            Factor();
            strcpy(temp2, tokenmid);
        }
        else
            error(EXPRESSION_ERROR);
        sprintf(tokenmid, "~t%d", reg_num++);
        if(type == MULTI)
            gen_midcode(mid_op[MULTIOP], temp1, temp2, tokenmid);
        else
        {
            if(strcmp(temp2, "0") == 0)
                error(DIV_ZERO);
            gen_midcode(mid_op[DIVOP], temp1, temp2, tokenmid);
        }
        strcpy(temp1, tokenmid);
        IOC = 0;
    }
}

// ＜因子＞::=＜标识符＞｜＜标识符＞‘[’＜表达式＞‘]’｜＜整数＞|＜字符＞｜＜有返回值函数调用语句＞|‘(’＜表达式＞‘)’   checked
void Factor()
{
    int type = 0;
    int position = 0;
    char ident_name[wlMAX];
    char temp1[wlMAX];
    
    switch (symbol) {
        case IDENT:
            strcpy(ident_name, token);
            position = LookupTab(token, 0);
            if(position == (-1))
                error(UNDEFINED_IDENT);
            else
            {
                type = table[position].type;
                if(type == VARIABLETYPE)
                {
                    if(table[position].length == 0)   // 普通变量
                    {
                        strcpy(tokenmid, token);
                        getsym();
                    } // 四元式操作
                    else         // 数组变量
                    {
                        getsym();
                        if(symbol == LBRACK)
                            getsym();
                        else
                            error(LOSE_LBRACK);
                        
                        if(find_symset(symbol, item_fac_exprBegSet) == 1)
                        {
                            Expression();
                            strcpy(temp1, tokenmid);
                        }
                        else
                            error(ARRAY_ERROR);
                        
                        if(symbol == RBRACK)
                            getsym();
                        else
                            error(LOSE_RBRACK);
                        
                        if(table[position].kind == CHARSY)
                            IOC = 1;
                        sprintf(tokenmid, "~t%d",reg_num++);
                        gen_midcode(mid_op[GETARRAY], ident_name, temp1, tokenmid);
                    }
                }
                else if(type == FUNCTIONTYPE)   // 类型还可能是参数和常量,都不可能是数组
                {
                    if(table[position].kind == VOIDSY)
                        error(EXPR_HAS_VOIDFUNC);
                    else
                    {
                        CallState(1, 1);
                        sprintf(tokenmid, "~t%d", reg_num++);
                        gen_midcode(mid_op[CALLOP], ident_name, 0, tokenmid);
                        if(table[position].kind == CHARSY)
                            IOC = 1;
                    }
                }
                else   // 参数或常量
                {
                    strcpy(tokenmid, ident_name);
                    if(table[position].kind == CHARSY)
                        IOC = 1;
                    getsym();
                }
            }
            break;
            
        case CHAR:
            sprintf(temp1, "%d", token[0]);
            strcpy(tokenmid, temp1);    // 用字符的ascii码参加运算
            IOC = 1;
            getsym();
            break;
            
        case LPARENT:
            getsym();
            if(find_symset(symbol, item_fac_exprBegSet) == 1)
            {
                Expression();
                //  不需要再更新tokenmid
            }
            else
                error(EXPRESSION_ERROR);
            
            if(symbol == RPARENT)
                getsym();
            else
                error(LOSE_RPARENT);
            break;
            
        case PLUS:
            Integer();
            sprintf(temp1, "%d", num);
            strcpy(tokenmid, temp1);
            IOC = 0;
            break;
            
        case MINUS:        // 打印出来的应该是负数
            Integer();
            sprintf(temp1, "%d", num);
            strcpy(tokenmid, temp1);
            IOC = 0;
            break;
            
        case NUMBER:
            Integer();
            sprintf(temp1, "%d", num);
            strcpy(tokenmid, temp1);
            IOC = 0;
            break;
            
        default:
            error(EXPRESSION_ERROR);
            break;
    }
}

// ＜条件语句＞::= if ‘(’＜条件＞‘)’＜语句＞    checked
void IfState()
{
    char labelname[wlMAX];
    
    sprintf(tokenmid, "~label%d", label_num++);
    strcpy(labelname, tokenmid);
    getsym();
    if(symbol == LPARENT)
    {
        getsym();
        if(find_symset(symbol, item_fac_exprBegSet) == 1)
            Condition(labelname, 0);
        else
            error(CONDITION_ERROR);
    }
    else
        error(LOSE_LPARENT);
    
    if(symbol == RPARENT)
        getsym();
    else
        error(LOSE_RPARENT);
    
    if(find_symset(symbol, stateBegSet) == 1)
        Statement();
    else
        error(STATEMENT_ERROR);
    
    gen_midcode(mid_op[SETLABELOP], 0, 0, labelname);
}

// ＜条件＞::=＜表达式＞＜关系运算符＞＜表达式＞｜＜表达式＞       checked
void Condition(char *label, int if_or_dowhile)    // 0代表if，1代表dowhile
{
    char temp1[wlMAX];
    char temp2[wlMAX];
    int contype = 0;     // 关系运算的类型
    
    Expression();
    strcpy(temp1, tokenmid);
    if(symbol >= 17 && symbol <= 22)
    {
        contype = symbol;
        getsym();
    }
    else    // 单表达式条件
    {
        if(if_or_dowhile == 0)
            gen_midcode(mid_op[BEQZOP], temp1, 0, label);
        else
            gen_midcode(mid_op[BNEZOP], temp1, 0, label);
        return;
    }
    
    if(find_symset(symbol, item_fac_exprBegSet) == 1)
    {
        Expression();
        strcpy(temp2, tokenmid);
        sprintf(tokenmid, "~t%d", reg_num++);
        if(if_or_dowhile == 0)     // if语句的跳转
        {
            switch (contype) {
                case EQL:
                    gen_midcode(mid_op[EQLCON], temp1, temp2, tokenmid);
                    gen_midcode(mid_op[BNEZOP], tokenmid, 0, label);
                    break;
                    
                case NEQ:
                    gen_midcode(mid_op[NEQCON], temp1, temp2, tokenmid);
                    gen_midcode(mid_op[BEQZOP], tokenmid, 0, label);
                    break;
                    
                case GTR:
                    gen_midcode(mid_op[GTCON], temp1, temp2, tokenmid);
                    gen_midcode(mid_op[BLEZOP], tokenmid, 0, label);
                    break;
                    
                case GEQ:
                    gen_midcode(mid_op[GTECON], temp1, temp2, tokenmid);
                    gen_midcode(mid_op[BLTZOP], tokenmid, 0, label);
                    break;
                    
                case LSS:
                    gen_midcode(mid_op[LSCON], temp1, temp2, tokenmid);
                    gen_midcode(mid_op[BGEZOP], tokenmid, 0, label);
                    break;
                    
                case LEQ:
                    gen_midcode(mid_op[LSECON], temp1, temp2, tokenmid);
                    gen_midcode(mid_op[BGTZOP], tokenmid, 0, label);
                    break;
                    
                default:      // 不可能到default
                    break;
            }
        }
        else        // while语句跳转
        {
            switch (contype) {
                case EQL:
                    gen_midcode(mid_op[EQLCON], temp1, temp2, tokenmid);
                    gen_midcode(mid_op[BEQZOP], tokenmid, 0, label);
                    break;
                    
                case NEQ:
                    gen_midcode(mid_op[NEQCON], temp1, temp2, tokenmid);
                    gen_midcode(mid_op[BNEZOP], tokenmid, 0, label);
                    break;
                    
                case GTR:
                    gen_midcode(mid_op[GTCON], temp1, temp2, tokenmid);
                    gen_midcode(mid_op[BGTZOP], tokenmid, 0, label);
                    break;
                    
                case GEQ:
                    gen_midcode(mid_op[GTECON], temp1, temp2, tokenmid);
                    gen_midcode(mid_op[BGEZOP], tokenmid, 0, label);
                    break;
                    
                case LSS:
                    gen_midcode(mid_op[LSCON], temp1, temp2, tokenmid);
                    gen_midcode(mid_op[BLTZOP], tokenmid, 0, label);
                    break;
                    
                case LEQ:
                    gen_midcode(mid_op[LSECON], temp1, temp2, tokenmid);
                    gen_midcode(mid_op[BLEZOP], tokenmid, 0, label);
                    break;
                    
                default:      // 不可能到default
                    break;
            }
        }
    }
    else
        error(CONDITION_ERROR);
}

// ＜循环语句＞::= do＜语句＞while ‘(’＜条件＞‘)’     checked
void DowhileState()
{
    char labelname[wlMAX];
    
    sprintf(tokenmid, "~label%d", label_num++);
    strcpy(labelname, tokenmid);
    getsym();
    gen_midcode(mid_op[SETLABELOP], 0, 0, labelname);
    if(find_symset(symbol, stateBegSet) == 1)
        Statement();
    else
        error(STATEMENT_ERROR);
    
    if(symbol == WHILESY)
        getsym();
    else
        error(STATEMENT_ERROR);
    
    if(symbol == LPARENT)
    {
        getsym();
        if(find_symset(symbol, item_fac_exprBegSet) == 1)
            Condition(labelname, 1);
        else
            error(CONDITION_ERROR);
    }
    else
        error(LOSE_LPARENT);
    
    if(symbol == RPARENT)
        getsym();
    else
        error(LOSE_RPARENT);
}

// ＜情况语句＞::= switch ‘(’＜表达式＞‘)’ ‘{’＜情况表＞‘}’    checked
void SwitchState()
{
    char labelname[wlMAX];
    char basevar[wlMAX];    // switch后跟的表达式
    
    getsym();
    if(symbol == LPARENT)
    {
        getsym();
        if(find_symset(symbol, item_fac_exprBegSet) == 1)
        {
            Expression();
            gen_midcode(mid_op[SWTICHOP], 0, 0, tokenmid);
            strcpy(basevar, tokenmid);
        }
        else
            error(EXPRESSION_ERROR);
    }
    else
        error(LOSE_LPARENT);
    
    if(symbol == RPARENT)
        getsym();
    else
        error(LOSE_RPARENT);
    
    sprintf(tokenmid, "~label%d", label_num++);
    strcpy(labelname, tokenmid);
    
    if(symbol == LCURLY)
    {
        getsym();
        if(symbol == CASESY)
            CaseList(labelname, basevar);
        else
            error(STATEMENT_ERROR);
    }
    else
        error(LOSE_LCURLY);
    
    if(symbol == RCURLY)
        getsym();
    else
        error(LOSE_RCURLY);
    
    gen_midcode(mid_op[SETLABELOP], 0, 0, labelname);    // switch结束后设的那个label
}

// ＜情况表＞::=＜情况子语句＞{＜情况子语句＞}     checked
void CaseList(char *labelend, char *basevar)
{
    char nextlabel[wlMAX];
    
    while(symbol == CASESY)
    {
        sprintf(tokenmid, "~label%d", label_num++);
        strcpy(nextlabel, tokenmid);
        CaseState(labelend, nextlabel, basevar);
    }
}

// ＜情况子语句＞::= case＜常量＞：＜语句＞   checked
void CaseState(char *labelend, char *nextlabel, char *basevar)     // case重复的话则报错
{
    char constvalue[wlMAX];
    
    getsym();
    if(symbol == PLUS || symbol == MINUS || symbol == NUMBER)
    {
        Integer();
        sprintf(constvalue, "%d", num);
    }
    else if(symbol == CHAR)
    {
        sprintf(constvalue, "%d", token[0]);
        getsym();
    }
    else
        error(CASE_NOCONSTANT);
    
    gen_midcode(mid_op[BNEOP], basevar, constvalue, nextlabel);
    
    if(symbol == COLON)
        getsym();
    else
        error(LOSE_COLON);
    
    if(find_symset(symbol, stateBegSet) == 1)
        Statement();
    else
        error(STATEMENT_ERROR);
    
    gen_midcode(mid_op[JUMPOP], 0, 0, labelend);
    gen_midcode(mid_op[SETLABELOP], 0, 0, nextlabel);
}

// ＜有返回值函数调用语句＞ ::= ＜标识符＞‘(’＜值参数表＞‘)’       checked
// ＜无返回值函数调用语句＞ ::= ＜标识符＞‘(’＜值参数表＞‘)’   // 合并成一个函数调用语句
void CallState(int void_or_ret, int state_or_factor)    // void是0，有返回值是1
{
    int position = 0;
    char func_name[wlMAX];
    strcpy(func_name, token);
    
    position = LookupTab(func_name, 0);
    if(position == (-1))
        error(UNDEFINED_FUNC);
    
    getsym();
    if(symbol == LPARENT)
    {
        getsym();
        if(find_symset(symbol, item_fac_exprBegSet) == 1)
            ParaValueList(position);
    }
    else
        error(LOSE_LPARENT);
    
    if(symbol == RPARENT)
        getsym();
    else
        error(LOSE_RPARENT);
    
    if(state_or_factor == 0)
        gen_midcode(mid_op[CALLOP], func_name, 0, 0);
}

// ＜值参数表＞::=＜表达式＞{,＜表达式＞} （没有空，因为进来的话肯定是symbol是表达式的first集）   checked
void ParaValueList(int position)    // postion为当前函数在符号表中的位置
{
    int count = 0;
    
    do {
        if(count != 0)
            getsym();
        if(find_symset(symbol, item_fac_exprBegSet) == 1)
        {
            Expression();
            gen_midcode(mid_op[VALUEPARAOP], 0, 0, tokenmid);
        }
        else
            error(EXPRESSION_ERROR);
        
        count++;
    } while (symbol == COMMA);
    
    if(count != table[position].length)
        error(PARANUMBER_ERROR);
}

// ＜赋值语句＞::=＜标识符＞＝＜表达式＞|＜标识符＞‘[’＜表达式＞‘]’=＜表达式＞      checked
void AssignState(int var_or_array)    // 0是普通变量，1是数组
{
    char ident_name[wlMAX];
    char temp1[wlMAX];
    char temp2[wlMAX];
    strcpy(ident_name, token);
    
    getsym();
    if(var_or_array == 0)     // 普通变量
    {
        if(symbol == BECOMES)
        {
            getsym();
            if(find_symset(symbol, item_fac_exprBegSet) == 1)
            {
                Expression();
                gen_midcode(mid_op[ASSIGNOP], tokenmid, 0, ident_name);
            }
            else
            {
                if(symbol == LBRACK)
                    error(IDENT_TYPE_ERROR);
                else
                    error(EXPRESSION_ERROR);
            }
        }
        else
            error(LOSE_ASSIGN);
    }
    else
    {
        if(symbol == LBRACK)
        {
            getsym();
            if(find_symset(symbol, item_fac_exprBegSet) == 1)
            {
                Expression();
                strcpy(temp1, tokenmid);
            }
            else
                error(EXPRESSION_ERROR);
        }
        else
            error(ARRAY_ERROR);
        
        if(symbol == RBRACK)
            getsym();
        else
            error(ARRAY_ERROR);
        
        if(symbol == BECOMES)
        {
            getsym();
            if(find_symset(symbol, item_fac_exprBegSet) == 1)
            {
                Expression();
                strcpy(temp2, tokenmid);
                gen_midcode(mid_op[ASSIGNARRAY], ident_name, temp1, temp2);
            }
            else
                error(EXPRESSION_ERROR);
        }
        else
            error(LOSE_ASSIGN);
    }
}

// ＜读语句＞::= scanf‘(’＜标识符＞{,＜标识符＞}‘)’      checked
void ScanfState()
{
    int position = 0;
    char ident_name[wlMAX];
    char int_or_char[wlMAX];   // 0为整型，1为char型
    
    getsym();
    if(symbol != LPARENT)
        error(SCANF_ERROR);
    
    do {
        getsym();
        if(symbol == IDENT)
        {
            position = LookupTab(token, 0);
            strcpy(ident_name, token);
            if(position == (-1))
                error(UNDEFINED_IDENT);
            else if(table[position].type == CONSTTYPE)
                error(ASSIGN_CONST);
            else if (table[position].type == FUNCTIONTYPE)
                error(IDENT_TYPE_ERROR);
            else if(table[position].length != 0)
                error(ARRAY_ERROR);
            else
                getsym();
            
            if(table[position].kind == INTSY)
                sprintf(int_or_char, "%d", 0);
            else if(table[position].kind == CHARSY)
                sprintf(int_or_char, "%d", 1);
                
            gen_midcode(mid_op[SCANFOP], ident_name, 0, int_or_char);
        }
        else
            error(SCANF_ERROR);
    } while (symbol == COMMA);
    
    if(symbol == RPARENT)
        getsym();
    else
        error(LOSE_RPARENT);
}

// ＜写语句＞::= printf ‘(’＜字符串＞,＜表达式＞‘)’| printf ‘(’＜字符串＞‘)’| printf‘(’＜表达式＞‘)’   checked
void PrintfState()
{
    char temp1[wlMAX];
    
    getsym();
    if(symbol == LPARENT)
    {
        getsym();
        if(symbol == STRING)
        {
            sprintf(temp1, "~str%d", str_num);
            StringList[str_num] = (char *)malloc(200*sizeof(char));
            strcpy(StringList[str_num], token);
            strcat(StringList[str_num++], "\\n");    // 这里给每个字符串后面加一个换行符
            
            
            getsym();
            if(symbol == COMMA)
            {
                getsym();
                if(find_symset(symbol, item_fac_exprBegSet) == 1)
                {
                    Expression();
                    if(IOC == 0)
                        gen_midcode(mid_op[PRINTFOP], temp1, tokenmid, "0");
                    else
                        gen_midcode(mid_op[PRINTFOP], temp1, tokenmid, "1");
                }
                else
                    error(PRINTF_ERROR);
            }
            else
                gen_midcode(mid_op[PRINTFOP], temp1, 0, 0);
        }
        else if(find_symset(symbol, item_fac_exprBegSet) == 1)
        {
            Expression();
            if(IOC == 0)
                gen_midcode(mid_op[PRINTFOP], tokenmid, 0, "0");
            else
                gen_midcode(mid_op[PRINTFOP], tokenmid, 0, "1");
        }
        else
            error(PRINTF_ERROR);
    }
    else
        error(LOSE_LPARENT);
    
    if(symbol == RPARENT)
        getsym();
    else
        error(LOSE_RPARENT);
}

// ＜返回语句＞::= return[‘(’＜表达式＞‘)’]
void ReturnState()
{
    getsym();
    if(symbol == LPARENT)
    {
        getsym();
        if(find_symset(symbol, item_fac_exprBegSet) == 1)
        {
            Expression();
            if_return = 1;
            gen_midcode(mid_op[RETURNOP], 0, 0, tokenmid);
        }
        else
            error(EXPRESSION_ERROR);
    }
    else
    {
        gen_midcode(mid_op[RETURNOP], 0, 0, 0);
        return;
    }
    
    if(symbol == RPARENT)
        getsym();
    else
        error(LOSE_RPARENT);
}



