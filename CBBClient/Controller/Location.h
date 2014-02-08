//
//  Location.h
//  CBBClient
//
//  Created by 卡宝宝 on 13-12-30.
//  Copyright (c) 2013年 EasyCard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface Location : NSObject
@property(nonatomic,retain) CLLocationManager *locManager;
-(void)getLocation;
@end
