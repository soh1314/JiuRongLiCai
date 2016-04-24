//
//  JRItemGiftRecordCell.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/28.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRItemGiftRecordCell.h"

@implementation JRItemGiftRecordCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self updateUI];
    }
    return self;
}
- (void)setGroupItemArray:(NSMutableArray *)groupItemArray
{
    _groupItemArray = [groupItemArray copy];
    if ([_groupItemArray count]) {
        CGRect rect = self.tableView.frame;
        rect.size.height = [_groupItemArray count]*30+30;
        rect.size.width = KScreenW;
        self.tableView.frame = rect;
    }
    [self.tableView reloadData];
}
- (void)updateUI
{
    [self addSubview:self.tableView];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.tableHeaderView = self.tableHeader;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"JRDetailItemCell" bundle:nil] forCellReuseIdentifier:@"JRDetalItemCellID"];
    }
    return _tableView;
}
- (UIView *)tableHeader
{
    if (!_tableHeader) {
        _tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 20)];
        float labelWidth = (KScreenW-20)/3.0;
        UILabel * userName = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, labelWidth,15)];
        userName.text = @"用户名";
        userName.font = [UIFont boldSystemFontOfSize:12];
        [_tableHeader addSubview:userName];
        
        UILabel * luckyCode = [[UILabel alloc]initWithFrame:CGRectMake(10+labelWidth, 5, labelWidth, 15)];
        luckyCode.text = @"幸运编码";
        luckyCode.font = [UIFont boldSystemFontOfSize:12];
        luckyCode.textAlignment = NSTextAlignmentCenter;
        [_tableHeader addSubview:luckyCode];
        
        UILabel * gift = [[UILabel alloc]initWithFrame:CGRectMake(10+2*labelWidth, 5, labelWidth, 15)];
        gift.text = @"礼物";
        gift.font = [UIFont boldSystemFontOfSize:12];
        gift.textAlignment = NSTextAlignmentCenter;
        [_tableHeader addSubview:gift];
    }
    return _tableHeader;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_groupItemArray) {
        return 0;
    }
    else
    {
    return self.groupItemArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JRDetailItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRDetalItemCellID" forIndexPath:indexPath];
    JRGiftRecord * record = self.groupItemArray[indexPath.row];
    cell.record = record;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
