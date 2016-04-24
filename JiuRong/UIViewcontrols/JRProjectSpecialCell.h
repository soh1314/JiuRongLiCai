//
//  JRProjectSpecialCell.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/14.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPieLoopProgressView.h"
#import "QSProgressView.h"

@class BorrowInfo;
@interface JRProjectSpecialCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *projectTitle;
@property (weak, nonatomic) IBOutlet UIImageView *manbiao;

@property (weak, nonatomic) IBOutlet UILabel *yearRate;
@property (weak, nonatomic) IBOutlet UILabel *timeLimite;
@property (weak, nonatomic) IBOutlet UILabel *projectType;
@property (weak, nonatomic) IBOutlet QSProgressView *projectProgress;

- (void)UpdateInfo:(BorrowInfo*)info;
@end
