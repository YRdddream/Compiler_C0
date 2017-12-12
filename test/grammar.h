//
//  grammar.h
//  test
//
//  Created by HaoYaru on 2017/11/26.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#ifndef grammar_h
#define grammar_h

typedef struct symset
{
    int fsym[20];
    int setlen;
}symset;

extern int IOC;
extern int symbol;
extern FILE *file_out;
extern char* sym_name[50];
extern char* mid_op[50];
extern symset stateBegSet;
extern symset item_fac_exprBegSet;
extern symset case_errorBegSet;
extern symset undefined_identEndSet;
extern symset expr_arrayerrorEndSet;
extern symset casenotableEndSet;
extern symset conditionerrorEndSet;
extern symset identtypeEndSet;
// extern SymItem table[tablelMAX];
extern int tableindex[tablelMAX];
extern char tokenmid[wlMAX];
extern int elenum;
extern int levelnum;
extern char *StringList[200];
extern int if_return;

int find_symset(int symvalue, symset Aset);
void program();
void constDecl();
void constDef();
void Integer();
void retfunc_var_dec(int sym);
void varDecl(char *ident_name, int type, int flag);
void varDef(char *ident_name, int type, int flag);
void RetFuncDef(char *ident_name, int type);
void VoidFuncDef(char *ident_name);
void ParaTable();
void ComplexState();
void StatementList();
void Statement();
void MainFunc();
void Expression();
void Item();
void Factor();
void IfState();
void Condition(char *label, int if_or_dowhile);
void DowhileState();
void SwitchState();
void CaseList(char *labelend, char *basevar, int switchtype);
int CaseState(char *labelend, char *nextlabel, char *basevar, int switchtype, int casenum, int casetable[]);
void CallState(int void_or_ret, int state_or_factor);
void ParaValueList(int position);
void AssignState(int var_or_array);
void ScanfState();
void PrintfState();
void ReturnState();

#endif /* grammar_h */
