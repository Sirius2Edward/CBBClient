//
//  PARSEuserlogin18.m
//  CBBClient
//
//  Created by 卡宝宝 on 14-2-8.
//  Copyright (c) 2014年 EasyCard. All rights reserved.
//

#import "PARSEuserlogin18.h"

@implementation PARSEuserlogin18
-(id)parser:(GDataXMLElement *)aElement {
    NSArray *itemsArr = [aElement nodesForXPath:@"//Worklists/WorksItem" error:nil];
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    for (GDataXMLElement *element in itemsArr) {
        NSString *wid = nil;
        NSString *wname = nil;
        for (GDataXMLNode *node in element.attributes) {
            if ([node.name isEqualToString:@"WorksID"]) {
                wid = node.stringValue;
            }
            else if ([node.name isEqualToString:@"WorksName"]) {
                wname = node.stringValue;
            }
        }
        [mDic setObject:wid forKey:wname];
    }
    [self.parseredDic setObject:mDic forKey:@"WorkList"];
    return self.parseredDic;
}
@end
