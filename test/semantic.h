//
//  semantic.h
//  test
//
//  Created by HaoYaru on 2017/11/26.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#ifndef semantic_h
#define semantic_h

typedef struct SymItem
{
    char name[wlMAX];
    int type;    // CONST,VAR,FUNC,PARA
    int kind;    // 1 for int, 2 for char, 3 for void
    int intval;  // int value
    char charval;  // char value
    int address;
    int length;   // array length
}SymItem;

extern SymItem table[tablelMAX];
extern int tableindex[tablelMAX];
extern int elenum;
extern int levelnum;
extern int round;

int LookupTab(char* name, int use_or_def);
int EnterTab(char* name, int type, int kind, int intval, char chval, int address, int length);

#endif /* semantic_h */
