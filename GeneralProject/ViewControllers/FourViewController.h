//
//  FourViewController.h
//  GeneralProject
//
//  Created by Chendi on 15/2/26.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNCDScrollMenu.h"

@interface FourViewController : UIViewController<SNCDScrollDelegate>

@property (weak, nonatomic) IBOutlet SNCDScrollMenu *myScrollView;

@end
