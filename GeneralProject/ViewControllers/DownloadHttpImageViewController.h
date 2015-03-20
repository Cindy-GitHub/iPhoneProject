//
//  DownloadHttpImageViewController.h
//  GeneralProject
//
//  Created by Chendi on 15/3/2.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadHttpImageViewController : UIViewController<NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end
