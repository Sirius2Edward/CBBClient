//
//  UserEditViewController.m
//  CBBClient
//
//  Created by 卡宝宝 on 14-1-21.
//  Copyright (c) 2014年 EasyCard. All rights reserved.
//

#import "UserEditViewController.h"

@interface UserEditViewController ()

@end

@implementation UserEditViewController

- (void)loadView
{
    [super loadView];
    self.sex.segmentedControlStyle = UISegmentedControlStyleBar;
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    
    UIBarButtonItem *prev = [[UIBarButtonItem alloc] initWithTitle:@"上一项" style:UIBarButtonItemStyleDone target:self action:@selector(confirmPicker)];
    prev.enabled = NO;
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"下一项" style:UIBarButtonItemStyleDone target:self action:@selector(confirmPicker)];
    UIBarButtonItem *confirmBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirmPicker)];
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [items addObject:prev];
    [items addObject:next];
    [items addObject:flexibleSpaceItem];
    [items addObject:confirmBtn];
    UIToolbar *toobar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, -44, 320, 44)];
    toobar.items = items;
    self.birth.inputAccessoryView = toobar;
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, 320, 260)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    self.birth.inputView = datePicker;

}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)selectWork:(UIButton *)sender
{
    
}

-(IBAction)selectAddr:(UIButton *)sender
{
    
}

-(void)confirmPicker
{
    [self.view endEditing:YES];
}

-(void)dateChanged:(UIDatePicker *)sender
{
    self.birth.text = [NSString stringWithFormat:@"%@", sender.date];
}

//-(void)showDataPicker
//{
//    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, 320, 260)];
//    datePicker.datePickerMode = UIDatePickerModeDate;
//        
//    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
//    UIBarButtonItem *confirmBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirmPicker)];
//    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    [items addObject:flexibleSpaceItem];
//    [items addObject:confirmBtn];
//    UIToolbar *toobar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, -44, 320, 44)];
//    toobar.items = items;
//    
//    [datePicker addSubview:toobar];
//    
//    [self.view addSubview:datePicker];
//    [UIView animateWithDuration:0.3 animations:^{
//        datePicker.frame = CGRectMake(0, SCREEN_HEIGHT-260, 320, 260);
//    } completion:^(BOOL finished) {
//        
//    }];
//}

-(void)cancelDataPicker
{
    
}
@end
