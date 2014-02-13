//
//  RegCardViewController.h
//  CBBClient
//
//  Created by 卡宝宝 on 13-9-18.
//  Copyright (c) 2013年 EasyCard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"

@interface RegCardViewController : UITableViewController<UITextFieldDelegate,CustomPickerDelegate>
@property(nonatomic,retain)IBOutlet UITextField *cityTF;
@property(nonatomic,retain)IBOutlet UITextField *bankTF;
@property(nonatomic,retain)IBOutlet UITextField *cardTF;
@property(nonatomic,retain)IBOutlet UITextField *emailTF;
@property(nonatomic,retain)IBOutlet UITextField *nameTF;
@property(nonatomic,retain)IBOutlet UITextField *birthTF;
@property(nonatomic,retain)IBOutlet UITextField *gradeTF;
@property(nonatomic,retain)IBOutlet UITextField *wNameTF;
@property(nonatomic,retain)IBOutlet UITextField *wAreaTF;
@property(nonatomic,retain)IBOutlet UITextField *wAddrTF;
@property(nonatomic,retain)IBOutlet UITextField *wPropTF;
@property(nonatomic,retain)IBOutlet UITextField *wScalTF;
@property(nonatomic,retain)IBOutlet UITextField *jobTF;
@property(nonatomic,retain)IBOutlet UITextField *incomTF;
@property(nonatomic,retain)IBOutlet UITextField *hPropTF;
@property(nonatomic,retain)IBOutlet UITextField *mobilTF;
@property(nonatomic,retain)IBOutlet UITextField *areanTF;
@property(nonatomic,retain)IBOutlet UITextField *telTF;
@property(nonatomic,retain)IBOutlet UITextField *brancTF;
@property(nonatomic,retain)IBOutlet UITextField *timeTF;
@property(nonatomic,retain)IBOutlet UISegmentedControl *multiCardSC;
@property(nonatomic,retain)IBOutlet UISegmentedControl *sexSC;
@property(nonatomic,retain)IBOutlet UISegmentedControl *nativeSc;
@property(nonatomic,retain)IBOutlet UISegmentedControl *accSc;
@property(nonatomic,retain)IBOutlet UISegmentedControl *carSc;
@property(nonatomic,retain)IBOutlet UISegmentedControl *othCardSc;
@property(nonatomic,retain)IBOutlet UISegmentedControl *insuSc;
@property(nonatomic,retain)IBOutlet UISegmentedControl *informSc;
@end
