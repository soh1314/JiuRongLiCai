//
//  JRGestureLockController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/13.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRGestureLockController.h"

#import "KKGestureLockView.h"
#import "Toast+UIView.h"
#import "CAAnimation+WAnimation.h"
#import "JRVerifyLoginPwdController.h"
@interface JRGestureLockController ()<KKGestureLockViewDelegate>
@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)KKGestureLockView * lockView;
@property (nonatomic,assign)NSInteger flag;
@property (nonatomic,strong)UILabel * toastLabel;
@property (nonatomic,copy)NSString *mypasscode;
@property (nonatomic,retain)UIButton * resetBtn;
@property (nonatomic,retain)UIButton * forgetGestureBtn;
@property (nonatomic,retain)NSArray * wordArray;
@end

@implementation JRGestureLockController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _wordArray = @[@"绘制解锁图案",@"再次绘制解锁图案",@"两次输入密码不正确"];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.toastLabel];
    _flag = 1;
    self.lockView = [[KKGestureLockView alloc]initWithFrame:CGRectMake(25, 150, self.view.frame.size.width-50, self.view.frame.size.width-50)];
    [self.view addSubview:self.lockView];
    [self.view addSubview:self.resetBtn];
    [self.view addSubview:self.forgetGestureBtn];
    self.lockView.normalGestureNodeImage = [UIImage imageNamed:@"gesture_node_normal@2x"];
    self.lockView.selectedGestureNodeImage = [UIImage imageNamed:@"gesture_node_correct"];
    self.lockView.lineColor = [UIColor colorWithRed:44/255.0 green:126/255.0f blue:242/255.0 alpha:1];
    self.lockView.lineWidth = 5;
    self.lockView.delegate = self;
}
- (UIButton *)resetBtn
{
    if (!_resetBtn) {
        _resetBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenW/2.0-50, CGRectGetMaxY(self.lockView.frame)+ 20, 100, 20)];
        [_resetBtn setTitle:@"" forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.lockType == 0 ? _resetBtn.hidden = NO :(_resetBtn.hidden = YES);
        [_resetBtn addTarget:self action:@selector(resetGest:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}
- (void)resetGest:(id)sender
{
    _flag = 1;
    self.toastLabel.text = self.wordArray[0];
}
- (UIButton *)forgetGestureBtn
{
    if (!_forgetGestureBtn) {
        _forgetGestureBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenW/2.0-50, CGRectGetMaxY(self.lockView.frame)+ 20, 100, 20)];
        [_forgetGestureBtn setTitle:@"忘记手势" forState:UIControlStateNormal];
        _forgetGestureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_forgetGestureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.lockType == 0 ? _forgetGestureBtn.hidden = YES : (_forgetGestureBtn.hidden = NO);
        [_forgetGestureBtn addTarget:self action:@selector(forgetGest:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetGestureBtn;
    
}
- (void)forgetGest:(id)sender
{
    JRVerifyLoginPwdController * vc = [[JRVerifyLoginPwdController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _imageView.image = [UIImage imageNamed:@"gesture_bg"];
    }
    return _imageView;
}
- (UILabel *)toastLabel
{
    if (!_toastLabel) {
        _toastLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 110, self.view.frame.size.width-160, 20)];
        _toastLabel.textColor = [UIColor whiteColor];
        _toastLabel.text = self.wordArray[0];
        _toastLabel.font = [UIFont systemFontOfSize:14];
        _toastLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _toastLabel;
}

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didBeginWithPasscode:(NSString *)passcode{
    NSLog(@"begin:%@",passcode);
}

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didCanceledWithPasscode:(NSString *)passcode{
    //NSLog(@"cancel:%@",passcode);
}

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode{
    NSLog(@"end:%@",passcode);
    self.toastLabel.text = @"确认解锁图案";
    if (_flag == 1) {
        if (self.lockType == 0) {
            _mypasscode = passcode;
            self.toastLabel.text = self.wordArray[1];
            [self.resetBtn setTitle:@"重置密码" forState:UIControlStateNormal];
            _flag++;
        }
        else
        {
             self.toastLabel.text = @"输入手势解锁";
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            NSString * lockedPwd = [defaults objectForKey:@"lockedPwd"];
            if ([lockedPwd isEqualToString:passcode]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else
            {
                self.toastLabel.text = @"输入手势解锁";
                [self.view makeToast:@"手势错误请重新输入" duration:2.0 position:@"center"];
            }
        }

    }else if(_flag == 2){
        if ([_mypasscode isEqualToString:passcode]) {
            NSLog(@"密码设置成功");
            [self dismissViewControllerAnimated:YES completion:^(void){
                NSLog(@"密码设置成功的时候");
                
            }];
            //这里将_mypasscode值存入本地
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:_mypasscode forKey:@"lockedPwd"];
            [defaults synchronize];
            [self.view makeToast:@"设置成功" duration:2.0 position:@"center"];
        }else{
            NSLog(@"密码错误");
            self.toastLabel.text = self.wordArray[1];
            [CAAnimation shake_AnimationRepeatTimes:5 durTimes:1 forObj:self.toastLabel.layer];
            
            //提醒设置错误
            if (self.lockType == 0) {
                [self.view makeToast:@"与上次绘制图案不一致" duration:2.0 position:@"center"];
            }
            else
            {
                [self.view makeToast:@"手势错误,请重新输入" duration:2.0 position:@"center"];
            }
            
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
