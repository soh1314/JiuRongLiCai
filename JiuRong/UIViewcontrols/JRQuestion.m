//
//  JRQuestion.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/19.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRQuestion.h"

@interface JRQuestion ()
@property (nonatomic,retain)UISegmentedControl * segment;
@property (nonatomic,retain)UITableView * tableview;
@end

@implementation JRQuestion

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.segment;
    self.segment.tintColor = [UIColor whiteColor];
    self.segment.selectedSegmentIndex  = 0;
    self.segment.clipsToBounds = YES;
    self.segment.layer.cornerRadius = 5;
    // Do any additional setup after loading the view.
}
- (UISegmentedControl *)segment
{
    if (!_segment) {
        NSArray *arr = [[NSArray alloc]initWithObjects:@"常见问题",@"理财须知", nil];
        _segment = [[UISegmentedControl alloc]initWithItems:arr];
        _segment.tintColor = KGlobalColor;
    }
    return _segment;
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
