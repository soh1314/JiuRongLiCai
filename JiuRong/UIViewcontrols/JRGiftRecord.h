//
//  JRGiftRecord.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/21.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JSONModel.h"

@interface JRGiftRecord : JSONModel
//@property (nonatomic,copy)NSString * issueNo;
//@property (nonatomic,copy)NSString * issueTime;
//@property (nonatomic,copy)NSString * giftName;
//@property (nonatomic,copy)NSString * code;
//@property (nonatomic,copy)NSString * luckUserName;
//@property (nonatomic,copy)NSString * investMoneyAccout;

@property (nonatomic,assign)long bid_id;
@property (nonatomic,assign)long code_num;
@property (nonatomic,assign)long entityId;
@property (nonatomic,copy)NSString *  ID;

@property (nonatomic,assign)long  info_id;
@property (nonatomic,assign)double invest_amount;
@property (nonatomic,assign)long invest_id;
@property (nonatomic,copy)NSString * persistent;

@property (nonatomic,retain)NSDictionary * time;
@property (nonatomic,copy)NSString * timeStr;
@property (nonatomic,copy)NSString * treasure;
@property (nonatomic,assign)long user_id;
@property (nonatomic,copy)NSString * user_name;

@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * strTime;
+ (JRGiftRecord *)creatItemWith:(NSDictionary *)dic;
//"bid_id" = 11348;
//"code_num" = 7;
//entityId = 16;
//id = 16;
//"info_id" = 9;
//"invest_amount" = 900;
//"invest_id" = 3293;
//persistent = 1;
//time =             {
//    date = 25;
//    day = 5;
//    hours = 17;
//    minutes = 25;
//    month = 2;
//    nanos = 0;
//    seconds = 3;
//    time = 1458897903000;
//    timezoneOffset = "-480";
//    year = 116;
//};
//timeStr = "2016-03-25";
//treasure = "\U4e07\U5143\U73b0\U91d1\U7ea2\U5305";
//"user_id" = 12737;
//"user_name" = 18500000022;

@end
