//
//  JRItemMenu.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/2.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JRItemMenu : UIView
@property (nonatomic,retain)NSMutableArray * titleArray;

- (instancetype)initWith:(NSMutableArray *)titleArray;

@end
