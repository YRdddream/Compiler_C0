//
//  asmcode.h
//  test
//
//  Created by HaoYaru on 2017/12/5.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#ifndef asmcode_h
#define asmcode_h

typedef struct func_s_reg
{
    char s_register[8][50];   // 变量名最大长度为50
    int svarnum;      // 总共用了几个s寄存器，最大8个
}func_s_reg;

typedef struct cite_cnt
{
    char varname[50];   // 变量名
    int cnt;
}cite_cnt;

extern FILE *ASMOUT;
extern int str_num;
extern char *StringList[200];
extern SymItem table[tablelMAX];
extern int tableindex[tablelMAX];
extern char *MIDLIST[midcodeMAX];
extern int tempReg;
extern int moveReg;
// extern int midcnt;
extern int midnewcnt;
extern int mainFlag;
extern int midpointer;
extern char* mid_op[50];
extern int mid_reg_num;
extern int t_register[8];   // $t0-$t7的内容
extern int loc_t_reg[1000][2];  // 中间代码中出现过的~txx的位置
extern char base_data[wlMAX];
extern int base_address;
extern int base_addr_offset;
extern int func_stacksize[100];
extern int round;
extern int func_cnt;

extern func_s_reg sreg[50];
extern cite_cnt cnt_array[50];
extern int sregcnt;
extern int cccnt;
extern int reg_opt;

void store_on_data(int num);
void Transfer_midreg(char string[]);
void delete_wave_line(char a[]);
int max_valuepara_num(int position);
void gen_asm();
void func_asm();
void add_cnt(char *name);
void sortcnt();

#endif /* asmcode_h */
