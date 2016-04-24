//
//  JRGestureLockController.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/13.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,GestureLockType)
{
    GestureLockSetting = 0,
    GestureUnlock = 1
};
@interface JRGestureLockController : UIViewController
@property (nonatomic,assign)GestureLockType lockType;
@end
