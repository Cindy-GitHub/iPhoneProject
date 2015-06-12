//
//  GroupCellTableViewCell.h
//  GeneralProject
//
//  Created by Chendi on 15/6/11.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewBg;
@property (weak, nonatomic) IBOutlet UILabel *labelText;

- (instancetype)initWithRestorationIdentifier:(NSString *)identifier;

@end
