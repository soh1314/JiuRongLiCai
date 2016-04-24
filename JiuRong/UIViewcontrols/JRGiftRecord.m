//
//  JRGiftRecord.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/21.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRGiftRecord.h"

@implementation JRGiftRecord
+ (JRGiftRecord *)creatItemWith:(NSDictionary *)dic
{
    JRGiftRecord * record = [[JRGiftRecord alloc]init];
    [record setValuesForKeysWithDictionary:dic];
    return record;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
