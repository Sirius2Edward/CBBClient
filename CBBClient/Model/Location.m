//
//  Location.m
//  CBBClient
//
//  Created by 卡宝宝 on 13-12-30.
//  Copyright (c) 2013年 EasyCard. All rights reserved.
//

#import "Location.h"
#import "Request_API.h"

@implementation Location
{
    Request_API *req;
    NSString *prov;
    NSString *city;
}
-(id)init {
    if (self = [super init]) {
        req = [Request_API shareInstance];
        req.delegate = self;
        [self getLocation];
    }
    return self;
}
-(void)getLocation {
    if ([CLLocationManager locationServicesEnabled])
    {
        NSLog(@"device can location");
        self.locManager = [[CLLocationManager alloc] init];
        self.locManager.distanceFilter = 10;
        self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locManager.delegate = self;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: [locations lastObject]
                   completionHandler:^(NSArray *array, NSError *error) {
                       if (error != nil) {
                           NSLog(@"========================%@",error);
                       }
                       if (array.count > 0) {
                           CLPlacemark *placemark = [array objectAtIndex:0];
                           prov = placemark.administrativeArea;
                           city = placemark.locality;
                           [req getProvinceList];
                           [manager stopUpdatingLocation];
                       }
                   }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"========================%@",error);
}

-(void)getProvEnd:(id)mDic
{
    NSDictionary *dic = [[mDic objectForKey:@"PARSEyhinfolistmobile3"] objectForKey:@"ProvList" ];
    for (NSString *str in [dic allKeys]) {
        NSArray *arr = [str componentsSeparatedByString:@" "];
        NSString *key = nil;
        if (arr.count == 1) {
            key = [arr objectAtIndex:0];
        }
        else if (arr.count == 2) {
            key = [arr objectAtIndex:1];
        }
        
        if ([prov rangeOfString:key].location<prov.length) {
            ///////prov
            NSLog(@"%@-%@",prov,[dic objectForKey:str]);
            
            [req getCityList:[dic objectForKey:str]];
            
        }
    }
}

-(void)getCityEnd:(id)mDic
{
    NSDictionary *dic = [[mDic objectForKey:@"PARSEyhinfolistmobile4"] objectForKey:@"CityList" ];
    for (NSString *str in [dic allKeys]) {
        NSArray *arr = [str componentsSeparatedByString:@" "];
        NSString *key = nil;
        if (arr.count == 1) {
            key = [arr objectAtIndex:0];
        }
        else if (arr.count == 2) {
            key = [arr objectAtIndex:1];
        }
        
        if ([city rangeOfString:key].location<city.length) {
            //////city
            NSLog(@"%@-%@",city,[dic objectForKey:str]);
        }
    }
}
@end
