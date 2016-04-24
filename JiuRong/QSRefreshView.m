//
//  QSRefreshView.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/19.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "QSRefreshView.h"
#import <ImageIO/ImageIO.h>
@implementation QSRefreshView

- (void)setup
{
    if (self.QBackGroundColor) {
        self.backgroundColor = self.QBackGroundColor;
    }
    else
    {
//        self.backgroundColor = [UIColor redColor];
    }
//公司标题
//    _companyImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -20, self.bounds.size.width, 50)];
//    _companyImage.image = [UIImage imageNamed:@"AppIcon40x40"];
//    [self addSubview:_companyImage];
//状态文字
    _stateLab=[[UILabel alloc]init];
    [_stateLab setFont:[UIFont systemFontOfSize:10]];
    [_stateLab setTextColor:[UIColor colorWithRed:120/255.0f green:120/255.0f blue:120/255.0f alpha:1]];
    _stateLab.textAlignment=NSTextAlignmentCenter;
    _stateLab.text=DEFAULT_TITLE;
    _stateLab.frame=CGRectMake(0, self.bounds.size.height-20, SCREEN_WIDTH, 15);
    [self addSubview:_stateLab];
//旋转图标
    _refreshImageView=[[UIImageView alloc]init];
    _refreshImageView.frame=CGRectMake(self.bounds.size.width/2.0-20, CGRectGetMaxY(self.stateLab.frame)-55, 40, 40);
    [self addSubview:_refreshImageView];
//加载gif
    self.gifImages = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d@2x.png",i+1]];
        [self.gifImages addObject:image];
    }
    _refreshImageView.image = self.gifImages[0];
    _refreshImageView.animationImages = self.gifImages;
    _refreshImageView.animationDuration=0.95f;
    _refreshImageView.animationRepeatCount=INTMAX_MAX;
}
- (void)setRefreshState:(RefreshState)state {
    [super setRefreshState:state];
    
    switch (self.refreshState) {
        case State_normal:
            self.stateLab.text = DEFAULT_TITLE;
            if ([_refreshImageView isAnimating]) {
                [_refreshImageView stopAnimating];
            }
            int index=(-self.scrollView.contentOffset.y)/10;
            if (index<0) {
                index=0;
            }else if (index>self.gifImages.count-1){
                index=(int)self.gifImages.count-1;
            }
            _refreshImageView.image=self.gifImages[index];
            [self scrollViewContentInsets:self.superEdgeInsets];
            
            break;
        case State_trigger:
            self.stateLab.text = HOLDING_TITLE;
//            if (!_refreshImageView.isAnimating) {
//                [_refreshImageView startAnimating];
//            }
            break;
        case State_Loading:
            self.stateLab.text = LOADING_TITLE;
            [self scrollViewContentInsets:UIEdgeInsetsMake(TITLE_HEIGHT+self.scrollView.contentInset.top, 0, 0, 0)];
            if (!_refreshImageView.isAnimating) {
                [_refreshImageView startAnimating];
            }
            self.refreshedHandler();
            break;
        default:
            break;
    }
}
- (void)scrollViewContentInsets:(UIEdgeInsets)contentInset {
    [UIView animateWithDuration:.35 animations:^{
        [self.scrollView setContentInset:contentInset];
    }];
}
@end
