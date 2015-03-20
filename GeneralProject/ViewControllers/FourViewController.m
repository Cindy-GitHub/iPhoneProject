//
//  FourViewController.m
//  GeneralProject
//
//  Created by Chendi on 15/2/26.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)appBecomeActiveNotification:(NSNotification *)notification
{
//    NSLog(@"subviews1 ; %@",self.myScrollView.subviews);
    NSArray *subViews =  [self.myScrollView subviews];
    for (int i = 0 ;i < subViews.count ; i ++) {
        UIView *view = subViews[i];
        [view removeFromSuperview];
    }
    [self setUpACPScroll];
//    NSLog(@"subviews2 ; %@",self.myScrollView.subviews);
    NSLog(@"AppBecomeActiveNotification !");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
//    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(setUpACPScroll) userInfo:nil repeats:NO];
    [self setUpACPScroll];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecomeActiveNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)setUpACPScroll {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 1; i < 5; i++) {
        NSString *imgName = [NSString stringWithFormat:@"%d.png", i];
        NSString *imgSelectedName = [NSString stringWithFormat:@"%ds.png", i];
        //Set the items
        SNCDItem *item = [[SNCDItem alloc] initSNCDItem:[UIImage imageNamed:@"bg.png"] iconImage:[UIImage imageNamed:imgName] andLabel:nil];
        //Set highlighted behaviour
        [item setHighlightedBackground:nil iconHighlighted:[UIImage imageNamed:imgSelectedName] textColorHighlighted:[UIColor redColor]];
        [array addObject:item];
    }
    for (int i = 1; i < 5; i++) {
        NSString *imgName = [NSString stringWithFormat:@"%d.png", i];
        NSString *imgSelectedName = [NSString stringWithFormat:@"%ds.png", i];
        //Set the items
        SNCDItem *item = [[SNCDItem alloc] initSNCDItem:[UIImage imageNamed:@"bg.png"] iconImage:[UIImage imageNamed:imgName] andLabel:nil];
        //Set highlighted behaviour
        [item setHighlightedBackground:nil iconHighlighted:[UIImage imageNamed:imgSelectedName] textColorHighlighted:[UIColor redColor]];
        [array addObject:item];
    }
    
    [self.myScrollView setSNCDScrollMenu:array];
    
    //We choose an animation when the user touch the item (you can create your own animation)
    [self.myScrollView setAnimationType:ACPZoomOut];
    
    self.myScrollView.delegate = self;
}

#pragma mark - ACPScrollView Delegate
-(void)scrollMenu:(ACPScrollMenu *)menu didSelectIndex:(NSInteger)selectedIndex
{
    NSLog(@"click item number : %zi",selectedIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
