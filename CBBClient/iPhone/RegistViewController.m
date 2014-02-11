//
//  RegistViewController.m
//  CBBClient
//
//  Created by 卡宝宝 on 14-1-9.
//  Copyright (c) 2014年 EasyCard. All rights reserved.
//

#import "RegistViewController.h"
#import "NSString+Validate.h"
#import "Request_API.h"
@interface RegistViewController ()
{
    Request_API *req;
}
@end

@implementation RegistViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    req = [Request_API shareInstance];
    req.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.emailmobileTX becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.emailmobileTX) {
        [self.usernameTX becomeFirstResponder];
    }
    else if (textField == self.usernameTX) {
        [self.passwordTX becomeFirstResponder];
    }
    else if (textField == self.passwordTX) {
        [self.confirmpwTX becomeFirstResponder];
    }
    else if (textField == self.confirmpwTX) {
        [self regist];
        [textField resignFirstResponder];
    }
    return YES;
}

-(IBAction)segChange:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.emailmobileTX.placeholder = @"手机号";
            break;
        case 1:
            self.emailmobileTX.placeholder = @"Email地址";
            break;
        default:
            break;
    }
}

-(void)regist
{
    switch (self.segment.selectedSegmentIndex) {
        case 0:
            if (![self.emailmobileTX.text isMobileNumber]) {
                return;
            }
            break;
        case 1:
            if (![self.emailmobileTX.text isEmailAddress]) {
                return;
            }
            break;
        default:
            break;
    }
    if (self.passwordTX.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"密码不能少于6位！"];
    }
    [req registMember:self.segment.selectedSegmentIndex+1
              account:self.emailmobileTX.text
             username:self.usernameTX.text
             password:self.passwordTX.text
             confirm:self.confirmpwTX.text ];
}

-(void)regEnd:(id)dic
{
    NSLog(@"%@",dic);
    if (dic) {

    }
}
@end
