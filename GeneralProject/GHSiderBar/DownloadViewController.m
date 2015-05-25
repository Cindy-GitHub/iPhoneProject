//
//  DownloadViewController.m
//  GeneralProject
//
//  Created by Chendi on 15/5/18.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import "DownloadViewController.h"
#import "CDButtonView.h"

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

- (void)viewWillAppear:(BOOL)animated
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 200.0, 250.0, 60.0)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    CDButtonViewPressEventActionBlock actionBlock = ^(CDButtonView *view){
        NSLog(@"%zi",view.tag);
        switch (view.tag) {
            case 1:
            {
                view.normalImage = [UIImage imageNamed:@"main_label_device_normal"];
            }
                break;
            case 2:
            {
                
            }
                break;
            case 3:
            {
                
            }
                break;
            case 4:
            {
                
            }
                break;
                
            default:
                break;
        }
    };
    
    CDButtonView *buttonView1 = [[CDButtonView alloc] init];
    buttonView1.textLabel = @"download";
    buttonView1.normalImage = [UIImage imageNamed:@"main_label_device_normal"];
    buttonView1.highLightImage = [UIImage imageNamed:@"main_label_device"];
    buttonView1.labelNormalColor = [UIColor grayColor];
    buttonView1.lableHighLightColor = [UIColor greenColor];
    
    buttonView1.backgroundColor = [UIColor redColor];
    buttonView1.tag = 1;
    [buttonView1 addClickActionEvent:actionBlock];
    CDButtonView *buttonView2 = [[CDButtonView alloc] init];
    buttonView2.normalImage = [UIImage imageNamed:@"main_label_download_normal"];
    buttonView2.highLightImage = [UIImage imageNamed:@"main_label_download"];
    buttonView2.labelNormalColor = [UIColor grayColor];
    buttonView2.lableHighLightColor = [UIColor greenColor];
    buttonView2.textLabel = @"download";
    buttonView2.backgroundColor = [UIColor yellowColor];
    buttonView2.tag = 2;
    [buttonView2 addClickActionEvent:actionBlock];
    
    CDButtonView *buttonView3 = [[CDButtonView alloc] init];
    buttonView3.normalImage = [UIImage imageNamed:@"main_label_device_normal"];
    buttonView3.highLightImage = [UIImage imageNamed:@"main_label_device"];
    buttonView3.labelNormalColor = [UIColor grayColor];
    buttonView3.lableHighLightColor = [UIColor greenColor];
    buttonView3.backgroundColor = [UIColor redColor];
    buttonView3.tag = 3;
    [buttonView3 addClickActionEvent:actionBlock];
    
    CDButtonView *buttonView4 = [[CDButtonView alloc] init];
    buttonView4.normalImage = [UIImage imageNamed:@"main_label_download_normal"];
    buttonView4.highLightImage = [UIImage imageNamed:@"main_label_download"];
    buttonView4.labelNormalColor = [UIColor grayColor];
    buttonView4.lableHighLightColor = [UIColor greenColor];
    buttonView4.backgroundColor = [UIColor yellowColor];
    buttonView4.tag = 4;
    [buttonView4 addClickActionEvent:actionBlock];
    
    
    [view addSubview:buttonView1];
    [view addSubview:buttonView2];
    [view addSubview:buttonView3];
    [view addSubview:buttonView4];
    [buttonView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.top);
        make.left.equalTo(view.left);
        make.bottom.equalTo(view.bottom);
        make.width.equalTo(buttonView4.width);
        make.right.equalTo(buttonView4.left).offset(0);
    }];
    
//    [buttonView2 makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(view.top);
//        make.right.equalTo(buttonView3.left).offset(0);
//        make.bottom.equalTo(view.bottom);
//        make.width.equalTo(buttonView3.width);
//    }];
//    
//    [buttonView3 makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(view.top);
//        make.right.equalTo(buttonView4.left).offset(0);
//        make.bottom.equalTo(view.bottom);
//        make.width.equalTo(buttonView4.width);
//    }];
    
    [buttonView4 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.top);
        make.right.equalTo(view.right);
        make.bottom.equalTo(view.bottom);
    }];
    
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
