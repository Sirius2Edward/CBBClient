//
//  LoginViewController.m
//  CBBClient
//
//  Created by 卡宝宝 on 13-12-30.
//  Copyright (c) 2013年 EasyCard. All rights reserved.
//

#import "LoginViewController.h"
#import "Request_API.h"
#import "Cache.h"
@interface LoginViewController ()
{
    Request_API *req;
}
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    req = [Request_API shareInstance];
}

-(void)viewWillAppear:(BOOL)animated
{
    req.delegate = self;
    [self.usernameTX becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.usernameTX) {
        self.usernameBG.highlighted = YES;
    }
    else if (textField == self.passwordTX) {
        self.passwordBG.highlighted = YES;
    }
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.usernameTX) {
        self.usernameBG.highlighted = NO;
    }
    else if (textField == self.passwordTX) {
        self.passwordBG.highlighted = NO;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //login
    if (textField == self.passwordTX) {
        [self login];
    }
    [textField resignFirstResponder];
    return YES;
}

-(void)login
{
    [req loginWithUser:self.usernameTX.text password:self.passwordTX.text];
}

-(void)loginEnd:(id)dic
{
    NSLog(@"%@",dic);
    if (dic) {
        [Cache saveUserList:self.usernameTX.text];
    }
}

-(IBAction)loginAction:(id)sender
{
    [self login];
}

@end
