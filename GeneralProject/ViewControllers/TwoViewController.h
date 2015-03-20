//
//  TwoViewController.h
//  GeneralProject
//
//  Created by Cindy on 11/23/14.
//  Copyright (c) 2014 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *MyCollectionView;

@end
