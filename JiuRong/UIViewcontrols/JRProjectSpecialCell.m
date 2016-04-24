//
//  JRProjectSpecialCell.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/14.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRProjectSpecialCell.h"
#import "BorrowInfo.h"
@implementation JRProjectSpecialCell

- (void)awakeFromNib {
    [super awakeFromNib];
    QSProgressAppearance * appearace =  [QSProgressAppearance sharedProgressAppearance];
    [appearace setSchemeColor:[UIColor orangeColor]];
    [appearace setType:LProgressTypeAnnular];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self = [[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell_Project" owner:self options:nil] lastObject];
    }
    return self;
}
- (void)UpdateInfo:(BorrowInfo *)info
{
    
    self.projectTitle.text = info.text;
    self.yearRate.text = [NSString stringWithFormat:@"%.2f%%",info.rate];
    if (info.limitunit == -1) {
        self.timeLimite.text = [NSString stringWithFormat:@"%ld[年]",info.limit];
    }
    else if (info.limitunit == 0)
    {
        self.timeLimite.text = [NSString stringWithFormat:@"%ld[月]",info.limit];
    }
    else
    {
         self.timeLimite.text = [NSString stringWithFormat:@"%ld[日]",info.limit];
    }
    if (info.progress - 100.00f >= 0.0f)
    {
        self.projectProgress.progress = 1;
//        self.manbiao.hidden = NO;
//        self.manbiao.image = [UIImage imageNamed:@"交易流水@2x"];
//        self.projectProgress.hidden = YES;
    }
    else
    {
        self.projectProgress.progress = info.progress/100;
//        self.manbiao.hidden = YES;
//        self.projectProgress.hidden = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
