//
//  Cache.m
//  CBBClient
//
//  Created by 卡宝宝 on 13-12-30.
//  Copyright (c) 2013年 EasyCard. All rights reserved.
//

#import "Cache.h"

@implementation Cache
+(id)loadCache:(NSString *)name
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"CardBB/%@",name]];
}

+(NSArray *)loadUserList
{
    return [self loadCache:@"USERLIST"];
}

+(void)saveUserList:(NSString *)username
{
    NSMutableArray *userList = [NSMutableArray arrayWithArray:[self loadCache:@"USERLIST"]];
    if ([userList containsObject:username] ) {
        return;
    }
    [userList addObject:username];
    [self saveCache:@"USERLIST" object:userList];
}

+(void)saveCache:(NSString *)name object:(id)obj
{
    if ( nil == obj )
		return;
	
	name = [NSString stringWithFormat:@"CardBB/%@",name];
	
	if ( obj )
	{
		[[NSUserDefaults standardUserDefaults] setObject:obj forKey:name];
        [[NSUserDefaults standardUserDefaults] synchronize];
	}
	else
	{
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:name];
        [[NSUserDefaults standardUserDefaults] synchronize];
	}
}
@end
