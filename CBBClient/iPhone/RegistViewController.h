//
//  RegistViewController.h
//  CBBClient
//
//  Created by 卡宝宝 on 14-1-9.
//  Copyright (c) 2014年 EasyCard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UISegmentedControl *segment;
@property(nonatomic,retain)IBOutlet UITextField *emailmobileTX;
@property(nonatomic,retain)IBOutlet UITextField *usernameTX;
@property(nonatomic,retain)IBOutlet UITextField *passwordTX;
@property(nonatomic,retain)IBOutlet UITextField *confirmpwTX;
@end
