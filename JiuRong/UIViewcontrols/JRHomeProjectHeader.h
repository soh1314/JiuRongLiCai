//
//  JRHomeProjectHeader.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/20.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRHomeProjectHeader : UIView
@property (weak, nonatomic) IBOutlet UILabel *line;
@property (weak, nonatomic) IBOutlet UILabel *projectTypeTitle;
+ (instancetype)header;
@end
