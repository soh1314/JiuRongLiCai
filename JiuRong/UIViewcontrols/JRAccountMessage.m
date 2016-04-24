//
//  JRAccountMessage.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/2.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRAccountMessage.h"
#import "JRSystemMessageItem.h"
#import "JRUserMessageCell.h"
#import "JRSystemMessage.h"
#import "JRCompanyMessageModel.h"
#import "JRMessageDetailController.h"
#import "WZLBadgeImport.h"
#import <MJRefresh/MJRefresh.h>
#import "JRCompanyController.h"
#import "JiuRongHttp.h"
#define KLeftEdge 10
#define KTopEdge 5
static int NavRightBarStatus;
@interface JRAccountMessage ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,retain)UIView * menuView;
@property (nonatomic,retain)UIView * slideView;
@property (nonatomic,retain)UIButton * notiBtn;
@property (nonatomic,retain)UIButton * deletBtn;
@property (nonatomic,retain)UITableView * JRMessageTable;
@property (nonatomic,retain)NSMutableArray * m_userMessage;
@property (nonatomic,retain)NSMutableArray * m_systemMessage;
@property (nonatomic,retain)UIButton * userMessageBtn;
@property (nonatomic,retain)UIButton * systemMessageBtn;
@property (nonatomic,retain)UIView * userMessageNumView;
@property (nonatomic,retain)UIView * systemMessageNumView;
@property (nonatomic,assign)NSInteger usermessageNum;
@property (nonatomic,assign)NSInteger systemMessageNum;
@property (nonatomic,retain)UITableView * JRSystemTable;
@property (nonatomic,retain)UIScrollView * containerView;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,retain)NSArray * menuItemArray;
@property (nonatomic,assign)NSInteger userMessagePage;
@property (nonatomic,assign)NSInteger systemMessagePage;
@property (nonatomic,assign)NSInteger refreshStatus;
@property (nonatomic,assign)NSInteger userMessageRefreshStatus;
@property (nonatomic,retain)NSMutableArray *sysSelectArray;
@property (nonatomic,retain)NSMutableArray * sysSelectIndex;
@property (nonatomic,retain)NSMutableArray *userSelectArray;
@property (nonatomic,retain)NSMutableArray *userSelectIndex;
@property (nonatomic,assign)NSInteger editStatus;
@property (nonatomic,retain)UIView * noDataView;
@property (nonatomic,retain)UIView * noDataView2;
@property (nonatomic,assign)NSInteger unreadMessege;
@end

@implementation JRAccountMessage
- (id)init
{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"消息中心";
        self.view.backgroundColor = RGBCOLOR(237, 237, 240);
        self.automaticallyAdjustsScrollViewInsets = NO;
        NavRightBarStatus = 0;
        _page = 0;
        _userMessagePage = 1;
        _systemMessagePage = 1;
        _refreshStatus = 0;
        _userMessageRefreshStatus = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 0;
    NavRightBarStatus = 0;
    [self setNavbar];
    [self loadSystemData];
    [self loadUserData];
    [self.view addSubview:self.systemMessageBtn];
    [self.view addSubview:self.userMessageBtn];
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.JRMessageTable];
    [self.containerView addSubview:self.JRSystemTable];
    [self.view addSubview:self.slideView];
    _menuItemArray = @[self.systemMessageBtn,self.userMessageBtn];
    [self setUpRefresh];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.JRSystemTable.header beginRefreshing];
    [self.JRMessageTable.header beginRefreshing];
    
}
- (void)loadUnreadMessage
{
    [JiuRongHttp JRGetUnreadMessageNum:[UserInfo GetUserInfo].uid status:2 success:^(NSInteger iStatus, NSString *error, NSMutableDictionary *info) {
        self.unreadMessege = [[info objectForKey:@"count"] integerValue];
        UIBarButtonItem * MessageItem = self.navigationItem.rightBarButtonItem;
        MessageItem.badgeCenterOffset = CGPointMake(-5, 10);
        [MessageItem showBadgeWithStyle:WBadgeStyleNumber value:self.unreadMessege animationType:WBadgeAnimTypeBreathe];
    } failure:^(NSError *error) {
        
    }];
}
- (void)setUpRefresh
{

    self.JRSystemTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.refreshStatus = 0;
        self.systemMessagePage = 1;
        [self loadSystemData];
        [self.JRSystemTable.header endRefreshing];
    }];
    self.JRSystemTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.systemMessagePage++;
        self.refreshStatus = 1;
        [self loadSystemData];
        [self.JRSystemTable.footer endRefreshing];
    }];
    self.JRMessageTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.userMessageRefreshStatus = 0;
        self.userMessagePage = 1;
        [self loadUserData];
        [self.JRMessageTable.header endRefreshing];
    }];
    self.JRMessageTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.userMessagePage++;
        self.userMessageRefreshStatus = 1;
        [self loadUserData];
        [self.JRMessageTable.footer endRefreshing];
    }];
    
}
- (void)loadUserData
{
    [JiuRongHttp JRGetUserMessageInfo:[UserInfo GetUserInfo].uid curpage:self.userMessagePage success:^(NSInteger iStatus, NSString *error, NSMutableDictionary *info) {
        if (iStatus == -1) {
            if (self.m_userMessage) {
                if (self.userMessageRefreshStatus == 0) {
                    [self.m_userMessage removeAllObjects];
                    self.m_userMessage = [JRSystemMessageItem arrayOfModelsFromDictionaries:info[@"page"][@"page"]];
                    [self.JRMessageTable reloadData];
                }
                else
                {
                    NSMutableArray * tempArray = [JRSystemMessageItem arrayOfModelsFromDictionaries:info[@"page"][@"page"]];
                    [_m_userMessage addObjectsFromArray:tempArray];
                }
                self.unreadMessege = 0;
                if (self.m_userMessage.count > 0) {
                    self.userMessageBtn.badgeCenterOffset = CGPointMake(-40, 10);
                    
                    for (int i = 0; i < self.m_userMessage.count; i++) {
                        JRSystemMessageItem * item = self.m_userMessage[i];
                        if ([item.read_status isEqualToString:@"未读"]) {
                            self.unreadMessege ++;
                        }
                        
                    }
                    [self.JRMessageTable reloadData];
                    self.noDataView.hidden = YES;
                }
                else
                {
                    self.noDataView.hidden = NO;
//                    [MyIndicatorView showIndicatiorViewWith:@"暂时无您的消息" inView:self.containerView];
                }
                [self.userMessageBtn showBadgeWithStyle:WBadgeStyleNumber value:self.unreadMessege animationType:WBadgeAnimTypeBreathe];
                [self.JRMessageTable reloadData];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)hideNoDataView
{
    self.page==0?self.noDataView.hidden = YES:(self.noDataView2.hidden = YES);
}
- (void)showNoDataView
{
    self.page==0?(self.noDataView.hidden = NO):(self.noDataView2.hidden = NO);
  
}

- (void)loadSystemData
{
    [JiuRongHttp JRGetCompanyMessageInfo:[UserInfo GetUserInfo].uid curpage:self.systemMessagePage success:^(NSInteger iStatus, NSString *error, NSMutableDictionary *info) {
        if (iStatus == -1) {
            if (self.m_systemMessage) {
                if (self.refreshStatus == 0) {
                    [self.m_systemMessage removeAllObjects];
                    self.m_systemMessage = [JRCompanyMessageModel arrayOfModelsFromDictionaries:info[@"ads"]];
                    [self.JRSystemTable reloadData];
                }
                else
                {
                    NSMutableArray * tempArray = [JRCompanyMessageModel arrayOfModelsFromDictionaries:info[@"ads"]];
                    [_m_systemMessage addObjectsFromArray:tempArray];
                }

                if (_m_systemMessage.count > 0) {
                    self.systemMessageBtn.badgeCenterOffset = CGPointMake(-40, 10);
                    [self.JRSystemTable reloadData];
                    self.noDataView2.hidden = YES;
                     self.systemMessageNum = self.m_userMessage.count;
                }
                else
                {
                    self.noDataView2.hidden = NO;
//                    [MyIndicatorView showIndicatiorViewWith:@"暂时无官方消息" inView:self.view.window];
                }
//                [self.systemMessageBtn showBadgeWithStyle:WBadgeStyleNumber value:self.systemMessageNum animationType:WBadgeAnimTypeBreathe];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editStatus == YES) {
        if (self.page == 0) {
            JRSystemMessageItem * model = self.m_userMessage[indexPath.row];
            if ([self.userSelectArray containsObject:model.entityId]) {
                [self.userSelectArray removeObject:model.entityId];
                [self.userSelectIndex removeObject:@(indexPath.row)];
                
            }
        }
        else
        {
            JRCompanyMessageModel * model = self.m_systemMessage[indexPath.row];
            if ([self.sysSelectArray containsObject:model.entityId]) {
                [self.sysSelectArray removeObject:model.entityId];
                [self.sysSelectIndex removeObject:@(indexPath.row)];
            }
        }
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (self.editStatus == YES) {
        if (self.page == 0) {
            JRSystemMessageItem * model = self.m_userMessage[indexPath.row];
            [self.userSelectArray addObject:model.entityId];
            [self.userSelectIndex addObject:@(indexPath.row)];
        }
        else
        {
            JRCompanyMessageModel * model = self.m_systemMessage[indexPath.row];
            [self.sysSelectArray addObject:model.entityId];
            [self.sysSelectIndex addObject:@(indexPath.row)];
        }
    }
    else
    {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.JRSystemTable) {
        JRSystemMessage * cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell updateMessageStatus:@"已读"];
    }
    else
    {
        JRUserMessageCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell updateMessageStatus:@"已读"];
    }
    JRMessageDetailController * vc = [[JRMessageDetailController alloc]init];
    vc.index = indexPath.row;
    if (tableView == self.JRMessageTable) {
        vc.messageArray = self.m_userMessage;
        vc.title = @"我的消息";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        JRCompanyController * vc = [[JRCompanyController alloc]init];
        JRCompanyMessageModel * model = self.m_systemMessage[indexPath.row];
        NSString * url_m = [NSString stringWithFormat:@"http://www.9rjr.com/front/wealthinfomation/newDetails?id=%@",model.entityId];
        [self.navigationController pushViewController:vc animated:YES];
        vc.url = url_m;
        vc.title = @"官方公告";
    }
    
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _JRSystemTable) {
        JRSystemMessage * message = [tableView dequeueReusableCellWithIdentifier:@"JRSystemMessageCellID" forIndexPath:indexPath];
        JRCompanyMessageModel * messageModel = self.m_systemMessage[indexPath.row];
        message.message = messageModel;
        return message;
    }
    else
    {
        JRUserMessageCell * message = [tableView dequeueReusableCellWithIdentifier:@"JRUserMessageCellID" forIndexPath:indexPath];
        JRSystemMessageItem * model = self.m_userMessage[indexPath.row];
        message.model = model;
        return message;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _JRSystemTable) {
        return self.m_systemMessage.count;
    }
    else
    {
        return self.m_userMessage.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (tableView == _JRSystemTable)?60:45;
}
- (void)showSystemMessage
{
    self.systemMessageBtn.backgroundColor = RGBCOLOR(17, 139, 210);
    self.page = 1;
    [self clearNavBarStatus];
    UIBarButtonItem * btenItem = self.navigationItem.rightBarButtonItem;
    btenItem.enabled = NO;
    [self.systemMessageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.systemMessageBtn.selected = YES;
    if (self.userMessageBtn.selected) {
        [self.userMessageBtn setTitleColor:RGBCOLOR(17, 139, 210) forState:UIControlStateNormal];
        self.userMessageBtn.backgroundColor = [UIColor whiteColor];;
        self.userMessageBtn.selected = NO;
    }
    self.containerView.contentOffset = CGPointMake(KScreenW, 0);
    self.title = @"官方公告";
}
- (UIButton *)systemMessageBtn
{
    if (!_systemMessageBtn) {
        _systemMessageBtn = [[UIButton alloc]initWithFrame:CGRectMake((KScreenW-3*KLeftEdge)/2.0+2*KLeftEdge, 5,(KScreenW-3*KLeftEdge)/2.0 , 40)];
        [_systemMessageBtn setTitle:@"官方公告" forState:UIControlStateNormal];
        [_systemMessageBtn setTitleColor:RGBCOLOR(17, 139, 210) forState:UIControlStateNormal];
        _systemMessageBtn.backgroundColor = [UIColor whiteColor];
        _systemMessageBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        [_systemMessageBtn addTarget:self action:@selector(showSystemMessage) forControlEvents:UIControlEventTouchUpInside];
        _systemMessageBtn.layer.borderWidth = 0.5;
        _systemMessageBtn.layer.borderColor = RGBCOLOR(17, 139, 210).CGColor;
    }
    return _systemMessageBtn;
}
- (UIButton *)userMessageBtn
{
    if (!_userMessageBtn) {
        _userMessageBtn = [[UIButton alloc]initWithFrame:CGRectMake(KLeftEdge, KTopEdge, (KScreenW-3*KLeftEdge)/2.0, 40)];
        [_userMessageBtn setTitle:@"我的消息" forState:UIControlStateNormal];
        [_userMessageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _userMessageBtn.backgroundColor = RGBCOLOR(17, 139, 210);
        _userMessageBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        _userMessageBtn.selected = YES;
        [_userMessageBtn addTarget:self action:@selector(showUserMessage) forControlEvents:UIControlEventTouchUpInside];
        _userMessageBtn.layer.borderWidth = 0.5;
        _userMessageBtn.layer.borderColor = RGBCOLOR(17, 139, 210).CGColor;
    }
    return _userMessageBtn;
}
- (void)showUserMessage
{
    self.userMessageBtn.backgroundColor = RGBCOLOR(17, 139, 210);
    self.page = 0;
    [self clearNavBarStatus];
    UIBarButtonItem * btenItem = self.navigationItem.rightBarButtonItem;
    btenItem.enabled = YES;
    [self.userMessageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.userMessageBtn.selected = YES;
    if (self.systemMessageBtn.selected) {
        [self.systemMessageBtn setTitleColor:RGBCOLOR(17, 139, 210) forState:UIControlStateNormal];
        self.systemMessageBtn.backgroundColor = [UIColor whiteColor];;
        self.systemMessageBtn.selected = NO;
    }
    self.containerView.contentOffset = CGPointMake(0, 0);
    
    self.title = @"我的消息";
}
- (NSMutableArray *)m_userMessage
{
    if (!_m_userMessage) {
        _m_userMessage = [NSMutableArray array];
    }
    return _m_userMessage;
}
- (NSMutableArray *)m_systemMessage
{
    if (!_m_systemMessage) {
        _m_systemMessage = [NSMutableArray array];
    }
    return _m_systemMessage;
}
- (UIView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, KScreenW, 0)];
        UIImageView * nodata = [[UIImageView alloc]initWithFrame:CGRectMake((KScreenW-100)/2.0, 100, 100, 100)];
        nodata.image = [UIImage imageNamed:@"无记录@2x"];
        [_noDataView addSubview:nodata];
        [self.containerView addSubview:self.noDataView];
        
    }
    return _noDataView;
}
- (UIView *)noDataView2
{
    if (!_noDataView2) {
        _noDataView2 = [[UIView alloc]initWithFrame:CGRectMake(KScreenW, 80, KScreenW, 0)];
        UIImageView * nodata = [[UIImageView alloc]initWithFrame:CGRectMake((KScreenW-100)/2.0, 100, 100, 100)];
        nodata.image = [UIImage imageNamed:@"理财无数据@2x"];
        [_noDataView2 addSubview:nodata];
        [self.containerView addSubview:self.noDataView2];
    }
    return _noDataView2;
}
- (UIView *)slideView
{
    if (!_slideView) {
        _slideView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenH-64, KScreenW, 50)];
        [_slideView addSubview:self.notiBtn];
        [_slideView addSubview:self.deletBtn];
//        _slideView.backgroundColor = [UIColor redColor];
         _slideView.backgroundColor = RGBCOLOR(237, 237, 240);
    }
    return _slideView;
}
- (UIButton *)notiBtn
{
    if (!_notiBtn) {
        _notiBtn = [[UIButton alloc]initWithFrame:CGRectMake(KLeftEdge, KTopEdge, (KScreenW-3*KLeftEdge)/2.0,50-2*KTopEdge)];
        [_notiBtn setTitle:@"全部标为已读" forState:UIControlStateNormal];
        _notiBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [_notiBtn setTitleColor:RGBCOLOR(17, 139, 210) forState:UIControlStateNormal];
        [_notiBtn addTarget:self action:@selector(notiMessageStatus:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _notiBtn;
}
- (UIScrollView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.userMessageBtn.frame)+KTopEdge, KScreenW, KScreenH-64)];
        _containerView.delegate = self;
        _containerView.showsVerticalScrollIndicator = NO;
        _containerView.showsHorizontalScrollIndicator = NO;
        _containerView.pagingEnabled = YES;
        _containerView.bounces = NO;
        _containerView.contentSize = CGSizeMake(2*KScreenW, KScreenH - 64);
    }
    return _containerView;
}
//-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //插入
    //    return UITableViewCellEditingStyleInsert;
    //删除
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}
//-(nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewRowAction *noteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"标记为已读" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        if (tableView == self.JRSystemTable)
//        {
//            JRSystemMessageItem * model = self.m_systemMessage[indexPath.row];
//            model.read_status = @"已读";
//            
//            [self refreshMessageStatus:model.entityId];
//            [tableView reloadData];
//        }
//        else
//        {
//            JRSystemMessageItem * model = self.m_userMessage[indexPath.row];
//            model.read_status = @"已读";
//            [self refreshMessageStatus:model.entityId];
//            [tableView reloadData];
//        }
//    }];
//    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        if (tableView == self.JRSystemTable) {
//            
//            JRSystemMessageItem * model = self.m_systemMessage[indexPath.row];
//            [self deleteMessageStatus:model.entityId];
//            
////            [self.JRSystemTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            [self.m_systemMessage removeObjectAtIndex:indexPath.row];
//            [self.JRSystemTable reloadData];
//        }
//        else
//        {
//            
//            JRSystemMessageItem * model = self.m_userMessage[indexPath.row];
//            [self deleteMessageStatus:model.entityId];
//            
////            [self.JRMessageTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            [self.m_userMessage removeObjectAtIndex:indexPath.row];
//            [self.JRMessageTable reloadData];
//        }
//        
//    }];
//    return @[noteAction,deleteAction];
//}
//-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"设为已读";
//}
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    switch (editingStyle) {
//        case UITableViewCellEditingStyleNone:
//        {
//            
//        }
//            break;
//        case UITableViewCellEditingStyleDelete:
//        {
//            //修改数据源，在刷新 tableView
//            if (tableView == self.JRSystemTable) {
//                [self.m_systemMessage removeObjectAtIndex:indexPath.row];
//                [self.JRSystemTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            }
//            else
//            {
//                [self.m_userMessage removeObjectAtIndex:indexPath.row];
//                [self.JRMessageTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            }
//            
//            //让表视图删除对应的行
//           
//        }
//            break;
//        case UITableViewCellEditingStyleInsert:
//        {
////            [_dataSource insertObject:@"我是新增" atIndex:indexPath.row];
////            //让表视图添加对应的行
////            [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        }
//            break;
//            
//        default:
//            break;
//    }
//}
- (UITableView *)JRMessageTable
{
    if (!_JRMessageTable) {
        _JRMessageTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-64)];
        _JRMessageTable.showsVerticalScrollIndicator = NO;
        _JRMessageTable.delegate = self;
        _JRMessageTable.dataSource = self;
        [_JRMessageTable registerNib:[UINib nibWithNibName:@"JRUserMessageCell" bundle:nil] forCellReuseIdentifier:@"JRUserMessageCellID"];
        _JRMessageTable.tableFooterView = [[UIView alloc]init];
    }
    
    return _JRMessageTable;
}
- (UITableView *)JRSystemTable
{
    if (!_JRSystemTable) {
        _JRSystemTable = [[UITableView alloc]initWithFrame:CGRectMake(KScreenW, 0, KScreenW, KScreenH-64)];
        _JRSystemTable.showsVerticalScrollIndicator = NO;
        _JRSystemTable.delegate = self;
        _JRSystemTable.dataSource = self;
        [_JRSystemTable registerNib:[UINib nibWithNibName:@"JRSystemMessage" bundle:nil] forCellReuseIdentifier:@"JRSystemMessageCellID"];
        _JRSystemTable.tableFooterView = [[UIView alloc]init];
    }
    
    return _JRSystemTable;

}
- (void)notiMessageStatus:(id)sender
{
    if (self.page == 0) {
        NSMutableString * ids = [[NSMutableString alloc]init];
        if (self.userSelectArray.count > 0)
        {
            for (int i = 0; i < self.userSelectArray.count; i++) {
                NSInteger index = [self.userSelectIndex[i] integerValue];
                JRSystemMessageItem * model = self.m_userMessage[index];
                if (i == 0) {
                    [ids appendString:[NSString stringWithFormat:@"%@",model.entityId]];
                }
                else
                {
                    [ids appendString:[NSString stringWithFormat:@",%@",model.entityId]];
                }
            }
            for (int i = 0; i < self.userSelectArray.count; i++) {
                NSInteger index = [self.userSelectIndex[i] integerValue];
                JRSystemMessageItem * model = self.m_userMessage[index];
                model.read_status = @"已读";
            }
        }
        else
        {
            for (int i = 0; i < self.m_userMessage.count; i++) {
                JRSystemMessageItem * model = self.m_userMessage[i];
                if (i == 0) {
                    [ids appendString:[NSString stringWithFormat:@"%@",model.entityId]];
                }
                else
                {
                    [ids appendString:[NSString stringWithFormat:@",%@",model.entityId]];
                }
                
            }
            for (int i = 0; i < self.m_userMessage.count; i++) {
                JRSystemMessageItem * model = self.m_userMessage[i];
                model.read_status = @"已读";
            }
        }
        [self refreshMessageStatus:ids];
        [self.JRMessageTable reloadData];
        [self.userSelectArray removeAllObjects];
        [self.userSelectIndex removeAllObjects];
    }
    else
    {
    NSMutableString * ids = [[NSMutableString alloc]init];
    for (int i = 0 ; i < self.sysSelectArray.count; i++) {
        if (i == 0) {
            [ids appendString:[NSString stringWithFormat:@"%@",self.sysSelectArray[i]]];
        }
        else
        {
        [ids appendString:[NSString stringWithFormat:@",%@",self.sysSelectArray[i]]];
        }
    }
        for (int i = 0; i < self.sysSelectIndex.count; i++) {
            NSInteger index = [self.sysSelectIndex[i] integerValue];
            JRCompanyMessageModel * model = self.m_systemMessage[index];
            model.read_status = @"已读";
        }
        [self.sysSelectIndex removeAllObjects];
        [self.sysSelectArray removeAllObjects];
    [self refreshMessageStatus:ids];
    [self.JRSystemTable reloadData];
    }
}
- (UIButton *)deletBtn
{
    if (!_deletBtn) {
        _deletBtn = [[UIButton alloc]initWithFrame:CGRectMake((KScreenW-3*KLeftEdge)/2.0+2*KLeftEdge, KTopEdge, (KScreenW-3*KLeftEdge)/2.0, 50-2*KTopEdge)];
        [_deletBtn setTitle:@"删除" forState:UIControlStateNormal];
        _deletBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [_deletBtn addTarget:self action:@selector(deletMessage:) forControlEvents:UIControlEventTouchUpInside];
        [_deletBtn setTitleColor:RGBCOLOR(17, 139, 210) forState:UIControlStateNormal];
    }
    return _deletBtn;
}
- (void)deletMessage:(id)sender
{
    if (self.page == 0) {
        
        [self deleteMessageStatus:[self idsString]];
//         [self.JRMessageTable setEditing:NO];
        self.userMessageRefreshStatus = 0;
        [self.JRMessageTable.header beginRefreshing];
        [self.userSelectIndex removeAllObjects];
        [self.userSelectArray removeAllObjects];
       
        [self.JRMessageTable reloadData];
    }
    else
    {
        [self deleteMessageStatus:[self idsString]];
//        [self.JRSystemTable setEditing:NO];
        self.refreshStatus = 0;
        [self.JRSystemTable.header beginRefreshing];
        [self.sysSelectIndex removeAllObjects];
        [self.sysSelectArray removeAllObjects];
        
        [self.JRSystemTable reloadData];
    }
     [MyIndicatorView showIndicatiorViewWith:@"删除成功" inView:self.view];
}
- (void)setNavbar
{
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editAndFinish:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}
- (void)clearNavBarStatus
{
    [self.JRMessageTable setEditing:NO];
    [self.JRSystemTable setEditing:NO];
    if (NavRightBarStatus == 1) {
        [self hideBottomView];
        NavRightBarStatus = 0;
    }
    [self.userSelectIndex removeAllObjects];
    [self.userSelectArray removeAllObjects];
    [self.sysSelectIndex removeAllObjects];
    [self.sysSelectArray removeAllObjects];
    UIBarButtonItem * btn = self.navigationItem.rightBarButtonItem;
    [btn setTitle:@"编辑"];
    NavRightBarStatus = 0;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.containerView) {
        CGPoint offset = scrollView.contentOffset;
        int page_m = offset.x/KScreenW;
        if (page_m == 0) {
            [self showUserMessage];
        }
        else
        {
            [self showSystemMessage];
        }
        if (self.page != page_m) {
            self.page = page_m;
            [self.JRMessageTable setEditing:NO];
            [self.JRSystemTable setEditing:NO];
            if (NavRightBarStatus == 1) {
                [self hideBottomView];
                NavRightBarStatus = 0;
            }
            [self.userSelectIndex removeAllObjects];
            [self.userSelectArray removeAllObjects];
            [self.sysSelectIndex removeAllObjects];
            [self.sysSelectArray removeAllObjects];
            UIBarButtonItem * btn = self.navigationItem.rightBarButtonItem;
            [btn setTitle:@"编辑"];
            NavRightBarStatus = 0;
            
        }
        self.page = page_m;
        
        
    }
}
- (void)editAndFinish:(id)sender
{
    UIBarButtonItem * btn = (UIBarButtonItem *)sender;
    if (NavRightBarStatus == 0) {
        [btn setTitle:@"完成"];
        [self showBottomView];
        if (self.page == 0) {
            [self.JRMessageTable setEditing:YES animated:YES];
            self.editStatus = YES;
        }
        else
        {
        [self.JRSystemTable setEditing:YES animated:YES];
            self.editStatus = YES;
            [self.sysSelectArray removeAllObjects];
            [self.sysSelectIndex removeAllObjects];
            [self.userSelectArray removeAllObjects];
            [self.userSelectIndex removeAllObjects];
        }
    
        NavRightBarStatus = 1;
    }
    else
    {
        [btn setTitle:@"编辑"];
        if (self.page == 0) {
            [self.JRMessageTable setEditing:NO animated:YES];
            self.editStatus = NO;
        }
        else
        {
        [self.JRSystemTable setEditing:NO animated:YES];
            self.editStatus = NO;
            
        }
        [self hideBottomView];
        NavRightBarStatus = 0;
    }
    
}
- (void)showBottomView
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = self.slideView.frame;
        rect.origin.y -= rect.size.height;
        self.slideView.frame = rect;
    }];
}
- (void)hideBottomView
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = self.slideView.frame;
        rect.origin.y += rect.size.height;
        self.slideView.frame = rect;
    }];
}
- (void)refreshMessageStatus:(NSString *)entityId
{
    [JiuRongHttp JRNoteMessageRead:[UserInfo GetUserInfo].uid ids:[NSString stringWithFormat:@"%@",entityId] success:^(NSInteger iStatus, NSString *error, NSMutableDictionary *info) {
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)deleteMessageStatus:(NSString *)entityID
{
    
    if (self.page == 0) {
        [JiuRongHttp JRDeleteUserMessageInfo:[UserInfo GetUserInfo].uid ids:[NSString stringWithFormat:@"%@",entityID]success:^(NSInteger iStatus, NSString *error, NSMutableDictionary *info) {
            
        } failure:^(NSError *error) {
            
        }];
    }
    else
    {
        [JiuRongHttp JRDeleteMessageBoxInfo:[UserInfo GetUserInfo].uid ids:[NSString stringWithFormat:@"%@",entityID] success:^(NSInteger iStatus, NSString *error, NSMutableDictionary *info) {
        
    } failure:^(NSError *error) {
        
    }];
    }
}
- (NSMutableArray *)userSelectIndex
{
    if (!_userSelectIndex) {
        _userSelectIndex = [NSMutableArray array];
    }
    return _userSelectIndex;
}
- (NSMutableArray *)sysSelectIndex
{
    if (!_sysSelectIndex) {
        _sysSelectIndex = [NSMutableArray array];
    }
    return _sysSelectIndex;
}
- (NSMutableArray *)userSelectArray
{
    if (!_userSelectArray) {
        _userSelectArray = [NSMutableArray array];
    }
    return _userSelectArray;
}
- (NSMutableArray *)sysSelectArray
{
    if (!_sysSelectArray) {
        _sysSelectArray = [NSMutableArray array];
    }
    return _sysSelectArray;
}
- (NSMutableString *)idsString
{
    NSMutableString * ids = [[NSMutableString alloc]init];
    if (self.page == 0) {
        if ([self.userSelectIndex count] > 0) {
            for (int i = 0; i < self.userSelectIndex.count; i++)
            {
                NSInteger index = [self.userSelectIndex[i] integerValue];
                JRSystemMessageItem * model = self.m_userMessage[index];
                if (i == 0) {
                    [ids appendString:[NSString stringWithFormat:@"%@",model.entityId]];
                }
                else
                {
                    [ids appendString:[NSString stringWithFormat:@",%@",model.entityId]];
                }
            }
        }

    }
    else
    {
        for (int i = 0; i < self.sysSelectIndex.count; i++)
        {
            NSInteger index = [self.sysSelectIndex[i] integerValue];
            JRCompanyMessageModel * model = self.m_systemMessage[index];
            if (i == 0) {
                [ids appendString:[NSString stringWithFormat:@"%@",model.entityId]];
            }
            else
            {
                [ids appendString:[NSString stringWithFormat:@",%@",model.entityId]];
            }
        }
    }

    return ids;
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
