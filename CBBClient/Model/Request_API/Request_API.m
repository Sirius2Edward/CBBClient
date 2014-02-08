//
//  Request_API.m
//  CBB
//
//  Created by 卡宝宝 on 13-8-7.
//  Copyright (c) 2013年 卡宝宝. All rights reserved.
//

#import "Request_API.h"

@implementation Request_API
+(Request_API *)shareInstance
{
    static Request_API *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Request_API alloc] init];
    });
    return instance;
}

-(id)init
{
    if (self = [super init]) {
        req = [[HTTP_Request alloc] init];
    }
    return self;
}

-(void)setDelegate:(id)delegate
{
    req.delegate = delegate;
}

#pragma mark -
//会员登录
-(void)loginWithUser:(NSString *)username password:(NSString *)password
{
    req.connectEnd = @selector(loginEnd:);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         username,@"username",
                         [req passwordEncode:password],@"password", nil];
    [req httpRequestWithAPI:LOGIN TypeID:1 Dictionary:dic];
}

-(void)registMember:(NSInteger)type account:(NSString *)emailmobile username:(NSString *)username password:(NSString *)password confirm:(NSString *)passwords
{
    req.connectEnd = @selector(regEnd:);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSString stringWithFormat:@"%d",type],@"usertype",
                         emailmobile,@"emailmobile",
                         username,@"username",
                         password,@"password",
                         passwords,@"passwords",
                         nil];
    [req httpRequestWithAPI:LOGIN TypeID:17 Dictionary:dic];
}

-(void)findPwd:(NSInteger)type account:(NSString *)emailmobile
{
    req.connectEnd = @selector(findEnd:);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSString stringWithFormat:@"%d",type],@"typ",
                         emailmobile,@"useremail",
                         nil];
    [req httpRequestWithAPI:LOGIN TypeID:38 Dictionary:dic];
}

-(void)editUser:(NSInteger)sex birth:(NSString *)date work:(NSString *)work address:(NSString *)add press:(NSString *)pres
{
    NSDictionary *dic = [NSDictionary dictionary];
    
    
    [req httpRequestWithAPI:LOGIN TypeID:19 Dictionary:dic];
}

//获取省列表
-(void)getProvinceList
{
//    [SVProgressHUD showWithMaskType:4];
    req.connectEnd = @selector(getProvEnd:);
    [req httpRequestWithAPI:YHINFO TypeID:3 Dictionary:nil];
}

-(void)getCityList:(NSString *)cityid
{
    req.connectEnd = @selector(getCityEnd:);
    [req httpRequestWithAPI:YHINFO TypeID:4 Dictionary:[NSDictionary dictionaryWithObject:cityid forKey:@"sheng"]];
}
@end
