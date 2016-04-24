//
//  Constant.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/9.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#ifndef Constant_h
#define Constant_h
#define KTableArrow @"Index_card_icon_right-arrow@2x"
#define KApplyInfo @[@"请输入QQ号",@"请输入微信号",@"请输入学校",@"请输入院系",@"请输入专业",@"请输入班级",@"请输入学号",@"请输入辅导员姓名",@"请输入辅导员手机",@"请选择学历",@"请选择年级",@"请输入现住地址",@"请输入父亲姓名",@"请输入父亲手机",@"请输入父亲工作单位",@"请输入父亲现住地址",@"请输入母亲姓名",@"请输入母亲手机",@"请输入母亲工作单位",@"请输入母亲现住地址",@"请输入学信网用户名",@"请输入学信网密码",@"请输入手机服务密码"]
#define KpushTo(vc) [self.navigationController pushViewController:[[vc alloc]init] animated:YES];
#define KAllert(STR) [[[UIAlertView alloc]initWithTitle:@"久融金融" message:STR delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
#define KPopRoot [self.navigationController popToRootViewControllerAnimated:YES];
#define KPerformSegue(ID) [self performSegueWithIdentifier:ID sender:self];
#define KPopLastView [self.navigationController popViewControllerAnimated:YES];
#define KStringEqual(str1,str2) [str1 isEqualToString:str2]
#define KGradeArray @[@"大一/研一/博一",@"大二/研二/博二",@"大三/研三/博三",@"大四/研四/博四",@"大五/研五/博五"];
#define KAcademicArray @[@"小学",@"初中",@"高中",@"专科",@"本科",@"硕士",@"博士"];
#define  NullStringSet(param) (param ==nil || [param isKindOfClass:[NSNull class]] || param == [NSNull null])?@"":param
#define KloanTypeImage @[@"logo_student",@"logo_urgent",@"logo_pioneer",@"logo_boys",@"logo_girls"]
#define KStoryBoardVC(STR) [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:STR]
#define KString(STR) [NSString stringWithFormat:@"%@",STR]
#define KShareUMArray @[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ,UMShareToQzone,UMShareToSms,UMShareToRenren]//,UMShareToFacebook,UMShareToTwitter,
#define KGlobalColor RGBCOLOR(27, 138, 238)
#define min(a,b) (a>b?b:a)
#endif /* Constant_h */
