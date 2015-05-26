//
//  CDButtonView.h
//  GeneralProject
//
//  Created by Chendi on 15/5/19.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, CDButtonViewControlState) {
    CDButtonControlStateNormal  = 0,
    CDButtonControlStateHighlighted = 1,
    CDButtonControlStateDisabled = 2
};

@interface CDButtonView : UIView

@property(nonatomic,readonly,retain) UIImageView *imageView;
@property(nonatomic,readonly,retain) UILabel *label;

@property(nonatomic,readonly,getter=isState) CDButtonViewControlState state;
@property(nonatomic,readwrite) BOOL enable;


//  set content for state
- (void)setImage:(UIImage *)image forState:(CDButtonViewControlState)state;
- (void)setTitle:(NSString *)title forState:(CDButtonViewControlState)state;
- (void)setTitleColor:(UIColor *)color forState:(CDButtonViewControlState)state;
- (void)setBackgroundColor:(UIColor *)color forState:(CDButtonViewControlState)state;

//  add action
- (void)addClickActionEvent:(void (^)(CDButtonView *view))CDButtonViewPressEvent;

@end

//  block 声明
typedef void (^CDButtonViewPressEventActionBlock)(CDButtonView *view);











