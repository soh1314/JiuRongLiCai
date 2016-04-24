//
//  ViewController_UserModeChoose.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/25.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "ViewController_UserModeChoose.h"
#import "ViewController_Register.h"
@interface ViewController_UserModeChoose ()

@property (nonatomic,strong)UIButton * investPerson;
@property (nonatomic,strong)UIButton * lendPerson;
@property (nonatomic,assign)JRUserIdendityType IDType;
@property (nonatomic,strong)UIImageView * bgView;
@end

@implementation ViewController_UserModeChoose
- (id)init
{
    if(self = [super init])
    {
        self.title = @"用户注册";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBar];
    // Do any additional setup after loading the view.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
        if ([[segue identifier] isEqualToString:@"pushRegisterA"])
     {
         ViewController_Register *viewcontrol = (ViewController_Register*)segue.destinationViewController;
         viewcontrol.userIdentityType = self.IDType;
     }
    
}
- (void)setNavBar
{
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[Public GetBackImage] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = left;
}
- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initUI
{
    self.bgView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.bgView];
    self.bgView.image = [UIImage imageNamed:@"register_bg.jpg"];
    self.investPerson = [[UIButton alloc]initWithFrame:CGRectMake((KScreenW-167)/2.0, 150, 167, 50)];
    [self.view addSubview:self.investPerson];
    self.investPerson.tag = 10001;
    [self.investPerson setTitle:@"我是理财人" forState:UIControlStateNormal];
    [self.investPerson setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [self.investPerson setTitleColor:[UIColor colorWithRed:21/255.0 green:114/255.0 blue:239/255.0 alpha:1] forState:UIControlStateNormal];
    [self.investPerson setBackgroundImage:[UIImage resizedImageWithName:@"touch.png" left:0.5 top:0.5] forState:UIControlStateNormal];
    [self.investPerson addTarget:self action:@selector(choosePersonType:) forControlEvents:UIControlEventTouchUpInside];
    [self.investPerson addTarget:self action:@selector(scale:) forControlEvents:UIControlEventTouchDown];
    
    self.lendPerson = [[UIButton alloc]initWithFrame:CGRectMake((KScreenW-167)/2.0, 225, 167, 50)];
    [self.view addSubview:self.lendPerson];
    self.lendPerson.tag = 10002;
    [self.lendPerson setTitle:@"我是借款人" forState:UIControlStateNormal];
    [self.lendPerson setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [self.lendPerson setTitleColor:[UIColor colorWithRed:21/255.0 green:114/255.0 blue:239/255.0 alpha:1] forState:UIControlStateNormal];
    [self.lendPerson setBackgroundImage:[UIImage resizedImageWithName:@"touch.png" left:0.5 top:0.5] forState:UIControlStateNormal];
    [self.lendPerson addTarget:self action:@selector(choosePersonType:) forControlEvents:UIControlEventTouchUpInside];
    [self.lendPerson addTarget:self action:@selector(scale:) forControlEvents:UIControlEventTouchDown];
}
- (void)scale:(id)sender
{
    UIButton * bten = sender;
//    [bten setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    bten.transform = CGAffineTransformMakeScale(1.1, 1.1);
}
- (void)choosePersonType:(id)sender
{
    UIButton * bten = sender;

    if (bten.tag == 10002) {
        self.IDType = JRInvestPeronType;
        [self performSegueWithIdentifier:@"pushRegisterA" sender:self];
    }
    else
    {
        self.IDType = JRLendPersonType;
        [self performSegueWithIdentifier:@"pushRegisterA" sender:self];
    }
    
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
