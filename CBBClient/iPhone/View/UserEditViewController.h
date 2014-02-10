//
//  UserEditViewController.h
//  CBBClient
//
//  Created by 卡宝宝 on 14-1-21.
//  Copyright (c) 2014年 EasyCard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"
@interface UserEditViewController : UIViewController<CustomPickerDelegate,UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic,retain)IBOutlet UILabel *account;
@property(nonatomic,retain)IBOutlet UILabel *username;
@property(nonatomic,retain)IBOutlet UISegmentedControl *sex;
@property(nonatomic,retain)IBOutlet UITextField *birth;
@property(nonatomic,retain)IBOutlet UITextField *work;
@property(nonatomic,retain)IBOutlet UITextField *address;
@property(nonatomic,retain)IBOutlet UITextView *present;
@end
