//
//  LoginViewController.h
//  CBBClient
//
//  Created by 卡宝宝 on 13-12-30.
//  Copyright (c) 2013年 EasyCard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UIImageView *usernameBG;
@property(nonatomic,retain)IBOutlet UIImageView *passwordBG;
@property(nonatomic,retain)IBOutlet UITextField *usernameTX;
@property(nonatomic,retain)IBOutlet UITextField *passwordTX;
@property(nonatomic,retain)IBOutlet UIButton *loginBTN;
@property(nonatomic,retain)IBOutlet UIButton *regBTN;
@property(nonatomic,retain)IBOutlet UIButton *fpassBTN;
@end
