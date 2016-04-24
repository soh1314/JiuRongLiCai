//
//  JRThreeItemCell.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/20.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRThreeItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *centerImg;
@property (weak, nonatomic) IBOutlet UIImageView *rightImg;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftWidtg;




@end
