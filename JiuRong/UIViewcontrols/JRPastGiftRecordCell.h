//
//  JRPastGiftRecordCell.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/21.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRGiftRecord.h"
@class JRPastGiftRecordCell;
typedef void(^RecordCellBlock)(JRPastGiftRecordCell * cell);
@interface JRPastGiftRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb_issueNo;
@property (weak, nonatomic) IBOutlet UILabel *lb_issueTime;
@property (weak, nonatomic) IBOutlet UIView *view_detail;
@property (weak, nonatomic) IBOutlet UILabel *lb_userName;
@property (weak, nonatomic) IBOutlet UILabel *lb_issueCode;
@property (weak, nonatomic) IBOutlet UILabel *lb_issueGiftName;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (nonatomic,copy) RecordCellBlock cellBlock;
@property (nonatomic,strong) JRGiftRecord * record;
@property (nonatomic,assign) CGRect rect;
@property (nonatomic,assign) BOOL hideDetail;
- (IBAction)recordDetail:(id)sender;
- (void)setRecord:(JRGiftRecord *)record;
@end
