//
//  CustomPicker.h
//  CBB
//
//  Created by 卡宝宝 on 13-8-15.
//  Copyright (c) 2013年 卡宝宝. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomPicker;
@protocol CustomPickerDelegate <NSObject>
@required
-(void)confirmAction:(NSArray *)values WithInfo:(NSDictionary *)info;
-(void)selectAction:(NSArray *)values;
-(void)reloadCityData:(CustomPicker *)picker prov:(NSString *)key;
@end

@interface CustomPicker : UIView <UIPickerViewDelegate, UIPickerViewDataSource>
@property(nonatomic,assign)BOOL isShow;
@property(nonatomic,retain)NSDictionary *provDic;
@property(nonatomic,retain)NSDictionary *cityDic;
@property(nonatomic,retain)NSArray *provArr;
@property(nonatomic,retain)NSArray *cityArr;
@property(nonatomic,retain)NSMutableArray *selectItem;
@property(nonatomic,retain)NSDictionary *userInfo;
@property(nonatomic,assign)id<CustomPickerDelegate> delegate;
- (id)initWithFrame:(CGRect)frame withToolbar:(UIToolbar *)toolBar;
- (void)showPickerInView:(UIView *)view;
- (void)cancelPicker;
- (void)reloadComponent:(NSInteger)component;
@end
