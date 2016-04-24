//
//  JRUserPropertyCell.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/15.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JRUserPropertyManage;
@interface JRUserPropertyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *remainMoney;
@property (weak, nonatomic) IBOutlet UILabel *totalIncome;
@property (weak, nonatomic) IBOutlet UILabel *waitIncome;
@property (weak, nonatomic) IBOutlet UIButton *recharge;
@property (weak, nonatomic) IBOutlet UIButton *getMoney;
@property (nonatomic,weak)id <JRUserPropertyManage>delegate;
- (IBAction)recharge:(id)sender;
- (IBAction)getMoney:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@protocol JRUserPropertyManage <NSObject>

- (void)recharge;
- (void)getMoney;

@end