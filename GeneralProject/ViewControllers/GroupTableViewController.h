//
//  GroupTableViewController.h
//  GeneralProject
//
//  Created by Chendi on 15/6/11.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupTableViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *supView;

@property (weak, nonatomic) IBOutlet UITableView *groupTable;

@end
