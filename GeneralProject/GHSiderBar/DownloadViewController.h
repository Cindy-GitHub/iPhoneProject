//
//  DownloadViewController.h
//  GeneralProject
//
//  Created by Chendi on 15/5/18.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHRevealViewController.h"

@interface DownloadViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewGroup;

@end
