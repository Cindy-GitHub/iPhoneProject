//
//  DownloadViewController.m
//  GeneralProject
//
//  Created by Chendi on 15/5/18.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import "DownloadViewController.h"
#import "CDButton.h"

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
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    CDButton *buttonView1 = [[CDButton alloc] init];
    [buttonView1 setTitle:@"device" forState:CDButtonControlStateNormal];
    [buttonView1 setImage:[UIImage imageNamed:@"main_label_device_normal"] forState:CDButtonControlStateNormal];
    [buttonView1 setImage:[UIImage imageNamed:@"main_label_device"] forState:CDButtonControlStateHighlighted];
    [buttonView1 setTitleColor:[UIColor grayColor] forState:CDButtonControlStateNormal];
    [buttonView1 setTitleColor:[UIColor greenColor] forState:CDButtonControlStateHighlighted];
//    buttonView1.backgroundColor = [UIColor redColor];
    buttonView1.tag = 1;
    [buttonView1 addBlockCodeActionEvent:^(CDButton *view) {
        
    }];
    [buttonView1 addTarget:self andAction:@selector(testCDButtonMessageSend:)];
    
    CDButton *buttonView2 = [[CDButton alloc] init];
    [buttonView2 setTitle:@"download" forState:CDButtonControlStateNormal];
    [buttonView2 setImage:[UIImage imageNamed:@"main_label_download_normal"] forState:CDButtonControlStateNormal];
    [buttonView2 setImage:[UIImage imageNamed:@"main_label_download"] forState:CDButtonControlStateHighlighted];
    [buttonView2 setTitleColor:[UIColor grayColor] forState:CDButtonControlStateNormal];
    [buttonView2 setTitleColor:[UIColor greenColor] forState:CDButtonControlStateHighlighted];
//    buttonView2.backgroundColor = [UIColor yellowColor];
    buttonView2.tag = 2;
    [buttonView2 addTarget:self andAction:@selector(testCDButtonMessageSend:)];
    
    CDButton *buttonView3 = [[CDButton alloc] init];
    [buttonView3 setTitle:@"device" forState:CDButtonControlStateNormal];
    [buttonView3 setImage:[UIImage imageNamed:@"main_label_device_normal"] forState:CDButtonControlStateNormal];
    [buttonView3 setImage:[UIImage imageNamed:@"main_label_device"] forState:CDButtonControlStateHighlighted];
    [buttonView3 setTitleColor:[UIColor grayColor] forState:CDButtonControlStateNormal];
    [buttonView3 setTitleColor:[UIColor greenColor] forState:CDButtonControlStateHighlighted];
//    buttonView3.backgroundColor = [UIColor redColor];
    buttonView3.tag = 3;
    [buttonView3 addTarget:self andAction:@selector(testCDButtonMessageSend:)];
    
    CDButton *buttonView4 = [[CDButton alloc] init];
    [buttonView4 setTitle:@"download" forState:CDButtonControlStateNormal];
    [buttonView4 setImage:[UIImage imageNamed:@"main_label_download_normal"] forState:CDButtonControlStateNormal];
    [buttonView4 setImage:[UIImage imageNamed:@"main_label_download"] forState:CDButtonControlStateHighlighted];
    [buttonView4 setTitleColor:[UIColor grayColor] forState:CDButtonControlStateNormal];
    [buttonView4 setTitleColor:[UIColor greenColor] forState:CDButtonControlStateHighlighted];
//    buttonView4.backgroundColor = [UIColor yellowColor];
    buttonView4.tag = 4;
    [buttonView4 addTarget:self andAction:@selector(testCDButtonMessageSend:)];
    
    
    [view addSubview:buttonView1];
    [view addSubview:buttonView2];
    [view addSubview:buttonView3];
    [view addSubview:buttonView4];
    [buttonView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.top);
        make.left.equalTo(view.left);
        make.bottom.equalTo(view.bottom);
        make.width.equalTo(buttonView2.width);
        make.right.equalTo(buttonView2.left).offset(0);
    }];
    
    [buttonView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.top);
        make.right.equalTo(buttonView3.left).offset(0);
        make.bottom.equalTo(view.bottom);
        make.width.equalTo(buttonView3.width);
    }];

    [buttonView3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.top);
        make.right.equalTo(buttonView4.left).offset(0);
        make.bottom.equalTo(view.bottom);
        make.width.equalTo(buttonView4.width);
    }];
    
    [buttonView4 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.top);
        make.right.equalTo(view.right);
        make.bottom.equalTo(view.bottom);
    }];
    
}

- (void)testCDButtonMessageSend:(CDButton *)buttonView
{
    NSLog(@"buttonView.tag : %zi",buttonView.tag);
    NSLog(@"testCDButtonMessageSend : %@",buttonView);
    switch (buttonView.tag) {
        case 1:
        {
            
        }
            break;
        case 2:
        {
            [buttonView setImage:[UIImage imageNamed:@"main_label_device_normal"] forState:CDButtonControlStateNormal];
        }
            break;
        case 3:
        {
            [buttonView setImage:nil forState:CDButtonControlStateHighlighted];
        }
            break;
        case 4:
        {
            
        }
            break;
            
        default:
            break;
    }
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
