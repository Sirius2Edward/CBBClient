//
//  FindPwdViewController.m
//  CBBClient
//
//  Created by 卡宝宝 on 14-1-13.
//  Copyright (c) 2014年 EasyCard. All rights reserved.
//

#import "FindPwdViewController.h"
#import "Request_API.h"

@interface FindPwdViewController ()
{
    Request_API *req;
}
@end

@implementation FindPwdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    req = [Request_API shareInstance];
    req.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyNext) {
        [self.checkCodeTX becomeFirstResponder];
    }
    else if (textField.returnKeyType == UIReturnKeyDone) {
        [self findPassword];
    }
    return YES;
}

-(IBAction)segChange:(UISegmentedControl *)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.3f];    
    if (sender.selectedSegmentIndex) {
        self.checkCodeBTN.alpha = 0;
        self.checkCodeTX.alpha = 0;
        self.emailmobileTX.placeholder = @"输入Email地址";
        self.emailmobileTX.returnKeyType = UIReturnKeyDone;
    }
    else {
        self.checkCodeBTN.alpha = 1;
        self.checkCodeTX.alpha = 1;
        self.emailmobileTX.placeholder = @"输入手机号码";
        self.emailmobileTX.returnKeyType = UIReturnKeyNext;
    }
    [UIView commitAnimations];
}

-(IBAction)sendCheckCode:(UIButton *)sender
{
    if (self.emailmobileTX.text != nil && [self.emailmobileTX.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"先输入手机号码！"];
    }
    else {
        [self findPassword];
    }
}

-(void)findPassword
{
    [req findPwd:self.segment.selectedSegmentIndex+1 account:self.emailmobileTX.text];
}

-(void)findEnd:(id)dic
{
    
}
@end
