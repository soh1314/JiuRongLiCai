//
//  JRUserMessageCell.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/2.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRSystemMessageItem.h"
@interface JRUserMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *notiStatusImage;
@property (weak, nonatomic) IBOutlet UILabel *word;
@property (nonatomic,strong)JRSystemMessageItem * model;
- (void)updateMessageStatus:(NSString *)read_status;
@end
