//
//  GroupCellTableViewCell.m
//  GeneralProject
//
//  Created by Chendi on 15/6/11.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import "GroupCellTableViewCell.h"

@implementation GroupCellTableViewCell

- (instancetype)initWithRestorationIdentifier:(NSString *)identifier
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    for(id oneObject in nib) {
        if([oneObject isKindOfClass:[self class]]) {
            self = oneObject;
            break;
        }
    }
    
    if (self == nil) {
        self = [super init];
    }
    
    [self setRestorationIdentifier:identifier];
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
