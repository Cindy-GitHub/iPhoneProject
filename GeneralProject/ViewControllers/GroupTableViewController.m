//
//  GroupTableViewController.m
//  GeneralProject
//
//  Created by Chendi on 15/6/11.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import "GroupTableViewController.h"
#import "GroupCellTableViewCell.h"

#import "DBUser.h"

@interface GroupTableViewController ()
{
    NSMutableArray *dateArray;
}
@end

@implementation GroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.groupTable.dataSource = self;
    self.groupTable.delegate = self;
    
    
//    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(120, 30, 60, 50)];
//    view2.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view2];
//    
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view2.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = view2.bounds;
//    maskLayer.path = maskPath.CGPath;
//    view2.layer.mask = maskLayer;
    
    
//    DBUser *user = [[DBUser alloc] init];
//    user.name = @"张三";
//    user.sex = @"女";
//    user.age = 25;
//    [user insertToDb];
//
//    DBUser *user2 = [[DBUser alloc] init];
//    user2.name = @"张二";
//    user2.sex = @"女";
//    user2.age = 25;
//    [user2 insertToDb];
    
    
    
    NSString  *appPath = [NSString stringWithFormat:@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
    NSLog(@"app path : %@",appPath);
    
//    NSArray *users = [DBUser dbObjectsWhere:@"name = \"张三\"" orderby:nil];
//    for (DBUser *user in users) {
//        [user removeFromDb];
//    }
    
    
    NSArray *allData = [DBUser allDbObjects];
    for (DBUser *user in allData) {
        NSLog(@"[user keyValues] : %@",[user valueForKey:@"name"]);
        NSLog(@"[user keyValues] : %@",[user valueForKey:@"sex"]);
        NSLog(@"[user keyValues] : %@",[user valueForKey:@"age"]);
        NSLog(@"[user keyValues] : %@",[user keyValues]);
    }

//    NSLog(@"[DBUser allDbObjects] : %@",[DBUser allDbObjects]);
//    NSArray *users = [DBUser dbObjectsWhere:@"__id__=1" orderby:nil];
//    for (DBUser *user in users) {
//        user.name = @"李四";
//        user.age = 19;
//        user.sex = @"男";
//        [user updatetoDb];
//    }
//    
//    NSArray *users2 = [DBUser dbObjectsWhere:@"__id__=2" orderby:nil];
//    for (DBUser *user in users2) {
//        user.name = @"王五";
//        user.age = 37;
//        [user updatetoDb];
//    }
    
    
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if (cell == nil) {
        cell = [[GroupCellTableViewCell alloc] initWithRestorationIdentifier:@"MyCell"];
    }
    cell.labelText.text = [NSString stringWithFormat:@"MyDate + %zi",[indexPath row]];
    cell.labelText.textAlignment = NSTextAlignmentCenter;
    cell.labelText.textColor = [UIColor grayColor];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    if ([indexPath row] != 0) {
//        cell.viewBg.layer.masksToBounds = NO;
//        cell.viewBg.layer.shadowColor = [UIColor grayColor].CGColor;
//        cell.viewBg.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
//        cell.viewBg.layer.shadowOpacity = 1.0f;
//        cell.viewBg.layer.shadowRadius = 1.0f;
//        cell.viewBg.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.viewBg.bounds].CGPath;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
