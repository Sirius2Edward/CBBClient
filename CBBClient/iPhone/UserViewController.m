//
//  UserViewController.m
//  CBBClient
//
//  Created by 卡宝宝 on 14-2-8.
//  Copyright (c) 2014年 EasyCard. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segue代理，Push时执行
    //Push到的页面隐藏Tabbar，Pop回来时显示
    UIViewController *controller = segue.destinationViewController;
    controller.hidesBottomBarWhenPushed = YES;
}
@end
