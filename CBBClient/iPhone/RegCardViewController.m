
#import "RegCardViewController.h"

@interface RegCardViewController ()
{
    NSArray *titles;
    NSInteger multiCard,link;
}
@end

@implementation RegCardViewController

- (void)viewDidLoad
{
    multiCard = 1;
    link = 0;
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
        case 1:
            return multiCard;
        case 2:
            return 1;
        case 3:
            return link;
        case 4:
            return 1;
        default:
            return 0;
    }
}


-(IBAction)submit:(id)sender
{
    link = 21;
    [self.tableView reloadData];
}
@end
