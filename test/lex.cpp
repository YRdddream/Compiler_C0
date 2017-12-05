//
//  lex.cpp
//  test
//
//  Created by HaoYaru on 2017/11/21.
//  Copyright © 2017年 HaoYaru. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include "macro.h"
#include "lex.h"
#include "error.h"

void transfer(char a[])   // 将标识符全部转化成小写
{
    int i = 0;
    
    while(a[i] != '\0')
    {
        if((a[i] >= 'A') && (a[i] <= 'Z'))
            a[i] += 32;
        i++;
    }
}

void Token2num(char a[])   // 字符串转换为数字
{
    num = 0;
    int i = 0;
    while(a[i])
    {
        num = num*10 + a[i] - '0';
        i++;
    }
}

int find_keyword(char* buffer)   // 查找保留字表
{
    int i = 0;
    for(i=0; i<=12; i++)
    {
        if(strcmp(buffer, sym_name[i]) == 0)
            return i;
    }
    return (-1);
}

int isLetter(char a)
{
    if(a=='_')
        return 1;
    else if ((a>='A') && (a<='Z'))
        return 1;
    else if ((a>='a') && (a<='z'))
        return 1;
    else
        return 0;
}

int isDigit_N0(char a)    // 非0数字
{
    if((a>='1') && (a<='9'))
        return 1;
    else
        return 0;
}

int isDigit(char a)
{
    if((a>='0') && (a<='9'))
        return 1;
    else
        return 0;
}

void getch()
{
    if(cc == 0)
    {
        char* test;    // 解决fgets的一个小bug，遇到最后一空行时，得到的字符串是前一行的字符串，但返回的是null
        lc++;
          //  if(lc == 154)
            //    printf("locate in 154!\n");
        test = fgets(line, llMAX, file);
        ll = strlen(line);
        
        if(ll > llMAX)
            error(TOOLONG_LL);
        
        if(test == NULL)
        {
            EF = 1;
            ch = ' ';
            symbol = EOFSY;
            return;
        }
        ch = line[cc++];
    }
    else if(cc == ll)     // 读到了行末尾
    {
        if(feof(file))    // 是否读到了文件结束
        {
            EF = 1;
            ch = ' ';
            symbol = EOFSY;
            return;
        }
        else
        {
            cc = 0;
            ch = ' ';
        }
    }
    else
        ch = line[cc++];
}

void getsym()
{
    int pos = 0;
    int rn = 0;    // 查找到的保留字编号
    char buffer[wlMAX];   // 临时保存单词的缓冲区
    int begin_line = 0;
    int end_line = 0;
    int i = 0;
    
    memset(token, 0, wlMAX);   // clear Token
    
    if(EF == 1 && ch == ' ')
    {
        symbol = EOFSY;
        return;
    }
    
    while(ch == ' ' || ch == '\n' || ch == '\t')
    {
        getch();
        if(EF == 1 && ch == ' ')
        {
            symbol = EOFSY;
            return;
        }
    }
    
    if(isLetter(ch))
    {
        do {
            buffer[pos++] = ch;
            getch();
        } while (isLetter(ch) || isDigit(ch));
        buffer[pos] = '\0';
        strcpy(token, buffer);
        transfer(buffer);
        transfer(token);
        rn = find_keyword(buffer);
        
        if(rn == (-1))
            symbol = IDENT;
        else
            symbol = rn;    // 单词是保留字
    }
    else if (isDigit(ch))
    {
        // if (isDigit_N0(ch))
        // {
            do {
                buffer[pos++] = ch;
                getch();
            } while (isDigit(ch));

            buffer[pos] = '\0';
            strcpy(token, buffer);
        // }
        /*else
        {
            num = 0;
            token[0] = '0';
            getch();
        } */
        symbol = NUMBER;
    }
    else
    {
        switch (ch)
        {
            case '\'':
                getch();
                if(isLetter(ch) || isDigit(ch) || ch=='+' || ch=='-' || ch=='*' || ch=='/')
                    token[0] = ch;
                else
                    error(ILLEGAL_CHAR);
                
                getch();
                if(ch != '\'')
                    error(LOSE_CHAR);
                
                getch();
                symbol = CHAR;
                break;
            
            case '"':
                begin_line = lc;
                do {
                    getch();
                    if(begin_line != lc)
                        error(STRING_NEWLINE);
                    
                    buffer[pos++] = ch;
                    
                    if (pos==wlMAX)
                        error(TOOLONG_WL);
                } while (ch!='"');
                buffer[pos-1] = '\0';
                
                for(i=0; i<strlen(buffer); i++)
                {
                    if(buffer[i]>126 || buffer[i]<32 || buffer[i]==34)
                        error(ILLEGAL_STRING);
                }
                
                strcpy(token, buffer);
                
                getch();
                symbol = STRING;
                break;
                
            case '+':
                getch();
                symbol = PLUS;
                break;
            
            case '-':
                getch();
                symbol = MINUS;
                break;
                
            case '*':
                getch();
                symbol = MULTI;
                break;
                
            case '/':
                getch();
                symbol = DIVISION;
                break;
                
            case '<':
                getch();
                if(ch == '=')
                {
                    symbol = LEQ;
                    getch();
                }
                else
                    symbol = LSS;
                break;
                
            case '>':
                getch();
                if(ch == '=')
                {
                    symbol = GEQ;
                    getch();
                }
                else
                    symbol = GTR;
                break;
            
            case '!':
                getch();
                if(ch == '=')
                {
                    symbol = NEQ;
                    getch();
                }
                /*else
                    error(invalid char);*/
                break;
            
            case '=':
                getch();
                if(ch == '=')
                {
                    symbol = EQL;
                    getch();
                }
                else
                    symbol = BECOMES;
                break;
                
            case ';':
                getch();
                symbol = SEMICOLON;
                break;
                
            case ',':
                getch();
                symbol = COMMA;
                break;
                
            case '[':
                getch();
                symbol = LBRACK;
                break;
                
            case ']':
                getch();
                symbol = RBRACK;
                break;
                
            case '(':
                getch();
                symbol = LPARENT;
                break;
                
            case ')':
                getch();
                symbol = RPARENT;
                break;
                
            case '{':
                getch();
                symbol = LCURLY;
                break;
                
            case '}':
                getch();
                symbol = RCURLY;
                break;
                
            case ':':
                getch();
                symbol = COLON;
                break;
                
            default:    //  '\0'
                error(ILLEGAL_CHAR);
                break;
        }
    }
}
