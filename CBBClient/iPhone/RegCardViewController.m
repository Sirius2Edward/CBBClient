
#import "RegCardViewController.h"
#import "Request_API.h"

@interface RegCardViewController ()
{
    NSInteger sec_mCard,sec_link;
    Request_API *req;
    CustomPicker *picker;
    UIBarButtonItem *prev;
    UIBarButtonItem *next;
    
    NSDictionary *works;
    NSDictionary *prov;
    NSDictionary *city;
    NSArray *provArr, *cityArr;
    NSArray *bankArr, *cardArr;
    NSArray *gradeArr,*incomeArr,*hproptArr,*timeArr;
    NSArray *areaArr,*wproptArr,*wscaleArr,*jobArr;
    
    NSMutableDictionary *selectedInfo;
}
@end

@implementation RegCardViewController

- (void)loadView
{
    [super loadView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:5];
    
    prev = [[UIBarButtonItem alloc] initWithTitle:@"上一项" style:UIBarButtonItemStyleDone target:self action:@selector(toPrev)];
    next = [[UIBarButtonItem alloc] initWithTitle:@"下一项" style:UIBarButtonItemStyleDone target:self action:@selector(toNext)];
    UIBarButtonItem *confirmBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirmAction:WithInfo:)];
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [items addObject:prev];
    [items addObject:next];
    [items addObject:flexibleSpaceItem];
    [items addObject:confirmBtn];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    toolbar.items = items;
    self.cityTF.inputAccessoryView = toolbar;
    self.bankTF.inputAccessoryView = toolbar;
    self.cardTF.inputAccessoryView = toolbar;
    self.emailTF.inputAccessoryView = toolbar;
    self.nameTF.inputAccessoryView =toolbar;
    self.birthTF.inputAccessoryView = toolbar;
    self.gradeTF.inputAccessoryView = toolbar;
    self.wNameTF.inputAccessoryView = toolbar;
    self.wAreaTF.inputAccessoryView = toolbar;
    self.wAddrTF.inputAccessoryView = toolbar;
    self.wPropTF.inputAccessoryView = toolbar;
    self.wScalTF.inputAccessoryView = toolbar;
    self.jobTF.inputAccessoryView = toolbar;
    self.incomTF.inputAccessoryView = toolbar;
    self.hPropTF.inputAccessoryView = toolbar;
    self.mobilTF.inputAccessoryView = toolbar;
    self.areanTF.inputAccessoryView = toolbar;
    self.telTF.inputAccessoryView = toolbar;
    self.brancTF.inputAccessoryView = toolbar;
    self.timeTF.inputAccessoryView = toolbar;
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, 320, 216)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    self.birthTF.inputView = datePicker;
    
    picker = [[CustomPicker alloc] initWithFrame:CGRectMake(0, 0, 320, 216) withToolbar:toolbar];
    picker.delegate = self;
    self.cityTF.inputView = picker;//prov&city
    self.bankTF.inputView = picker;//bank
    self.cardTF.inputView = picker;//card
    self.gradeTF.inputView = picker;
    self.wAreaTF.inputView = picker;//area
    self.wPropTF.inputView = picker;//wpropt
    self.wScalTF.inputView = picker;
    self.jobTF.inputView = picker;//job
    self.incomTF.inputView = picker;
    self.hPropTF.inputView = picker;
    self.timeTF.inputView = picker;
}

- (void)viewDidLoad
{
    sec_mCard = 1;
    sec_link = 21;
    [super viewDidLoad];
}

-(void)dateChanged:(UIDatePicker *)sender
{
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:sender.date];
    self.birthTF.text = [NSString stringWithFormat:@"%d年 %d月 %d日", component.year,component.month,component.day];
}

-(void)toPrev
{
//    if ([self.work isFirstResponder]) {
//        [self.birth becomeFirstResponder];
//    }
//    else if ([self.address isFirstResponder]) {
//        [self.work becomeFirstResponder];
//    }
//    else if ([self.present isFirstResponder]) {
//        [self.address becomeFirstResponder];
//    }
}

-(void)toNext
{
//    if ([self.birth isFirstResponder]) {
//        [self.work becomeFirstResponder];
//    }
//    else if ([self.work isFirstResponder]) {
//        [self.address becomeFirstResponder];
//    }
//    else if ([self.address isFirstResponder]) {
//        [self.present becomeFirstResponder];
//    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
        case 1:
            return sec_mCard;
        case 2:
            return 1;
        case 3:
            return sec_link;
        case 4:
            return 1;
        default:
            return 0;
    }
}

#pragma mark - Delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.cityTF) {
        if (!prov || !city) {
            return NO;
        }
    }
    else if (textField == self.bankTF) {
        if (!bankArr) {
            return NO;
        }
    }
    else if (textField == self.cardTF) {
        if (!cardArr) {
            return NO;
        }
    }
    else if (textField == self.wAreaTF) {
        if (!areaArr) {
            return NO;
        }
    }
    else if (textField == self.wPropTF) {
        if (!wproptArr) {
            return NO;
        }
    }
    else if (textField == self.jobTF) {
        if (!jobArr) {
            return NO;
        }
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

//CustomPicker Delegate Method
-(void)selectAction:(NSArray *)values
{
    
}

-(void)confirmAction:(NSArray *)values WithInfo:(NSDictionary *)info
{
    [self.view endEditing:YES];
//    NSLog(@"%@",info);
}

-(void)reloadCityData:(CustomPicker *)picker prov:(NSString *)key
{
    
}
#pragma mark - IBAction
-(IBAction)scValueChanged:(UISegmentedControl *)sender
{
    
}

-(IBAction)submit:(id)sender
{
    sec_link = 0;
    [self.tableView reloadData];
}
@end
