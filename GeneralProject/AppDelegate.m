//
//  AppDelegate.m
//  GeneralProject
//
//  Created by Cindy on 11/21/14.
//  Copyright (c) 2014 Cindy. All rights reserved.
//

#import "AppDelegate.h"
#import "oneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FlipAnimationViewController.h"
#import "KeyboardViewController.h"
#import "DownloadHttpImageViewController.h"
#import "GHRevealViewController.h"
#import "DownloadViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame
{
    NSLog(@"oldStatusBarFrame : (%f,%f,%f,%f)",oldStatusBarFrame.origin.x,oldStatusBarFrame.origin.y,oldStatusBarFrame.size.width,oldStatusBarFrame.size.height);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString* strLanguage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    NSLog(@"Preferred Language:%@", strLanguage);
    
    if ([strLanguage compare:@"en" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        _currentLanguage = @"English";
    } else {
        _currentLanguage = @"Chinese";
    }
    
    //    oneViewController *oneController = [[oneViewController alloc] init];
    //    UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:oneController];
    //    TwoViewController *twoController = [[TwoViewController alloc] init];
    //    UINavigationController *navigationController2 = [[UINavigationController alloc] initWithRootViewController:twoController];
    //    ThreeViewController *threeController = [[ThreeViewController alloc] init];
    //    UINavigationController *navigationController3 = [[UINavigationController alloc] initWithRootViewController:threeController];
//        FourViewController *fourController = [[FourViewController alloc] init];
        FlipAnimationViewController *flip = [[FlipAnimationViewController alloc] init];
//    KeyboardViewController *key = [[KeyboardViewController alloc] init];
//    DownloadHttpImageViewController *download  = [[DownloadHttpImageViewController alloc] init];
    DownloadViewController *download = [[DownloadViewController alloc] init];
    GHRevealViewController *reveal = [[GHRevealViewController alloc] init];
    reveal.contentViewController = flip;
    reveal.rightViewController = download;
    UINavigationController *navigationController4 = [[UINavigationController alloc] initWithRootViewController:reveal];
    
    
    //    navigationController.toolbarHidden = YES;
    navigationController4.navigationBarHidden = YES;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController4;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)function
{
    NSMutableArray *allDataArray = [[NSMutableArray alloc] init];
    NSMutableArray *nameArray = [[NSMutableArray alloc] init];
    for (NSDictionary *oneDict in allDataArray) {
        NSString *name = [oneDict objectForKey:@"key"];
        if ([nameArray containsObject:name]) {
            continue;
        } else {
            [nameArray addObject:oneDict];
        }
    }
    
    NSMutableDictionary *maxDict = [[NSMutableDictionary alloc] init];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < nameArray.count ; i ++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *oneDict in allDataArray) {
            if ([[oneDict objectForKey:@"key"] isEqualToString:[nameArray objectAtIndex:i]]) {
                [array addObject:oneDict];
            }
        }
        [resultArray addObject:[NSDictionary dictionaryWithObject:array forKey:[nameArray objectAtIndex:i]]];
    }
    
    [maxDict setObject:resultArray forKey:@"result"];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
