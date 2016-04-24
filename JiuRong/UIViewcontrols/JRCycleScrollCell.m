//
//  JRCycleScrollCell.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/20.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRCycleScrollCell.h"

@implementation JRCycleScrollCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI
{
    self.scrollview = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds imageNamesGroup:self.imageArray];
    [self addSubview:self.scrollview];
}
- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    self.scrollview.localizationImageNamesGroup = imageArray;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
