//
//  JRPastTotalGIftRecordController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/28.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRPastTotalGIftRecordController.h"
#import "JRItemGiftRecordCell.h"
@interface JRPastTotalGIftRecordController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * JRPastRecordTableView;
@property (nonatomic,strong)NSMutableArray *m_dataArray;
@property (nonatomic,retain)UIView * tableHeader;
@property (nonatomic,strong)NSMutableArray * m_timeArray;
@property (nonatomic,strong)NSMutableArray * showDetailArray;
@property (nonatomic,assign)NSInteger totalItem;
@property (nonatomic,strong)NSMutableArray * groupArray;
@end

@implementation JRPastTotalGIftRecordController
- (id)init
{
    if (self = [super init]) {
        self.title = @"往期开奖记录";
        self.view.backgroundColor = [UIColor whiteColor];
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.totalItem = 3;
    [self loadGroupData];
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    // Do any additional setup after loading the view.
}
- (void)loadGroupData
{
    [JiuRongHttp JRGetDuobaoPastRecordSuccess:^(NSInteger iStatus, NSString *error, NSMutableDictionary *info) {
        NSArray * infoList = info[@"infoList"];
        if (infoList.count == 0)
        {
            [MyIndicatorView showIndicatiorViewWith:@"暂时无开奖记录" inView:self.view];
        }
        for (int i = 0;i < infoList.count  ; i++) {
            JRGiftRecord * record = [JRGiftRecord creatItemWith:infoList[i]];
            [self.m_dataArray addObject:record];
        }
        [self.view addSubview:self.JRPastRecordTableView];
        [self.JRPastRecordTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JRGiftRecord * record = self.m_dataArray[section];
    UIView * header = [[UIView alloc]init];
    float width = (KScreenW-20)/3.0;
    
    UILabel * itemNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, width, 25)];
    [header addSubview:itemNum];
    itemNum.font = [UIFont systemFontOfSize:10];
    itemNum.text = [NSString stringWithFormat:@"%@",record.title];
    CGRect rect = itemNum.frame;
    rect.size.height = [itemNum.text boundingRectWithSize:CGSizeMake((KScreenW-20)/3.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName,nil] context:nil].size.height;
    itemNum.numberOfLines = 0;
    itemNum.lineBreakMode = NSLineBreakByWordWrapping;
    itemNum.frame = rect;
    UILabel * itemTime = [[UILabel alloc]initWithFrame:CGRectMake(10+width, (rect.size.height+20)/2.0-10, width, 20)];
    [header addSubview:itemTime];
    itemTime.font = [UIFont systemFontOfSize:12];
    itemTime.text = record.strTime;
    itemTime.textColor = [UIColor orangeColor];
    itemTime.textAlignment = NSTextAlignmentCenter;
    [header addSubview:itemTime];
    UIButton * detailBtn = [[UIButton alloc]initWithFrame:CGRectMake(10+2.5*width-30,(rect.size.height+20)/2.0-10, 60, 20)];
    [detailBtn addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
    [detailBtn setTitle:@"详情" forState:UIControlStateNormal];
    detailBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    detailBtn.backgroundColor = [UIColor redColor];
    detailBtn.clipsToBounds = YES;
    detailBtn.layer.cornerRadius = 2;
    detailBtn.tag = section+10000;
    [header addSubview:detailBtn];
    UILabel * downEdge = [[UILabel alloc]initWithFrame:CGRectMake(0, rect.size.height+20-0.5, KScreenW, 0.5)];
    downEdge.backgroundColor = [UIColor orangeColor];
    [header addSubview:downEdge];
    UILabel * downEdge2 = [[UILabel alloc]initWithFrame:CGRectMake(0, -0.5, KScreenW, 0.5)];
    downEdge2.backgroundColor = [UIColor orangeColor];
    [header addSubview:downEdge2];
    if ([self.showDetailArray[section] isEqualToString:@"0"]) {
        header.backgroundColor = [UIColor whiteColor];
        itemNum.textColor = [UIColor blackColor];
        downEdge.hidden = YES;
        downEdge2.hidden = YES;
    }
    else
    {
        header.backgroundColor = RGBCOLOR(224, 224, 224);
        itemNum.textColor = [UIColor orangeColor];
        downEdge.hidden = NO;
        downEdge2.hidden = NO;
    }

    return header;
}
- (void)showDetail:(id)sender
{
    UIButton * bten  = (UIButton *)sender;
    NSInteger section = bten.tag -10000;
    if ( [self.showDetailArray[section] integerValue]) {
        self.showDetailArray[section] = @"0";
        
        
    }
    else
    {
        self.showDetailArray[section] = @"1";
    }
    [self loadItemData:(section)];
    
}
- (void)loadItemData:(NSInteger)section
{
 
//    for (int i = 0; i < 5; i++) {
//        JRGiftRecord * record = [[JRGiftRecord alloc]init];
//        record.giftName = [NSString stringWithFormat:@"金条%d",i];
//        record.issueNo = [NSString stringWithFormat:@"久融%d",i];
//        record.issueTime = [NSString stringWithFormat:@"时间:%d",i];
//        record.investMoneyAccout = [NSString stringWithFormat:@"100%d",i];
//        record.luckUserName = [NSString stringWithFormat:@"sdfds%d",i];
//        [self.groupArray addObject:record];
//    }
    
    JRGiftRecord * record = self.m_dataArray[section];
    NSString * infoId = [NSString stringWithFormat:@"%@",record.ID];
    [JiuRongHttp JRGetDuobaoItemRecord:infoId success:^(NSInteger iStatus, NSString *error, NSMutableDictionary *info) {
        NSMutableArray * temArray = [NSMutableArray array];
        NSArray  * recordList = [info objectForKey:@"recordList"];
        if(recordList.count == 0)
        {
            [MyIndicatorView showIndicatiorViewWith:@"暂时无此期开奖记录" inView:self.view];
        }
        for (int i = 0; i < recordList.count; i++) {
            JRGiftRecord * record = [JRGiftRecord creatItemWith:recordList[i]];
            [temArray addObject:record];
        }
        self.groupArray[section] = [temArray copy];
        [self.JRPastRecordTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [self.JRPastRecordTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JRItemGiftRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRItemGiftRecordCellID" forIndexPath:indexPath];
    cell.groupItemArray = self.groupArray[indexPath.section];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.showDetailArray[indexPath.section] integerValue]) {
        return 30*[self.groupArray[indexPath.section] count]+20;
    }
    else
    {
    return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{    JRGiftRecord * record = self.m_dataArray[section];
    CGRect rect;
    rect.size.height = [record.title boundingRectWithSize:CGSizeMake((KScreenW-20)/3.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName,nil] context:nil].size.height;
    return rect.size.height+20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.m_dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.showDetailArray[section] integerValue]) {
        return 1;
    }
    else
    {
        return 0;
    }
}
- (UIView *)tableHeader
{
    if (!_tableHeader) {
        _tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 20, KScreenW, 25)];
        UILabel * edge = [[UILabel alloc]initWithFrame:CGRectMake(0, 25-0.5, KScreenW, 0.5)];
        edge.backgroundColor = [UIColor lightGrayColor];
        [_tableHeader addSubview:edge];
//        UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 20)];
//        [_tableHeader addSubview:sectionTitle];
//        sectionTitle.font = [UIFont systemFontOfSize:14];
//        sectionTitle.text = @"往期开奖记录";
        NSArray * itemTitle = @[@"开奖期数",@"开奖时间",@"开奖记录"];
        float width = (KScreenW-20)/3.0;
        for (int i = 0; i < 3; i++) {
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10+width*i, 5, width, 20)];
            label.text = itemTitle[i];
            i == 0 ? [label setTextAlignment:NSTextAlignmentLeft]:[label setTextAlignment:NSTextAlignmentCenter];
            label.font = [UIFont boldSystemFontOfSize:14];
            label.textColor = [UIColor blackColor];
            [_tableHeader addSubview:label];
        }
    }
    return _tableHeader;
}
- (UITableView *)JRPastRecordTableView
{
    if (!_JRPastRecordTableView) {
        _JRPastRecordTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-64) style:UITableViewStyleGrouped];
        _JRPastRecordTableView.delegate = self;
        _JRPastRecordTableView.dataSource = self;
        _JRPastRecordTableView.tableHeaderView = self.tableHeader;
        _JRPastRecordTableView.backgroundColor = [UIColor whiteColor];
        _JRPastRecordTableView.showsVerticalScrollIndicator = NO;
        _JRPastRecordTableView.separatorInset = UIEdgeInsetsZero;
        [_JRPastRecordTableView registerClass:[JRItemGiftRecordCell class] forCellReuseIdentifier:@"JRItemGiftRecordCellID"];
    }
    return _JRPastRecordTableView;
}
- (NSMutableArray *)m_timeArray
{
    if (!_m_timeArray) {
        _m_timeArray = [NSMutableArray array];
    }
    return _m_timeArray;
}
- (NSMutableArray *)m_dataArray
{
    if (!_m_dataArray) {
        _m_dataArray = [NSMutableArray array];
    }
    return _m_dataArray;
}
- (NSMutableArray *)groupArray
{
    if (!_groupArray)
    {
        _groupArray = [NSMutableArray array];
        for (int i = 0; i < self.m_dataArray.count; i++) {
            NSMutableArray * array = [NSMutableArray array];
            [_groupArray addObject:array];
        }
    }
    return _groupArray;
}
                                                    
- (NSMutableArray *)showDetailArray
{
    if (!_showDetailArray) {
        _showDetailArray = [NSMutableArray array];
        for (int i = 0; i < self.m_dataArray.count; i++) {
            [_showDetailArray addObject:@"0"];
        }
    }
    return _showDetailArray;
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
