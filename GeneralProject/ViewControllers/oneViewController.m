//
//  oneViewController.m
//  GeneralProject
//
//  Created by Cindy on 11/21/14.
//  Copyright (c) 2014 Cindy. All rights reserved.
//

#import "oneViewController.h"
#import "MyHelper.h"

@interface oneViewController ()
{
    NSMutableArray *_dataTableViewArray;
    CellContentMode _contentMode;
    NSInteger  _lastInsetRow;
}

@end

@implementation oneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _MyImageView.hidden = YES;
    _contentMode = NormalMode;
    _dataTableViewArray = [[NSMutableArray alloc] init];
    NSInteger i;
    for (i = 0; i < 30; i++) {
        NSMutableDictionary  *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSString stringWithFormat:@"data + %zi",i]  forKey:@"title"];
        [_dataTableViewArray addObject:dict];
    }
    
    _MyTableView.dataSource = self;
    _MyTableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - My Method
-(UIButton *)getTheButtonWith:(NSString *)paramTitleLabel andTag:(NSInteger)paramTag andRect:(CGRect)paramRect
{
    UIButton *but = [[UIButton alloc] initWithFrame:paramRect];
    but.tag = paramTag;
    but.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [but setTitle:paramTitleLabel forState:UIControlStateNormal];
    but.backgroundColor = [UIColor greenColor];
    return but;
}

#pragma mark - IBAction
-(IBAction)addRow:(UIButton *)sender
{
    static NSInteger lastRow = -1; // 初始值
    NSLog(@"lastRow = %zi",lastRow);
    if (lastRow != -1) {
        [_dataTableViewArray removeObjectAtIndex:(lastRow+1)];
        [_MyTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:lastRow+1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    }
    
    if (lastRow != sender.tag) {
        [_dataTableViewArray insertObject:@"" atIndex:sender.tag+1];
        _contentMode  = MenuMode;
        lastRow = sender.tag;
        [_MyTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag+1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    } else {
        lastRow = -2;
    }
    NSLog(@"sender.tag = %zi",sender.tag);
}

#pragma mark - table view data  and  delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataTableViewArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identif1 = @"MyNormalCell";
    static NSString *identif2 = @"MyInsertCell";
    UITableViewCell *cell;
    switch (_contentMode) {
        case NormalMode:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:identif1];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identif1];
                CGRect rect = cell.frame;
                UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(rect.size.width - 50.0, (rect.size.height - 40.0)/2, 40.0, 40.0)];
                but.backgroundColor = [UIColor greenColor];
                but.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
                [but setTitle:@"下拉" forState:UIControlStateNormal];
                but.tag = indexPath.row;
                [but addTarget:self action:@selector(addRow:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:but];
            }
            cell.textLabel .text = [[_dataTableViewArray objectAtIndex:indexPath.row] objectForKey:@"title"];
            break;
        }
        case MenuMode:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:identif2];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identif2];
                CGRect cellRect = cell.frame;
                CGFloat interval = cellRect.size.width/4.0;
                CGFloat withInterval = (interval - ButtonWith)/2;
                NSArray *titleArray = [[NSArray alloc] initWithObjects:@"下载",@"删除",@"分享",@"更多", nil];
                int i ;
                CGRect rect;
                for (i = 0; i < 4; i++) {
                    rect  = CGRectMake((i * interval)+withInterval, (cellRect.size.height - ButtonHeight)/2, ButtonWith, ButtonHeight);
                    UIButton *but = [self getTheButtonWith:[titleArray objectAtIndex:i] andTag:indexPath.row andRect:rect];
                    [cell.contentView addSubview:but];
                }
            }
            break;
        }
        default:
            break;
    }
    return cell;
}

@end









