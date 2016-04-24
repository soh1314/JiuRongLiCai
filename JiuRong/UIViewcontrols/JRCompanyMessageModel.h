//
//  JRCompanyMessageModel.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/7.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface JRCompanyMessageModel :JSONModel
@property (nonatomic,copy)NSString * content;
@property (nonatomic,copy)NSString * entityId;
@property (nonatomic,copy)NSString * ID;
@property (nonatomic,copy)NSString * persistent;
@property (nonatomic,copy)NSString * time;
@property (nonatomic,copy)NSString * read_status;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * user_id;
@property (nonatomic,copy)NSString * timeStr;
//author = "";
//content = "";
//entityId = 1;
//id = 1;
//"image_filename" = "/images?uuid=347f54b3-9b67-484c-9d48-044e530a72fe";
//"image_filename2" = "";
//"image_filename3" = "";
//"is_university" = 0;
//"is_use" = 0;
//keywords = "";
//"location_app" = 0;
//"location_pc" = 0;
//opposition = 0;
//persistent = 0;
//"read_count" = 0;
//"show_type" = 0;
//"start_show_time" = "<null>";
//support = 0;
//time = "<null>";
//title = "\U6e56\U5357\U5546\U5b66\U9662\U6768\U5ce5\U5d58\U6559\U6388\U6765\U6211\U53f8\U6388\U724c\U4ea4\U6d41";
//"type_id" = 0;
@end
