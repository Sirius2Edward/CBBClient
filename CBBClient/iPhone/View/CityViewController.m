//
//  CityViewController.m
//  CBBClient
//
//  Created by 卡宝宝 on 13-12-30.
//  Copyright (c) 2013年 EasyCard. All rights reserved.
//

#import "CityViewController.h"
#import "Location.h"
#import "Request_API.h"

@interface CityViewController ()
{
    Location *loc;
    CustomPicker *picker;
    Request_API *req;
    NSDictionary *prov;
    NSDictionary *city;
    NSArray *provArr;
    NSArray *cityArr;
}
@end

@implementation CityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!loc) {
        loc = [Location new];
        [loc.locManager startUpdatingLocation];
    }
    req = [Request_API shareInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)useGPS:(UISwitch *)sender
{
    if (sender.on) {
        if (picker) {
            [picker cancelPicker];
        }
        req.delegate = loc;
        if (!loc) {
            loc = [Location new];
        }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.3f];
        self.label.alpha = 0;
        self.citySelect.alpha = 0;
        [UIView commitAnimations];
        [loc.locManager startUpdatingLocation];
    }
    else {
        req.delegate = self;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.3f];
        self.label.alpha = 1;
        self.citySelect.alpha = 1;
        [UIView commitAnimations];
    }
}

-(IBAction)selectCity:(UIButton *)sender
{
    if (nil == prov && nil == city) {
        [req getProvinceList];
    }
    else {
        [self showPicker];
    }
}

-(void)showPicker
{
    if (picker) {
        [picker removeFromSuperview];
    }
    picker = [[CustomPicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-260, 320, 260)];
    picker.provArr = provArr;
    picker.cityArr = cityArr;
    picker.delegate = self;
    [picker showPickerInView:self.view];
}

-(void)confirmAction:(NSArray *)values WithInfo:(NSDictionary *)info
{

}

-(void)selectAction:(NSArray *)values
{
    NSMutableArray *mArr = [NSMutableArray array];
    for (NSString *str in values) {
        NSArray *arr = [str componentsSeparatedByString:@" "];
        [mArr addObject:[arr objectAtIndex:arr.count-1]];
    }
    [self.citySelect setTitle:[mArr componentsJoinedByString:@"  "] forState:0];
}

-(void)reloadCityData:(CustomPicker *)picker prov:(NSString *)key
{
    [req getCityList:[prov objectForKey:key]];
}

-(void)getProvEnd:(id)mDic
{
    NSDictionary *dic = [[mDic objectForKey:@"PARSEyhinfolistmobile3"] objectForKey:@"ProvList" ];
    prov = dic;
    NSArray *keyArray = [dic allKeys];
    provArr = [keyArray sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        if ([obj1 characterAtIndex:0] < [obj2 characterAtIndex:0]) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    if (nil == city) {
        [req getCityList:[prov objectForKey:[provArr objectAtIndex:0]]];
    }
}

-(void)getCityEnd:(id)mDic
{
    NSDictionary *dic = [[mDic objectForKey:@"PARSEyhinfolistmobile4"] objectForKey:@"CityList" ];
    city = dic;
    NSArray *keyArray = [dic allKeys];
    cityArr = [keyArray sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        if ([obj1 characterAtIndex:0] < [obj2 characterAtIndex:0]) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    if (!picker) {
        [self showPicker];
    }
    else {
        picker.cityDic = city;
        [picker reloadComponent:1];
    }
}
@end
