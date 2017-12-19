//
//  error.cpp
//  test
//
//  Created by HaoYaru on 2017/11/29.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#include <stdio.h>
#include "macro.h"
#include <string.h>
#include <stdlib.h>
#include "lex.h"
#include "grammar.h"
#include "semantic.h"
#include "error.h"

void skip_symset(symset setname)
{
    while(find_symset(symbol, setname)==0)
    {
        getsym();
    }
}

void skip_sym(int to_symbol)
{
    while(symbol != to_symbol)
        getsym();
}

void error(int i)
{
    switch (i) {
        case FILE_ERROR:
            printf("ERROR[%d] in LINE%d: File NOT exists!\n", i, lc);
            exit(0);
            break;
            
        case TOOLONG_LL:
            printf("ERROR[%d] in LINE%d: The length of a line is TOO LONG!\n", i, lc);
            exit(0);
            break;
            
        case TOOLONG_WL:
            printf("ERROR[%d] in LINE%d: The length of a word/string is TOO LONG!\n", i, lc);
            exit(0);
            break;
            
        case TOOBIG_NUMBER:
            printf("ERROR[%d] in LINE%d: The number value is TOO BIG!\n", i, lc);
            exit(0);
            break;
            
        case UNDEFINED_IDENT:
            printf("ERROR[%d] in LINE%d: Undefined identifier!\n", i, lc);
            skip_sym(SEMICOLON);
            break;
            
        case REPEATDEF_IDENT:
            printf("ERROR[%d] in LINE%d: Identifier has been defined before!\n", i, lc);
            break;
            
        case ILLEGAL_CHAR:
            printf("ERROR[%d] in LINE%d: The character is illegal!\n", i, lc);
            break;
            
        case ILLEGAL_STRING:
            printf("ERROR[%d] in LINE%d: The char in string is illegal!\n", i, lc);
            break;
            
        case LOSE_RETURN:
            printf("ERROR[%d] in LINE%d: No return state in retfunction!\n", i, lc);
            break;
            
        case NO_MAIN:
            printf("ERROR[%d] in LINE%d: NO MAIN function in the program!\n", i, lc);
            exit(0);
            break;
            
        case MAIN_NOTEND:
            printf("ERROR[%d] in LINE%d: There are something AFTER MAIN function!\n", i, lc);
            exit(0);
            break;
            
        case CASE_NOT_MATCH:
            printf("ERROR[%d] in LINE%d: Case and Switch type NOT MATCH!\n", i, lc);
            break;
            
        case CASE_NOCONSTANT:     // 跳到下一个case或者}
            printf("ERROR[%d] in LINE%d: Case and Switch type NOT MATCH!\n", i, lc);
            skip_symset(case_errorBegSet);
            break;
            
        case TABLE_FULL:
            printf("ERROR[%d] in LINE%d: The table is FULL!\n", i, lc);
            exit(0);
            break;
            
        case REPEAT_CASE:
            printf("ERROR[%d] in LINE%d: There are SAME CASE value!\n", i, lc);
            skip_symset(case_errorBegSet);
            break;
            
        case SCANF_ERROR:
            printf("ERROR[%d] in LINE%d: The SCANF statement has error!\n", i, lc);
            skip_sym(SEMICOLON);
            break;
            
        case PRINTF_ERROR:
            printf("ERROR[%d] in LINE%d: The PRINTF statement has error!\n", i, lc);
            skip_sym(SEMICOLON);
            break;
            
        case EXPR_HAS_VOIDFUNC:
            printf("ERROR[%d] in LINE%d: The function FACTOR is a VOID function!\n", i, lc);
            break;
            
        case DIV_ZERO:
            printf("ERROR[%d] in LINE%d: The divisor is ZERO!\n", i, lc);
            break;
            
        case LOSE_COLON:
            printf("ERROR[%d] in LINE%d: The case should have COLON symbol!\n", i, lc);
            skip_symset(case_errorBegSet);
            break;
            
        case LOSE_SEMICOLON:
            printf("ERROR[%d] in LINE%d: You forget to add SEMICOLON after a statement!\n", i, lc);
            break;
            
        case LOSE_LBRACK:
            printf("ERROR[%d] in LINE%d: Array should have index!\n", i, lc);
            skip_symset(expr_arrayerrorEndSet);
            break;
            
        case LOSE_RBRACK:
            printf("ERROR[%d] in LINE%d: After array index, you should add a RIGHT BRACK!\n", i, lc);
            skip_sym(SEMICOLON);
            break;
            
        case LOSE_LCURLY:
            printf("ERROR[%d] in LINE%d: The function should have statements in CURLY(L)!\n", i, lc);
            break;
            
        case NO_CASE_TABLE:
            printf("ERROR[%d] in LINE%d: Switch statement should have case table!\n", i, lc);
            skip_symset(casenotableEndSet);
            break;
            
        case CONDITION_ERROR:
            printf("ERROR[%d] in LINE%d: There is error in CONDITION!\n", i, lc);
            skip_symset(conditionerrorEndSet);
            break;
            
        case LOSE_RCURLY:
            printf("ERROR[%d] in LINE%d: You forget to add RIGHT CURLY symbol!\n", i, lc);
            break;
            
        case LOSE_CHAR:
            printf("ERROR[%d] in LINE%d: You forget to add ' after a character!\n", i, lc);
            break;
            
        case STRING_NEWLINE:
            printf("ERROR[%d] in LINE%d: You forget to add \" or add new line in string!\n", i, lc);
            skip_sym(SEMICOLON);
            break;
            
        case CLEAN_ZERO:
            printf("ERROR[%d] in LINE%d: The FISRT number of number(not 0) should not be ZERO!\n", i, lc);
            break;
            
        case BEFORE_ZERO:
            printf("ERROR[%d] in LINE%d: ZERO should not have operate char before itself!\n", i, lc);
            break;
            
        case CLEAN_OPERATECH:
            printf("ERROR[%d] in LINE%d: There are too many oepration character!\n", i, lc);
            skip_sym(SEMICOLON);
            break;
            
        case ASSIGN_CONST:
            printf("ERROR[%d] in LINE%d: You should not assign a constant!\n", i, lc);
            break;
            
        case STATEMENT_ERROR:
            printf("ERROR[%d] in LINE%d: Statement Error!The symbol is not in firstset of statement!\n", i, lc);
            skip_sym(SEMICOLON);
            break;
            
        case LOSE_ASSIGN:
            printf("ERROR[%d] in LINE%d: You lose assign symbol!\n", i, lc);
            skip_sym(SEMICOLON);
            break;
            
        case PARANUMBER_ERROR:
            printf("ERROR[%d] in LINE%d: The number of para and paravalue do not match!\n", i, lc);
            break;
            
        case CONSTDEF_LOSETYPE:
            printf("ERROR[%d] in LINE%d: You forget to add TYPE when define a CONSTANT!\n", i, lc);
            skip_sym(SEMICOLON);
            break;
            
        case LOSE_TYPE:
            printf("ERROR[%d] in LINE%d: You forget to add TYPE when define a PARAMETER!\n", i, lc);
            skip_symset(conditionerrorEndSet);
            break;
            
        case UNDEFINED_FUNC:
            printf("ERROR[%d] in LINE%d: The function is not defined!\n", i, lc);
            skip_sym(SEMICOLON);
            break;
            
        case REPEATDEF_FUNC:
            printf("ERROR[%d] in LINE%d: The function is DEFINED BEFORE!\n", i, lc);
            break;
            
        case ILLEGAL_FUNCNAME:
            printf("ERROR[%d] in LINE%d: The function name is illegal or LOSE the function name!\n", i, lc);
            break;
            
        case ILLEGAL_IDENT_HD:
            printf("ERROR[%d] in LINE%d: Illegal identifier or Lose the identifier!\n", i, lc);
            break;
            
        case ILLEGAL_IDENT:
            printf("ERROR[%d] in LINE%d: The identifier is illegal or Lose the identifier!\n", i, lc);
            skip_sym(SEMICOLON);
            break;
            
        case ILLEGAL_PARANAME:
            printf("ERROR[%d] in LINE%d: The parameter name is illegal!\n", i, lc);
            skip_sym(RPARENT);
            break;
            
        case FUNCDEF_LOSE_LPARENT:
            printf("ERROR[%d] in LINE%d: The symbol after func define is not (!\n", i, lc);
            break;
            
        case LOSE_LPARENT:
            printf("ERROR[%d] in LINE%d: You forget to add (!\n", i, lc);
            skip_sym(RPARENT);
            break;
            
        case LOSE_RPARENT:
            printf("ERROR[%d] in LINE%d: You forget to add )!\n", i, lc);
            break;
            
        case ARRAYLEN_ZERO:
            printf("ERROR[%d] in LINE%d: The length of array is ZERO!\n", i, lc);
            break;
            
        case ARRAY_LOSE_INDEX:
            printf("ERROR[%d] in LINE%d: You can not scanf an array!\n", i, lc);
            skip_sym(RPARENT);
            break;
            
        case ASSIGN_ARRAY_ERROR:
            printf("ERROR[%d] in LINE%d: The array must have the index or index have error!\n", i, lc);
            skip_sym(SEMICOLON);
            break;
            
        case ARRAY_ERROR:
            printf("ERROR[%d] in LINE%d: The length of array have errors!\n", i, lc);
            skip_sym(SEMICOLON);
            break;
            
        case SCANF_FUNC:
            printf("ERROR[%d] in LINE%d: You should not scanf a function!\n", i, lc);
            break;
            
        case IDENT_TYPE_ERROR:
            printf("ERROR[%d] in LINE%d: The ident type and the var type doesnt match!\n", i, lc);
            skip_symset(identtypeEndSet);
            break;
            
        case EXPRESSION_ERROR:
            printf("ERROR[%d] in LINE%d: There should be factor or item or expressiton!Expr Error!\n", i, lc);
            skip_sym(SEMICOLON);
            break;
            
        case VARDEF_ERROR:
            printf("ERROR[%d] in LINE%d: Variable define has errors!\n", i, lc);
            skip_sym(SEMICOLON);
            break;
            
        case ARRAY_OVERFLOW:
            printf("ERROR[%d] in LINE%d: Array Overflow!\n", i, lc);
            break;
            
        default:
            printf("ERROR[%d] in LINE%d: There has error!\n", i, lc);
            break;
    }
    
    if_has_error = 1;
}
