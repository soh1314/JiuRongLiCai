//
//  JRItemMenu.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/2.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRItemMenu.h"

@implementation JRItemMenu
- (instancetype)initWith:(NSMutableArray *)titleArray
{
    if (self = [super init]) {
        self.titleArray = titleArray;
        [self initUIWith:self.titleArray.count];
    }
    return self;
}
- (void)initUIWith:(NSInteger)num
{
    for (int i = 0; i < num; i++) {
        UIButton * bten = [[UIButton alloc]init];
    }
}
@end
