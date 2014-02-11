
#import "RegCardViewController.h"
#import "TextCell.h"

@interface RegCardViewController ()
{
    NSArray *titles;
}
@end

@implementation RegCardViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        titles = [NSArray arrayWithObjects:
                           @"工作单位城市：", @"选择银行：", @"选择信用卡：",
                           @"是否有本行信用卡：", @"您的电子邮箱：", @"中文姓名：",
                           @"性别：", @"出生年月：", @"文化程度：",  @"户口性质：",
                           @"是否有本行储蓄账户：", @"工作单位名称："@"工作单位地址：",
                           @"单位性质：", @"单位人数：", @"您的职务：", @"个人月收入",
                           @"住宅性质：", @"本人名下私家车：", @"是否有他行信用卡：",
                           @"是否有社保：", @"您的手机号码：", @"您的办公电话",
                           @"方便联系的时间",@"受理时希望通知您的方式：", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [titles objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] init];
    }
    return cell;
}
@end
