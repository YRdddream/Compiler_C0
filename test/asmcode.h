//
//  asmcode.h
//  test
//
//  Created by HaoYaru on 2017/12/5.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#ifndef asmcode_h
#define asmcode_h

extern FILE *ASMOUT;
extern int str_num;
extern char *StringList[200];
extern SymItem table[tablelMAX];
extern int tableindex[tablelMAX];
extern char *MIDLIST[midcodeMAX];
extern int midcnt;
extern int mainFlag;
extern int midpointer;

void gen_asm();
void func_asm();

#endif /* asmcode_h */
