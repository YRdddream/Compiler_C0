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
#include "error.h"
#include "semantic.h"

void error(int i)
{
    printf("ERROR %d: locate in line %d!\n", i, lc);
    exit(0);
}
