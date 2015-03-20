//
//  oneViewController.h
//  GeneralProject
//
//  Created by Cindy on 11/21/14.
//  Copyright (c) 2014 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface oneViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *MyTableView;
@property (weak, nonatomic) IBOutlet UIImageView *MyImageView;

@end
