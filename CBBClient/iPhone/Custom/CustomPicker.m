//
//  CustomPicker.m
//  CBB
//
//  Created by 卡宝宝 on 13-8-15.
//  Copyright (c) 2013年 卡宝宝. All rights reserved.
//

#import "CustomPicker.h"

@implementation CustomPicker
{
    UIPickerView *picker;
    NSDictionary *_data;
}
@synthesize isShow;
@synthesize provDic;
@synthesize cityDic;
@synthesize provArr;
@synthesize cityArr;
@synthesize selectItem;
@synthesize userInfo;
@synthesize delegate;
-(id)initWithFrame:(CGRect)frame withToolbar:(UIToolbar *)toolBar
{
    if (self = [super initWithFrame:frame]) {
        self.isShow = NO;
        self.selectItem = [NSMutableArray array];
        
        CGRect rect;
        //创建工具栏
        if (toolBar==nil) {
            toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:2];
            UIBarButtonItem *confirmBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirmPicker)];
            UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            [items addObject:flexibleSpaceItem];
            [items addObject:confirmBtn];
            toolBar.hidden = NO;
            toolBar.items = items;
            toolBar.barStyle = UIBarStyleBlackTranslucent;
            [self addSubview:toolBar];
            rect = CGRectMake(0, 44, 320, 216);
        }
        else {
            rect = CGRectMake(0, 0, 320, 216);
        }
        
        picker = [[UIPickerView alloc] initWithFrame:rect];
        picker.delegate = self;
        picker.showsSelectionIndicator = YES;
        [self addSubview:picker];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cancelPicker)
                                                     name:@"RESIGN_PICKER"
                                                   object:nil];
    }
    return self;
}

-(void)setProvDic:(NSDictionary *)dic
{
    NSArray *keyArray = [dic allKeys];
    keyArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        if ([obj1 characterAtIndex:0] < [obj2 characterAtIndex:0]) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    self.provArr = keyArray;
}

-(void)setCityDic:(NSDictionary *)dic
{
    NSArray *keyArray = [dic allKeys];
    keyArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        if ([obj1 characterAtIndex:0] < [obj2 characterAtIndex:0]) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    self.cityArr = keyArray;
}

-(void)setProvArr:(NSArray *)provArray
{
    provArr = provArray;
    [self.selectItem removeAllObjects];
    [self.selectItem addObject:[provArr objectAtIndex:0]];
}

- (void)showPickerInView:(UIView *)view
{
    if (self.isShow) {
        return;
    }
    [view endEditing:YES];
    self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
    self.isShow = YES;
}

- (void)cancelPicker
{
    if (!self.isShow) {
        return;
    }
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
    self.isShow = NO;
}
- (void)confirmPicker
{
    [self cancelPicker];
    [self.delegate confirmAction:self.selectItem WithInfo:self.userInfo];
}

//总列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (nil==self.provArr && nil==self.cityArr) {
        return 0;
    }
    if (nil==self.provArr || nil==self.cityArr) {
        return 1;
    }
    return 2;
}

//显示数量
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return self.provArr.count;
        case 1:
            return self.cityArr.count;
        default:
            return 0;
    }
}

//显示内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *keyArray = nil;
    switch (component) {
        case 0:
            keyArray = self.provArr;
            break;
        case 1:
            keyArray = self.cityArr;
            break;
        default:
            return nil;
    }
    NSArray *arr = [[keyArray objectAtIndex:row] componentsSeparatedByString:@" "];
    return [arr objectAtIndex:arr.count-1];
}

//选择事件
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *key = nil;
    if (component == 0) {
        key = [self.provArr objectAtIndex:row];
        [self setSelectItems:key index:component];
        if (nil != self.cityArr) {
            [self.delegate reloadCityData:self prov:key];
        }
        else {
            [self.delegate selectAction:self.selectItem];
        }
    }
    else if (component == 1) {
        key = [self.cityArr objectAtIndex:row];
        [self setSelectItems:key index:component];
        [self.delegate selectAction:self.selectItem];
    }
}

-(void)setSelectItems:(NSString *)item index:(NSInteger)index
{
    if (self.selectItem.count == index) {
        [self.selectItem addObject:item];
    }
    else {
        [self.selectItem replaceObjectAtIndex:index withObject:item];
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"RESIGN_PICKER"
                                                  object:nil];
}

-(void)reloadComponent:(NSInteger)component
{
    [picker reloadAllComponents];
    if (component==1) {
        if (self.selectItem.count == component) {
            [self.selectItem addObject:[self.cityArr objectAtIndex:[picker selectedRowInComponent:1]]];
        }
        else {
            [self.selectItem replaceObjectAtIndex:1 withObject:[self.cityArr objectAtIndex:[picker selectedRowInComponent:1]]];
        }
        [self.delegate selectAction:self.selectItem];
    }
}
@end
