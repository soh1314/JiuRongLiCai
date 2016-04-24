//
//  QSRefreshView.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/19.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiRefreshControl.h"
@interface QSRefreshView : TiRefreshControl
@property (nonatomic, strong) UILabel *stateLab;
@property(nonatomic,strong) UIImageView *refreshImageView;
@property(nonatomic,strong) NSMutableArray *gifImages;


@property (nonatomic,strong)UIColor * QBackGroundColor;
@property (nonatomic,strong)UIImageView * companyImage;
@end
