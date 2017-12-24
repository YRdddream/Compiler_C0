//
//  keyWord.h
//  test
//
//  Created by HaoYaru on 2017/11/19.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#ifndef macro_h
#define macro_h


#define wlMAX 100    // 单词的最大长度
#define llMAX 2000    // 一行的最大长度
#define tablelMAX 2000 // 符号表最大长度
#define midcodeMAX 8000  // 每个函数中间代码最大长度，每一个中间代码需要四个空间，实际是2000

/*---------------Key Words-保留字---------------*/
#define MAIN 0
#define CONSTSY 1
#define INTSY 2
#define CHARSY 3
#define VOIDSY 4
#define IFSY 5
#define DOSY 6
#define WHILESY 7
#define SWITCHSY 8
#define CASESY 9
#define SCANFSY 10
#define PRINTFSY 11
#define RETURNSY 12
/*-------------Special Chars-特定字符-----------*/
#define PLUS 13     // '+'
#define MINUS 14    // '-'
#define MULTI 15    // '*'
#define DIVISION 16     // '/'
#define LSS 17     // '<'
#define LEQ 18     // '<='
#define GTR 19     // '>'
#define GEQ 20     // '>='
#define NEQ 21     // '!='
#define EQL 22     // '=='
#define SEMICOLON 25    // ';'
#define BECOMES 26     // '='
#define COMMA 27    // , 逗号
#define LBRACK 28    // '['
#define RBRACK 29    // ']'
#define LPARENT 30     // '('
#define RPARENT 31     // ')'
#define LCURLY 32     // '{'
#define RCURLY 33     // '}'
#define COLON 34     // ':'
/*-------------identifier-标识符-----------*/
#define IDENT 35     // 标识符
/*----------literal constant-字面常量--------*/
#define CHAR 23    //  '字符
#define STRING 24    // "字符串
#define NUMBER 36     // number
/*----------------eof-文件结束--------------*/
#define EOFSY 37   


/*-----------------------------错误处理----------------------------*/
#define FILE_ERROR 0     //
#define TOOLONG_LL 1     //
#define TOOLONG_WL 2   //
#define TOOBIG_NUMBER 3    //
#define UNDEFINED_IDENT 4    //
#define REPEATDEF_IDENT 5    //
#define ILLEGAL_IDENT 6    //
#define ILLEGAL_CHAR 7         //
#define ILLEGAL_STRING 8    //
#define LOSE_COLON 10    //
#define LOSE_SEMICOLON 11    //
#define LOSE_LBRACK 12    //
#define LOSE_RBRACK 13    //
#define LOSE_LCURLY 14    //
#define LOSE_RCURLY 15    //
#define LOSE_LPARENT 16    //
#define LOSE_RPARENT 17    //
#define LOSE_ASSIGN 18    //
#define LOSE_CHAR 19    //
#define UNDEFINED_FUNC 21    //
#define NO_MAIN 22    //
#define PARANUMBER_ERROR 24    //
#define LOSE_RETURN 25    //
#define LOSE_TYPE 26    //
#define CLEAN_ZERO 27    //
#define DIV_ZERO 28    // .....//
#define CLEAN_OPERATECH 29    //
#define ASSIGN_CONST 30    //
#define ARRAY_ERROR 32    //
#define ARRAY_OVERFLOW 33
#define TABLE_FULL 34    //
#define STATEMENT_ERROR 35    //
#define CONDITION_ERROR 36    //
#define CASE_NOT_MATCH 37    //
#define REPEAT_CASE 38    //
#define CASE_NOCONSTANT 39    //
#define SCANF_ERROR 40    //
#define PRINTF_ERROR 41    //
#define VARDEF_ERROR 43    //
#define EXPRESSION_ERROR 44    //
#define MAIN_NOTEND 46    //
#define EXPR_HAS_VOIDFUNC 47    //
#define STRING_NEWLINE 48    //
#define IDENT_TYPE_ERROR 49    //
#define NO_CASE_TABLE 51    //
#define BEFORE_ZERO 52    //
#define CONSTDEF_LOSETYPE 53    //
#define REPEATDEF_FUNC 54    //
#define ILLEGAL_FUNCNAME 55    //
#define ILLEGAL_IDENT_HD 56    //
#define ILLEGAL_PARANAME 57    //
#define FUNCDEF_LOSE_LPARENT 58    //
#define ARRAYLEN_ZERO 59    //
#define ARRAY_LOSE_INDEX 60    //
#define ASSIGN_ARRAY_ERROR 61    //
#define SCANF_FUNC 62    //

/*-----------------------------符号表项的类型----------------------------*/
#define CONSTTYPE 1
#define VARIABLETYPE 2
#define FUNCTIONTYPE 3
#define PARAMETER 4


/*-----------------------------符号表项的kind----------------------------*/
//#define INTKIND 1      全部更改为voidsy, intsy, charsy
//#define CHARKIND 2
//#define VOIDKIND 3


/*-----------------------------四元式生成相关----------------------------*/
#define CONSTOP 1   //
#define INTOP 2   //
#define CHAROP 3   //
#define FUNCOP 4     //
#define PARAOP 5     //
#define VALUEPARAOP 6
#define CALLOP 7
#define RETURNOP 8
#define PLUSOP 9
#define MINUSOP 10
#define MULTIOP 11
#define DIVOP 12
#define ASSIGNOP 13
#define ASSIGNARRAY 14
#define GETARRAY 15
#define EQLCON 16      // condition
#define NEQCON 17
#define GTCON 18
#define GTECON 19
#define LSCON 20
#define LSECON 21
#define JUMPOP 22    // 跳转指令
#define BNEOP 23
#define BNEZOP 24
#define BEQZOP 25
#define BGTZOP 26
#define BGEZOP 27
#define BLTZOP 28
#define BLEZOP 29
#define SETLABELOP 30   // 块内第一条语句
#define SCANFOP 31
#define PRINTFOP 32
#define ENDFUNC 33    // 
#define VOIDOP 34    //
#define SWTICHOP 35   // delete

#endif /* keyWord_h */
