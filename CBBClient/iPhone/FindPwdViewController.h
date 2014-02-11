//
//  FindPwdViewController.h
//  CBBClient
//
//  Created by 卡宝宝 on 14-1-13.
//  Copyright (c) 2014年 EasyCard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindPwdViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UISegmentedControl *segment;
@property(nonatomic,retain)IBOutlet UITextField *emailmobileTX;
@property(nonatomic,retain)IBOutlet UITextField *checkCodeTX;
@property(nonatomic,retain)IBOutlet UIButton *checkCodeBTN;
@end
