//
//  JRItemGiftRecordCell.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/28.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRDetailItemCell.h"
@interface JRItemGiftRecordCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain)UITableView * tableView;
@property (nonatomic,retain)UIView * tableHeader;
@property (nonatomic,retain)NSMutableArray * groupItemArray;
@end
