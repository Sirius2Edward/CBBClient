//
//  PARSEyhinfolistmobile4.m
//  CBBClient
//
//  Created by 卡宝宝 on 13-12-30.
//  Copyright (c) 2013年 EasyCard. All rights reserved.
//

#import "PARSEyhinfolistmobile4.h"

@implementation PARSEyhinfolistmobile4
-(id)parser:(GDataXMLElement *)aElement {
    NSArray *itemsArr = [aElement nodesForXPath:@"//ShiList/Item" error:nil];
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    for (GDataXMLElement *element in itemsArr) {
        NSString *pid = nil;
        NSString *pname = nil;
        for (GDataXMLNode *node in element.attributes) {
            if ([node.name isEqualToString:@"ID"]) {
                pid = node.stringValue;
            }
            else if ([node.name isEqualToString:@"title"]) {
                pname = node.stringValue;
            }
        }
        [mDic setObject:pid forKey:pname];
    }
    [self.parseredDic setObject:mDic forKey:@"CityList"];
    return self.parseredDic;
}
@end
