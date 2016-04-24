//
//  JRActivityRule.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/25.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRActivityRule.h"

@interface JRActivityRule ()
@property (nonatomic,retain)UILabel * titleLabel;
@property (nonatomic,retain)UITextView * textView;
@end

@implementation JRActivityRule

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}
- (void)initUI
{
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 150, 30)];
    self.titleLabel.textColor = [UIColor orangeColor];
    [self.view addSubview:self.titleLabel];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame)+20, KScreenW-20, 300)];
    self.textView.textColor = [UIColor blackColor];
    self.textView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.textView];
    
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
