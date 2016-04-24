//
//  JRGiftRecordCell.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/21.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRGiftRecord.h"
@interface JRGiftRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *giftTime;
@property (weak, nonatomic) IBOutlet UILabel *investAmount;
@property (weak, nonatomic) IBOutlet UILabel *giftIdCoder;
@property (weak, nonatomic) IBOutlet UILabel *activityGiftName;
@property (nonatomic,strong) JRGiftRecord * record;
@end
