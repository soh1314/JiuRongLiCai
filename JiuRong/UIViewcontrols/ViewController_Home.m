//
//  ViewController_Home.m
//  JiuRong
//
//  Created by iMac on 15/9/1.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_Home.h"
#import "LYViewButtons.h"
#import "CollectionViewCell_CollectMoney.h"
#import "Public.h"
#import "BorrowInfo.h"
#import "JiuRongHttp.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserInfo.h"
#import "JiuRongConfig.h"
#import "ViewController_TenderBestDetial.h"
#import "ViewController_TenderDetial.h"
#import "ViewController_Borrow.h"
#import "CollectionViewController_TransferList.h"
#import "LYAddressbook.h"
#import "UIImage+Qmethod.h"
#import "JRSaoYiSao.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "AppDelegate.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"
#import <ImageIO/ImageIO.h>
#import "UIScrollView+Associated.h"
#define SECTION_ONE 168
#define SECTION_TWO 60
#define SECTION_THREE 60

@interface ViewController_Home () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,LYViewButtonsDelegate>
{
    UIScrollView *m_pScrollviewHead;
    UIPageControl *m_pPageHead;
    NSMutableArray *m_arrayHead;
    NSTimer * timer;
    NSMutableArray *m_arrayInfos;
    UIView * maskView;
}
@end

@implementation ViewController_Home
- (id)init
{
    if (self = [super init]) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    [self SetupNavigation];
    [self.view addSubview:[self CreateNavgationView]];//隐藏导航栏 添加自定义
    _scrollviewMain.delegate = self;
    [self SetupUI];
    [self SetupHead];
    [self setNavBarItem];
    [self.collectionviewMain registerClass:[CollectionViewCell_CollectMoney class] forCellWithReuseIdentifier:@"CollectMoney"];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.collectionviewMain.delegate = self;
    self.collectionviewMain.dataSource = self;
    self.collectionviewMain.bounces = NO;
//    [self autoCheckVersion];
//    [self AutoLogin];
}

- (BOOL)autoCheckVersion
{
    float localVersion = [[Public getVersionNo] floatValue];
    __block BOOL newestVerion = NO;
    [JiuRongHttp JRGetVersionUpgrateInfo:^(NSInteger iStatus, NSString *version, NSString *url, NSString *strErrorCode,NSString * isMust) {
        if ([isMust integerValue] == 1 && [version floatValue]- localVersion > 0.1) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"久融金融" message:@"有新的版本请前往升级后再使用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 100000;
            newestVerion = YES;
            [alert show];
        }
        else if ([isMust integerValue] == 2 && ( [version floatValue]- localVersion > 0.1))
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"久融金融" message:@"有新的版本是否选择升级" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.tag = 100001;
            newestVerion = YES;
            [alert show];
        }
        else
        {
            newestVerion = YES;
        }
    } failure:^(NSError *error) {
        
    }];
    return newestVerion;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
    if (buttonIndex == 0 && alertView.tag == 100000)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/ying-ba-jin-rong/id1084612253?mt=8"]];
        maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
        [self.view.window addSubview:maskView];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateNoti:)];
        [maskView addGestureRecognizer:tap];
    }
    if (buttonIndex == 0 && alertView.tag == 100001)
    {
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/ying-ba-jin-rong/id1084612253?mt=8"]];
    }
    if (buttonIndex == 1 && alertView.tag == 100001)
    {
        
    }
}
- (void)updateNoti:(UITapGestureRecognizer *)tap
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"久融金融" message:@"请安装最新版本再使用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
- (void)setNavBarItem
{
 UIBarButtonItem * rightBarButton  = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"index_scan_normal@3x.png"]  style:UIBarButtonItemStyleDone target:self action:@selector(saoyisao:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    rightBarButton.imageInsets = UIEdgeInsetsMake(0, -15, 0,15);
}
//扫一扫功能
- (void)saoyisao:(id)sender
{
//    if([QQApiInterface isQQInstalled])
//        {
//            [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"56e26631e0f55a1d43000fc4"
//                                      shareText:@"测试分享"
//                                     shareImage:[UIImage imageNamed:@"首页logo.png"]
//                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ,UMShareToQzone,UMShareToSms,UMShareToFacebook,UMShareToTwitter,UMShareToRenren]
//                                       delegate:self];
////        }
    JRSaoYiSao * saoyisao = [[JRSaoYiSao alloc]init];
    [self.navigationController pushViewController:saoyisao animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

//    self.tabBarController.tabBar.hidden = NO;
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        [self GetHeadData];
    DDMenuController *ddmenu=(DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication]delegate]).menu;
    [ddmenu setEnableGesture:YES];
//    self.tabBarController.tabBar.hidden = NO;
//    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//     self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)ClickBtnMenu
{
    ;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)SetupHead
{
    m_arrayHead = [[NSMutableArray alloc] init];
    [m_arrayHead addObject:@"首页logo01.png"];
    [m_arrayHead addObject:@"首页logo02.png"];
    [m_arrayHead addObject:@"首页logo03.png"];
    [m_arrayHead addObject:@"首页logo04.png"];

    CGFloat fWidth = [Public GetWidth];
    m_pScrollviewHead = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, fWidth, SECTION_ONE)];
    m_pScrollviewHead.pagingEnabled = YES;
    m_pScrollviewHead.contentSize = CGSizeMake(fWidth * [m_arrayHead count], SECTION_ONE);
    m_pScrollviewHead.delegate = self;
    m_pScrollviewHead.bounces = NO;
    
    NSInteger iCount = [m_arrayHead count];
    for (NSInteger i = 0; i < iCount; i++)
    {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(fWidth * i, 0, fWidth, SECTION_ONE)];
        imageview.image = [UIImage imageNamed:m_arrayHead[i]];
        [m_pScrollviewHead addSubview:imageview];
    }
    
    [_scrollviewMain insertSubview:m_pScrollviewHead atIndex:0];
    _scrollviewMain.bounces = NO;
    m_pPageHead = [[UIPageControl alloc] init];
    m_pPageHead.frame = CGRectMake(fWidth/2-30, SECTION_ONE - 70, 60, 15);
    m_pPageHead.pageIndicatorTintColor = [UIColor blueColor];
    m_pPageHead.currentPageIndicatorTintColor = [UIColor whiteColor];
    m_pPageHead.numberOfPages = iCount;
    m_pPageHead.currentPage = 0;
    
//    [_scrollviewMain addSubview:m_pPageHead];
    
    
   timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(scrollHeadview) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)scrollHeadview
{
    static NSInteger iCount = 0;
    
    NSInteger iPage = iCount%[m_arrayHead count];
    
    CGRect frame = m_pScrollviewHead.frame;
    frame.origin.x = frame.size.width*iPage;
    [m_pScrollviewHead scrollRectToVisible:frame animated:YES];
    
    m_pPageHead.currentPage = iPage;
    iCount++;
}

- (void)SetupUI
{
    LYViewButtons *viewbuttons = [LYViewButtons CreateLYViewButtons];
    viewbuttons.frame = CGRectMake(0, SECTION_ONE, self.view.bounds.size.width, SECTION_THREE);
    viewbuttons.delegate = self;
    [_scrollviewMain addSubview:viewbuttons];
}

- (void)SetupNavigation
{
//    UIControl *leftbarView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
//    UIImageView *imageview = [[UIImageView alloc] initWithFrame:leftbarView.bounds];
//    imageview.image = [UIImage imageNamed:@"logo@2x.png"];
//    imageview.contentMode = UIViewContentModeScaleAspectFit;
//    [leftbarView addSubview:imageview];
//    [leftbarView addTarget:self action:@selector(ClickToUILocate) forControlEvents:UIControlEventTouchDown];
//    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbarView];
//    self.navigationItem.leftBarButtonItem = leftButtonItem;
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu2@2x.png"] style:UIBarButtonItemStyleDone target:self action:@selector(leftSlide:)];
    self.navigationItem.leftBarButtonItem = leftBtnItem ;
}
- (void)leftSlide:(id)sender
{
    DDMenuController *ddmenu=(DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication]delegate]).menu;
    [ddmenu setEnableGesture:YES];
    [ddmenu showLeftController:YES];
    
}
- (UIView*)CreateNavgationView
{
    UIView *leftbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    CGRect rc = leftbarView.bounds;
    rc.origin.y = 20;
    rc.size.height -= 20;
    rc.origin.x = 10;
    rc.size.width = 150;
//    UIImageView *imageview = [[UIImageView alloc] initWithFrame:rc];
//    imageview.image = [UIImage imageNamed:@"logo@2x.png"];
//    imageview.contentMode = UIViewContentModeCenter;
//    [leftbarView addSubview:imageview];
//    UILabel * label = [[UILabel alloc]initWithFrame:rc];
//    label.text = @"大学贷--爱购物,爱贷款";
//    label.font = [UIFont systemFontOfSize:14];
//    label.textColor = [UIColor blackColor];
//    [leftbarView addSubview:label];
    
    CGRect rc1 = leftbarView.bounds;
    rc1.origin.y = 20;
    rc1.size.height -= 20;
    rc1.origin.x = rc1.size.width - 40;
    rc1.size.width = 30;
//    UIImageView *imageRight = [[UIImageView alloc] initWithFrame:rc1];
//    imageRight.image = [Public GetMenuImage2];
//    imageRight.contentMode = UIViewContentModeCenter;
//    [leftbarView addSubview:imageRight];
    
    return leftbarView;
}

- (void)DidSelectedButton:(NSInteger)iOldIndex newIndex:(NSInteger)iNewIndex
{
    NSLog(@"%ld --> %ld",iOldIndex, iNewIndex);
    
    if ([UserInfo GetUserInfo].isLogin == NO)
    {
        UIViewController* pRoot = [self.storyboard instantiateViewControllerWithIdentifier:@"loginroot"];
        [self presentModalViewController:pRoot animated:YES];
    }
    else
    {
        if (iNewIndex == 0)
        {
            ViewController_Borrow* pBorrow = [self.storyboard instantiateViewControllerWithIdentifier:@"borrowHome"];
            pBorrow.viewStatus = -1;
            [self.navigationController pushViewController:pBorrow animated:YES];
            
        }
        else if (iNewIndex == 1)
        {
            UIViewController* pBorrow = [self.storyboard instantiateViewControllerWithIdentifier:@"accountBorrow"];
            [self.navigationController pushViewController:pBorrow animated:YES];
        }
        else if (iNewIndex == 2)
        {
            if ([UserInfo GetUserInfo].certifyinfo.depositstatus == 0 || [UserInfo GetUserInfo].certifyinfo.namestatus == 0)
            {
                UIViewController* pRecharge = [self.storyboard instantiateViewControllerWithIdentifier:@"certifyMember"];
                [self.navigationController pushViewController:pRecharge animated:YES];
            }
            else
            {
                UIViewController* pRecharge = [self.storyboard instantiateViewControllerWithIdentifier:@"recharge"];
                [self.navigationController pushViewController:pRecharge animated:YES];
            }
        }
        else if (iNewIndex == 3)
        {
            CollectionViewController_TransferList* pIndentity = (CollectionViewController_TransferList*)[self.storyboard instantiateViewControllerWithIdentifier:@"pushTList"];
            [self.navigationController pushViewController:pIndentity animated:YES];
        }
    }
 
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [m_arrayInfos count];
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CollectMoney";
    CollectionViewCell_CollectMoney * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [CollectionViewCell_CollectMoney CreateCollectMoneyCell];
    }
    
//    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    
    [cell UpdateInfo:m_arrayInfos[indexPath.row]];
    
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width, 65);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 5, 0, 5);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell_CollectMoney * cell = (CollectionViewCell_CollectMoney *)[collectionView cellForItemAtIndexPath:indexPath];

    if ([UserInfo GetUserInfo].isLogin == NO)
    {
        UIViewController* pRoot = [self.storyboard instantiateViewControllerWithIdentifier:@"loginroot"];
        [self presentModalViewController:pRoot animated:YES];
        return;
    }
    
    BorrowInfo *tmpinfo = m_arrayInfos[indexPath.row];
    if (tmpinfo.isbest)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [JiuRongHttp JRProjectDetial:tmpinfo.ID success:^(NSInteger iStatus, BorrowInfo *info, NSString *strErrorCode) {
            
            [SVProgressHUD dismiss];
            if (iStatus == 1)
            {
                ViewController_TenderBestDetial* pTender = [self.storyboard instantiateViewControllerWithIdentifier:@"pushBorrowBest"];
                pTender.info = info;
                [self.navigationController pushViewController:pTender animated:YES];
            }
            else
            {
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
                [alter show];
            }
        } failure:^(NSError *error) {
            
            [SVProgressHUD dismiss];
            
        }];
    }
    else
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [JiuRongHttp JRProjectDetial:tmpinfo.ID success:^(NSInteger iStatus, BorrowInfo *info, NSString *strErrorCode) {
            
            [SVProgressHUD dismiss];
            if (iStatus == 1)
            {
                ViewController_TenderDetial* pTender = [self.storyboard instantiateViewControllerWithIdentifier:@"pushBorrowNormal"];
                pTender.info = info;
                [self.navigationController pushViewController:pTender animated:YES];
            }
            else
            {
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
                [alter show];
            }
        } failure:^(NSError *error) {
            
            [SVProgressHUD dismiss];
            
        }];
    }
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)GetHeadData
{
    [SVProgressHUD showWithMaskType: SVProgressHUDMaskTypeBlack];
    [JiuRongHttp JRGetHomeData:@"true" curpage:1 pagesize:5 success:^(NSInteger iStatus, NSInteger registerNum, NSInteger platAmount, NSInteger earnAmount, NSMutableArray *products, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            _labelTotalUsers.text = [Public Number2String:registerNum];
            _labelTotaoAccount.text = [Public Number2String:platAmount];
            _labelCatch.text = [Public Number2String:earnAmount];
            
            m_arrayInfos = [NSMutableArray arrayWithArray:products];
            
            CGRect rc = self.collectionviewMain.frame;
            rc.origin.y = SECTION_ONE + SECTION_THREE + 5;
            if ([m_arrayInfos count] == 0)
            {
                rc.size.height = 0;
            }
            else
            {
                rc.size.height = 65*[m_arrayInfos count] + [m_arrayInfos count]*2 ;
            }
            
            self.collectionviewMain.frame = rc;
            self.collectionviewMain.bounces = NO;
            
            NSInteger iHeight = self.view.bounds.size.height;
            iHeight = MAX(iHeight-64, SECTION_ONE+SECTION_THREE+rc.size.height);
            
            _scrollviewMain.contentSize = CGSizeMake(self.view.bounds.size.width, iHeight);
            _scrollviewMain.frame = CGRectMake(0,0, KScreenW, KScreenH-60-64);
            [self.collectionviewMain reloadData];
            
//            LYAddressbook *book = [[LYAddressbook alloc] init];
//            [book GetAddressbookData];
        }
        else
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:nil cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            [alter show];
        }
        
        
    } failure:^(NSError *error)
    {
       [JiuRongHttp checkNetStatusWith:^(NSInteger status) {
           NSLog(@"network status -- %lu",status);
       }];
        [SVProgressHUD dismiss];
    }];
}
- (void)AutoLogin
{
    AppInfo *info = [[JiuRongConfig ShareJiuRongConfig] GetAppInfo];
    if (info.username == nil)
    {
        return;
    }
    
    if (info.password == nil)
    {
        return;
    }
    
    if (info.autologin)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [JiuRongHttp JRLogin:info.username pwd:info.password success:^(NSInteger iStatus, NSString *userid, NSString *strErrorCode) {
            
            [SVProgressHUD dismiss];
            if (iStatus == 1)
            {
                [UserInfo GetUserInfo].uid = userid;
                [UserInfo GetUserInfo].isLogin = TRUE;
                [UserInfo GetUserInfo].user = info.username;
                [UserInfo GetUserInfo].password = info.password;
                [self GetCerfityInfo:userid];
            }
            else
            {
                NSLog(@"%@",strErrorCode);
            }
            
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }
}

- (void)GetCerfityInfo:(NSString*)uid
{
    [JiuRongHttp JRGetCertifyInfo:uid success:^(NSInteger iStatus, CertifyInfo *info, NSString *strErrorCode) {
        if (iStatus == 1)
        {
            [UserInfo GetUserInfo].certifyinfo = info;
        }
    } failure:^(NSError *error) {
        ;
    }];
}

@end
