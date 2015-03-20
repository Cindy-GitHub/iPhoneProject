//
//  TwoViewController.m
//  GeneralProject
//
//  Created by Cindy on 11/23/14.
//  Copyright (c) 2014 Cindy. All rights reserved.
//

#import "TwoViewController.h"
#import "MyHelper.h"
#import "MyCell.h"

@interface TwoViewController ()
{
    NSMutableArray *_dataCollectionViewArray;
    NSArray *_imageArray;
}

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:YES];
    // Do any additional setup after loading the view from its nib.
     _imageArray = [[NSArray alloc] initWithObjects:@"hanguo.png",@"putaoya.png",@"ruishi.png",@"wigui.png",@"xiby.png",@"ydl.png",@"ying.png",@"zhongguo.png", nil];
    _dataCollectionViewArray = [[NSMutableArray alloc] init];
    _MyCollectionView.dataSource = self;
    _MyCollectionView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collection view data source and delegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"MyCell";
    [collectionView registerClass:[MyCell class] forCellWithReuseIdentifier:@"MyCell"];
    MyCell * cell = (MyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[_imageArray objectAtIndex:indexPath.row]]];
    cell.label.text = [NSString stringWithFormat:@"%@",[_imageArray objectAtIndex:indexPath.row]];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",[_imageArray objectAtIndex:indexPath.row]);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(CollectionCellViewWith, CollectionCellViewHeight);
    return size;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArray.count;
}

@end
