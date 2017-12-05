//
//  lex.h
//  test
//
//  Created by HaoYaru on 2017/11/22.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#ifndef lex_h
#define lex_h

extern FILE* file;
extern int EF;

extern int cc;
extern int ll;
extern int lc;

extern int reg_num;
extern int str_num;
extern int label_num;
extern char ch;
extern int num;
extern int symbol;
extern char token[wlMAX]; 
extern char line[llMAX];
extern char* sym_name[50];

void transfer(char a[]);
void Token2num(char a[]);
int find_keyword(char* buffer);
void getch();
void getsym();

#endif /* lex_h */
