//
//  DownloadViewController.m
//  GeneralProject
//
//  Created by Chendi on 15/5/18.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import "DownloadViewController.h"
#import "Masonry.h"

@interface DownloadViewController ()

@property (nonatomic , strong) NSMutableArray *oneArray;
@property (nonatomic , strong) NSMutableArray *twoArray;
@property (nonatomic , strong) NSMutableArray *threeArray;

@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.oneArray = [[NSMutableArray alloc] init];
    self.twoArray = [[NSMutableArray alloc] init];
    self.threeArray = [[NSMutableArray alloc] init];
    
    self.tableViewGroup.dataSource = self;
    self.tableViewGroup.delegate = self;
}

- (void)headerButtonPressEvent:(UIButton *)headerButton
{
    NSLog(@"section:%zi",headerButton.tag);
    if (headerButton.tag == 0) {
        if (self.oneArray == nil) {
            self.oneArray = [[NSMutableArray alloc] init];
        } else {
            self.oneArray = nil;
        }
    } else if (headerButton.tag == 1) {
        if (self.twoArray == nil) {
            self.twoArray = [[NSMutableArray alloc] init];
        } else {
            self.twoArray = nil;
        }
    } else if (headerButton.tag == 2) {
        if (self.threeArray == nil) {
            self.threeArray = [[NSMutableArray alloc] init];
        } else {
            self.threeArray = nil;
        }
    }
    [self.tableViewGroup reloadData];
}
#pragma mark - 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [NSString stringWithFormat:@"section-%zi ----> row-%zi",[indexPath section],[indexPath row]];
    cell.textLabel.textColor = [UIColor grayColor];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 27.0)];
    
    UILabel *labelBg = [[UILabel alloc] initWithFrame:view.bounds];
    labelBg.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, view.bounds.size.width, view.bounds.size.height - 1.0)];
    label.text = [NSString stringWithFormat:@"      section-%zi",section];
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:15.0];
    label.textColor = [UIColor blackColor];
    [view addSubview:label];
    
    UIButton *button = [[UIButton alloc] initWithFrame:view.bounds];
    button.tag = section;
    [button addTarget:self action:@selector(headerButtonPressEvent:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, label.bounds.size.height, label.bounds.size.width, 1.0)];
    line.backgroundColor = [UIColor whiteColor];
    [view addSubview:line];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 27.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            if (self.oneArray == nil) {
                return 0;
            } else {
                return 10;
            }
            break;
        case 1:
            if (self.twoArray == nil) {
                return 0;
            } else {
                return 5;
            }
            break;
        case 2:
            if (self.threeArray == nil) {
                return 0;
            } else {
                return 8;
            }
            break;
        default:
            return 0;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
