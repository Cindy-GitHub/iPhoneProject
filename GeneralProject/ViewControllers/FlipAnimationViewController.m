//
//  FlipAnimationViewController.m
//  GeneralProject
//
//  Created by Chendi on 15/2/26.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import "FlipAnimationViewController.h"

@interface FlipAnimationViewController ()

@end

@implementation FlipAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)startFlip:(id)sender
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.viewSupper cache:YES];
    
    //这里时查找视图里的子视图（这种情况查找，可能时因为父视图里面不只两个视图）
//    NSInteger fist= [[self.viewSupper subviews] indexOfObject:self.viewGreen];
//    NSInteger seconde= [[self.viewSupper subviews] indexOfObject:self.viewYellow];
//    [self.viewSupper exchangeSubviewAtIndex:fist withSubviewAtIndex:seconde];
    
    //当父视图里面只有两个视图的时候，可以直接使用下面这段.
    [self.viewSupper exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

@end
