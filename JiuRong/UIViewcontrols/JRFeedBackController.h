//
//  JRFeedBackController.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/12.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRUserCenterBaseController.h"
@interface JRFeedBackController : JRUserCenterBaseController
@property (weak, nonatomic) IBOutlet UILabel *notiLabel;
@property (weak, nonatomic) IBOutlet UITextView *wordTxt;
- (IBAction)commitWord:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end
