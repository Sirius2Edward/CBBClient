//
//  Request_API.h
//  CBB
//
//  Created by 卡宝宝 on 13-8-7.
//  Copyright (c) 2013年 卡宝宝. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTP_Request.h"

#define YHINFO @"yhinfolistmobile"
#define LOGIN @"userlogin"


@interface Request_API : NSObject
{
    HTTP_Request *req;
}
@property(nonatomic,assign)id delegate;
+(Request_API *)shareInstance;                              //请求接口单例

//会员登录
-(void)loginWithUser:(NSString *)username password:(NSString *)password;
-(void)registMember:(NSInteger)type account:(NSString *)emailmobile username:(NSString *)username password:(NSString *)password confirm:(NSString *)passwords;
-(void)findPwd:(NSInteger)type account:(NSString *)emailmobile;
-(void)editUser:(NSInteger)sex birth:(NSString *)date work:(NSString *)work address:(NSString *)add press:(NSString *)pres;
//银行信息列表
-(void)getProvinceList;
-(void)getCityList:(NSString *)cityid;
@end
