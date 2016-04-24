//
//  JRFeedBackController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/12.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRFeedBackController.h"
#import "MyIndicatorView.h"
@interface JRFeedBackController ()<UITextViewDelegate>

@end

@implementation JRFeedBackController
- (id)init
{
    if (self = [super init]) {
         self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    _commitBtn.clipsToBounds = YES;
    _commitBtn.layer.cornerRadius = 5;
    _commitBtn.backgroundColor = KGlobalColor;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    self.view.backgroundColor = RGBCOLOR(230, 230, 230);
    self.wordTxt.delegate = self;
    // Do any additional setup after loading the view from its nib.
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSMutableString * temp = [[NSMutableString alloc]initWithString:self.wordTxt.text];
    [temp replaceCharactersInRange:range withString:text];
    if ([temp isEqualToString:@""]) {
        self.notiLabel.hidden = NO;
    }
    else
    {
        self.notiLabel.hidden = YES;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
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

- (IBAction)commitWord:(id)sender {
    [MyIndicatorView showIndicatiorViewWith:@"提交成功" inView:self.view];
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
