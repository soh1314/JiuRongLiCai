//
//  JRSystemMessage.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/2.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRCompanyMessageModel.h"
@interface JRSystemMessage : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *systemMessageTitle;
@property (weak, nonatomic) IBOutlet UILabel *systemMessageTime;
@property (weak, nonatomic) IBOutlet UIImageView *notiImage;
@property (nonatomic,strong)JRCompanyMessageModel * message;
- (void)updateMessageStatus:(NSString *)read_status;
@end
