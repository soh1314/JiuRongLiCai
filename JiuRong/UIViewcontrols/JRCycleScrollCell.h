//
//  JRCycleScrollCell.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/20.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
@interface JRCycleScrollCell : UITableViewCell
@property (nonatomic,retain)SDCycleScrollView * scrollview;
@property (nonatomic,copy)NSArray * imageArray;
- (void)setImageArray:(NSArray *)imageArray;
@end
