//
//  ViewController_ProjectList.h
//  JiuRong
//
//  Created by iMac on 15/9/8.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,JRInvestProjectType)
{
    JRInvestProjectNormal = 0,
    JRInvestProjectSpecial = 1,
    JRInvestProjectZaiquan
};
@interface ViewController_ProjectList : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionviewMain;

@property (weak, nonatomic) IBOutlet UIButton *btnOne;
@property (weak, nonatomic) IBOutlet UIButton *btnTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnThree;
- (IBAction)ClickButtons:(id)sender;
@property (nonatomic,assign)JRInvestProjectType projectType;
@end
