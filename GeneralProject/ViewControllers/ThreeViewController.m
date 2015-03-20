//
//  ThreeViewController.m
//  GeneralProject
//
//  Created by Chendi on 14/11/24.
//  Copyright (c) 2014年 Cindy. All rights reserved.
//

#import "ThreeViewController.h"
#import "AppDelegate.h"

@interface ThreeViewController ()
{
    AppDelegate *_appDelegate;
}

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _myLabel.text = NSLocalizedStringFromTable(@"title", _appDelegate.currentLanguage, nil);
    
    NSString *button = NSLocalizedStringFromTable(@"button", _appDelegate.currentLanguage, nil);
    [_myButton setTitle:button forState:UIControlStateNormal];

    
    [self.viewAutoFrame setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.myLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.myButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.myButton2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
}


- (IBAction)buttonPress:(id)sender {
    
    CGRect rect =  self.viewAutoFrame.frame;
    
    if (rect.origin.y == 0) {
        self.hTopConstraints.constant = 64.0;
    } else {
        self.hTopConstraints.constant = 0;
    }
    
    [UIView animateWithDuration:1.0f animations:^{
        [self.viewAutoFrame layoutIfNeeded];
        [self.viewAutoFrame2 layoutIfNeeded];
    } completion:^(BOOL finished) {
        NSLog(@"completion the animation !");
    }];
}


- (IBAction)changeLabelPage:(UISegmentedControl *)sender {
    NSLog(@"selectedSegmentIndex  =  %zi",sender.selectedSegmentIndex);
    NSLog(@"%@",[sender titleForSegmentAtIndex:sender.selectedSegmentIndex]);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
