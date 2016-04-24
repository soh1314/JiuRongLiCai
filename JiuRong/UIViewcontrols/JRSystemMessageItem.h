//
//  JRSystemMessageItem.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/2.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface JRSystemMessageItem :JSONModel
@property (nonatomic,copy)NSString * content;
@property (nonatomic,copy)NSString * entityId;
@property (nonatomic,copy)NSString * ID;
@property (nonatomic,copy)NSString * persistent;
@property (nonatomic,retain)NSDictionary * time;
@property (nonatomic,copy)NSString * read_status;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * user_id;
@property (nonatomic,copy)NSString * timeStr;


//content = "\U5c0a\U656c\U768415800000022: [2016-04-01 16:02:31] \U60a8\U6295\U8d44\U7684\U501f\U6b3e:tt_004,\U5df2\U653e\U6b3e,\U6210\U529f\U6263\U9664\U60a8\U7684\U6295\U8d44(\U51bb\U7ed3)\U91d1\U989d:\Uffe51000.0\U5143,\U589e\U52a0\U6295\U8d44\U5956\U52b1:\Uffe50.0\U5143";
//entityId = 38929;
//id = 38929;
//persistent = 1;
//"read_status" = "\U672a\U8bfb";
//time =                 {
//    date = 1;
//    day = 5;
//    hours = 16;
//    minutes = 4;
//    month = 3;
//    nanos = 0;
//    seconds = 26;
//    time = 1459497866000;
//    timezoneOffset = "-480";
//    year = 116;
//};
//title = "\U6295\U8d44\U6263\U8d39";
//"user_id" = 0;
@end
