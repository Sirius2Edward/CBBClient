//
//  CityViewController.h
//  CBBClient
//
//  Created by 卡宝宝 on 13-12-30.
//  Copyright (c) 2013年 EasyCard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"
@interface CityViewController : UIViewController<CustomPickerDelegate>
@property(nonatomic,retain)IBOutlet UISwitch *atGPS;
@property(nonatomic,retain)IBOutlet UIButton *citySelect;
@property(nonatomic,retain)IBOutlet UILabel *label;
@end
