//
//  JRMessageDetailController.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/2.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface JRMessageDetailController : BaseViewController
@property (nonatomic,retain)NSMutableArray * messageArray;
@property (weak, nonatomic) IBOutlet UILabel *messageTitle;
@property (weak, nonatomic) IBOutlet UILabel *messageContent;
@property (weak, nonatomic) IBOutlet UILabel *messageTime;

@property (nonatomic,assign)NSInteger index;
@property (weak, nonatomic) IBOutlet UIButton *nextMessage;
- (IBAction)showNextMessage:(id)sender;
@end
