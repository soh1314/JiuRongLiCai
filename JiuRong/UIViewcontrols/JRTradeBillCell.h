//
//  JRTradeBillCell.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/22.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRTradeBillCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *billTitle;
@property (weak, nonatomic) IBOutlet UILabel *billMoney;
@property (weak, nonatomic) IBOutlet UILabel *billTime;
@property (weak, nonatomic) IBOutlet UILabel *billStatusTag;

@end
