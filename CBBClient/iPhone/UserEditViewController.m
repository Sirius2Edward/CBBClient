//
//  UserEditViewController.m
//  CBBClient
//
//  Created by 卡宝宝 on 14-1-21.
//  Copyright (c) 2014年 EasyCard. All rights reserved.
//

#import "UserEditViewController.h"
#import "Request_API.h"
#import "UIColor+TitleColor.h"

@interface UserEditViewController ()
{
    Request_API *req;
    NSDictionary *works;
    NSDictionary *prov;
    NSDictionary *city;
    NSArray *provArr;
    NSArray *cityArr;
    CustomPicker *picker;
    UIBarButtonItem *prev;
    UIBarButtonItem *next;
}
@end

@implementation UserEditViewController

-(void)viewDidAppear:(BOOL)animated
{
    req.delegate = self;
    self.scrollView.contentSize = self.scrollView.frame.size;
    
}

- (void)loadView
{
    [super loadView];
    [self setHidesBottomBarWhenPushed:NO];
    
    req = [Request_API shareInstance];
    
    self.birth.delegate = self;
    self.work.delegate = self;
    self.address.delegate = self;
    self.present.delegate = self;
    
    self.sex.segmentedControlStyle = UISegmentedControlStyleBar;
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:5];
    
    prev = [[UIBarButtonItem alloc] initWithTitle:@"上一项" style:UIBarButtonItemStyleDone target:self action:@selector(toPrev)];
    next = [[UIBarButtonItem alloc] initWithTitle:@"下一项" style:UIBarButtonItemStyleDone target:self action:@selector(toNext)];
    UIBarButtonItem *confirmBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirmAction:WithInfo:)];
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [items addObject:prev];
    [items addObject:next];
    [items addObject:flexibleSpaceItem];
    [items addObject:confirmBtn];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    toolbar.items = items;
    self.birth.inputAccessoryView = toolbar;
    self.work.inputAccessoryView = toolbar;
    self.address.inputAccessoryView = toolbar;
    self.present.inputAccessoryView = toolbar;
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, 320, 216)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    self.birth.inputView = datePicker;
    
    picker = [[CustomPicker alloc] initWithFrame:CGRectMake(0, 0, 320, 216) withToolbar:toolbar];
    picker.delegate = self;
    self.address.inputView = picker;
    self.work.inputView = picker;

    self.present.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.present.layer.borderWidth = 1.5;
    self.present.layer.cornerRadius = 6.0;
}

-(void)dateChanged:(UIDatePicker *)sender
{
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:sender.date];
    self.birth.text = [NSString stringWithFormat:@"%d年 %d月 %d日", component.year,component.month,component.day];
}

-(void)toPrev
{
    if ([self.work isFirstResponder]) {
        [self.birth becomeFirstResponder];
    }
    else if ([self.address isFirstResponder]) {
        [self.work becomeFirstResponder];
    }
    else if ([self.present isFirstResponder]) {
        [self.address becomeFirstResponder];
    }
}

-(void)toNext
{
    if ([self.birth isFirstResponder]) {
        [self.work becomeFirstResponder];
    }
    else if ([self.work isFirstResponder]) {
        [self.address becomeFirstResponder];
    }
    else if ([self.address isFirstResponder]) {
        [self.present becomeFirstResponder];
    }
}
#pragma mark - delegate
-(void)confirmAction:(NSArray *)values WithInfo:(NSDictionary *)info
{
    [self.view endEditing:YES];
}

-(void)selectAction:(NSArray *)values
{
    NSMutableArray *mArr = [NSMutableArray array];
    if ([self.work isFirstResponder]) {
        self.work.text = [values objectAtIndex:0];
    }
    else if([self.address isFirstResponder]) {
        for (NSString *str in values) {
            NSArray *arr = [str componentsSeparatedByString:@" "];
            [mArr addObject:[arr objectAtIndex:arr.count-1]];
        }
        self.address.text = [mArr componentsJoinedByString:@" - "];
    }
}

-(void)reloadCityData:(CustomPicker *)picker prov:(NSString *)key
{
    [req getCityList:[prov objectForKey:key]];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.birth) {
        prev.enabled = NO;
        next.enabled = YES;
    }
    else if (textField == self.work) {
        if (!works) {
            [req getWorkList];
            return NO;
        }
    }
    else if (textField == self.address) {
        if (nil == prov && nil == city) {
            [req getProvinceList];
            return NO;
        }
    }
    return YES;
}

-(void)setScrollRect
{
    CGSize size = self.scrollView.contentSize;
    if (size.height == SCREEN_HEIGHT - 64) {
        size.height += 218;
    }
    else {
        size.height -= 218;
    }
    [UIView animateWithDuration:0.2f animations:^{
        self.scrollView.contentSize = size;
    }];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.work) {
        prev.enabled = YES;
        next.enabled = YES;
        picker.provArr = [works allKeys];
        picker.cityArr = nil;
        [picker reloadComponent:0];
    }
    else if (textField == self.address) {
        prev.enabled = YES;
        next.enabled = YES;
        picker.provArr = provArr;
        picker.cityArr = cityArr;
        [picker reloadComponent:0];
    }
    
    [self setScrollRect];
    [self.scrollView setContentOffset:CGPointMake(0, textField.frame.origin.y-30) animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self setScrollRect];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.layer.borderColor = [UIColor titleColor].CGColor;
    prev.enabled = YES;
    next.enabled = NO;
    [self setScrollRect];
    NSLog(@"%@",NSStringFromCGPoint(textView.frame.origin));
    [self.scrollView setContentOffset:CGPointMake(0, textView.frame.origin.y-30) animated:YES];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self setScrollRect];
    
}
#pragma mark - request end
-(void)getWorkEnd:(id)mDic
{
    NSDictionary *dic = [[mDic objectForKey:@"PARSEuserlogin18"] objectForKey:@"WorkList" ];
    works = dic;
    picker.provArr = [dic allKeys];
    picker.cityArr = nil;
    [picker reloadComponent:0];
    [self.work becomeFirstResponder];
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
    picker.provArr = provArr;
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
    picker.cityDic = city;
    [self.address becomeFirstResponder];
    [picker reloadComponent:1];
}
@end
