//
//  JRDetailItemCell.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/28.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRGiftRecord.h"
@interface JRDetailItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *itemCode;
@property (weak, nonatomic) IBOutlet UILabel *giftName;
@property (nonatomic,retain)JRGiftRecord * record;
@end
