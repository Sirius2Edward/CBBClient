//
//  PARSEuserlogin1.m
//  CBBClient
//
//  Created by 卡宝宝 on 14-1-2.
//  Copyright (c) 2014年 EasyCard. All rights reserved.
//

#import "PARSEuserlogin1.h"
@implementation PARSEuserlogin1
-(id)parser:(GDataXMLElement *)aElement
{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    for (GDataXMLElement *e in aElement.children) {
        [mDic setObject:e.stringValue forKey:e.name];
    }
    [self.parseredDic setValue:mDic forKey:@"info"];
    return self.parseredDic;
}
@end
