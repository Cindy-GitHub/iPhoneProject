//
//  SNCDScrollMenu.m
//  GeneralProject
//
//  Created by Chendi on 15/2/26.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import "SNCDScrollMenu.h"

static CGFloat const kScrollViewFirstWidth = 12.0f;
static CGFloat const kScrollViewItemMarginWidth = 5.0f;

@implementation SNCDScrollMenu

# pragma mark - Initialization
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        // Do something
    }
    return self;
}

- (id)initACPScrollMenuWithFrame:(CGRect)frame withBackgroundColor:(UIColor *)bgColor menuItems:(NSArray *)menuItems {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    if (menuItems.count == 0) {
        return nil;
    }
    
    [self setSNCDScrollMenu:menuItems];
    [self setACPBackgroundColor:bgColor];
    
    return self;
}

- (void)setSNCDScrollMenu:(NSArray *)menuItems {
    if (menuItems.count == 0) {
        return;
    }
    
    NSInteger menuItemsArrayCount = menuItems.count;
    // Setting ScrollView
    NSLog(@"self.frame: (%f,%f,%f,%f)",self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height)];
    SNCDItem *menuItem = menuItems[0];
    _scrollView.contentSize = CGSizeMake(kScrollViewFirstWidth * 2 + (kScrollViewItemMarginWidth * (menuItemsArrayCount - 1)) + menuItem.frame.size.width * menuItemsArrayCount, 0.0);
    _scrollView.contentOffset = CGPointMake(0.0, 0.0);
//    _scrollView.delegate = self;
    
    // Do not show scrollIndicator
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    _scrollView.backgroundColor = [UIColor greenColor];
    [_scrollView setUserInteractionEnabled:YES];
    [self addSubview:_scrollView];
    
    self.menuArray = menuItems;
    [self setMenu];
    
    _animationType = ACPZoomOut;
}

- (void)setMenu {
    int i = 0;
    for (SNCDItem *menuItem in _menuArray) {
        menuItem.tag = 1000 + i;
        menuItem.center = CGPointMake(menuItem.frame.size.width / 2 + kScrollViewFirstWidth + kScrollViewItemMarginWidth * i + menuItem.frame.size.width * i, self.frame.size.height / 2);
        menuItem.delegate = self;
        [_scrollView addSubview:menuItem];
        i++;
    }
}

- (void)updateScrollMenuLayout
{
//    [_scrollView setContentOffset:CGPointMake(0, 0)];
}

# pragma mark - Delegate Methods
- (void)itemTouchesBegan:(SNCDItem *)item {
    //item.highlighted = YES;
}

- (void)itemTouchesEnd:(SNCDItem *)item {
    // blowUp animation
    
    [self startAnimation:item];
    
    
    if ([_delegate respondsToSelector:@selector(scrollMenu:didSelectIndex:)]) {
        [_delegate scrollMenu:(id)self didSelectIndex:item.tag - 1000];
    }
}

# pragma mark - Animation & behaviour

- (void)startAnimation:(SNCDItem *)item {
    [self removeHighlighted];
    item.highlighted = YES;
    switch (_animationType) {
        case ACPFadeZoomIn: {
            [UIView animateWithDuration:0.25f animations: ^{
                CGAffineTransform scaleUpAnimation = CGAffineTransformMakeScale(1.9f, 1.9f);
                item.transform = scaleUpAnimation;
                item.alpha = 0.2;
            } completion: ^(BOOL finished) {
                [UIView animateWithDuration:0.25f animations: ^{
                    item.transform = CGAffineTransformIdentity;
                    item.alpha = 1.0f;
                } completion: ^(BOOL finished) {
                    item.highlighted = YES;
                }];
            }];
            break;
        }
            
        case ACPFadeZoomOut: {
            [UIView animateWithDuration:0.5f animations: ^{
                CGAffineTransform scaleDownAnimation = CGAffineTransformMakeScale(0.9f, 0.9f);
                item.transform = scaleDownAnimation;
                item.alpha = 0.2;
            } completion: ^(BOOL finished) {
                [UIView animateWithDuration:0.3f animations: ^{
                    item.transform = CGAffineTransformIdentity;
                    item.alpha = 1.0f;
                } completion: ^(BOOL finished) {
                    item.highlighted = YES;
                }];
            }];
            break;
        }
            
        case ACPZoomOut: {
            [UIView animateWithDuration:0.1f animations: ^{
                CGAffineTransform scaleDownAnimation = CGAffineTransformMakeScale(0.5f, 0.5f);
                item.transform = scaleDownAnimation;
            } completion: ^(BOOL finished) {
                [UIView animateWithDuration:0.1f animations: ^{
                    item.transform = CGAffineTransformIdentity;
                } completion: ^(BOOL finished) {
                    item.highlighted = YES;
                }];
            }];
            break;
        }
            
        default: {
            [UIView animateWithDuration:0.25f animations: ^{
                CGAffineTransform scaleUpAnimation = CGAffineTransformMakeScale(1.9f, 1.9f);
                item.transform = scaleUpAnimation;
                item.alpha = 0.2;
            } completion: ^(BOOL finished) {
                [UIView animateWithDuration:0.25f animations: ^{
                    item.transform = CGAffineTransformIdentity;
                    item.alpha = 1.0f;
                } completion: ^(BOOL finished) {
                    item.highlighted = YES;
                }];
            }];
            break;
        }
    }
}

- (void)removeHighlighted  {
    for (SNCDItem *menuItem in self.menuArray) {
        menuItem.highlighted = NO;
    }
}

- (void)setThisItemHighlighted:(NSInteger)itemNumber {
    [self removeHighlighted];
    [[self.menuArray objectAtIndex:itemNumber] setHighlighted:YES];
}

# pragma mark - Extra configuration

- (void)setACPBackgroundColor:(UIColor *)color {
    self.backgroundColor = color;
}

#pragma mark - ScrollView Delegate
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    
////    _scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0.0);
//}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    static CGFloat lastX = -1;
//    if (lastX == scrollView.contentOffset.x) {
//        
//    }
//    NSLog(@"my subviews1 : %@",self.subviews);
//    _scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0.0);
//    NSLog(@"my subviews2 : %@",self.subviews);
//}

@end
