//
//  HomeViewController.m
//  CBBClient
//
//  Created by 卡宝宝 on 14-2-12.
//  Copyright (c) 2014年 EasyCard. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *controller = segue.destinationViewController;
    controller.hidesBottomBarWhenPushed = YES;
}

@end
