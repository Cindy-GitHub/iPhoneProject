//
//  ThreeViewController.h
//  GeneralProject
//
//  Created by Chendi on 14/11/24.
//  Copyright (c) 2014年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UIButton *myButton;
@property (weak, nonatomic) IBOutlet UIButton *myButton2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sqgmentStatus;
@property (weak, nonatomic) IBOutlet UIView *viewAutoFrame;
@property (weak, nonatomic) IBOutlet UIView *viewAutoFrame2;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hTopConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vButtomConstraints;



@end
