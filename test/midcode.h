//
//  midcode.h
//  test
//
//  Created by HaoYaru on 2017/12/2.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#ifndef midcode_h
#define midcode_h

extern FILE *midcode_out;
extern FILE *midcode_new_out;

extern int reg_num;
extern int str_num;
extern int label_num;
extern char midcode[llMAX];
extern char *mid_op[50];
extern char *MIDLIST[midcodeMAX];
extern char *MIDLIST_NEW[midcodeMAX];
extern int midcnt;
extern int midnewcnt;
extern int funcFlag;
extern int optmid_flag;

void gen_midcode(char *op, char *a, char *b, char *c);

#endif /* midcode_h */
