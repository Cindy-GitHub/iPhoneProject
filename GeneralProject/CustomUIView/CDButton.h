//
//  CDButton.h
//  GeneralProject
//
//  Created by Chendi on 15/5/26.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define messageSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define messageTarget(target) (__bridge void *)(target)

typedef NS_OPTIONS(NSUInteger, CDButtonViewControlState) {
    CDButtonControlStateNormal  = 0,
    CDButtonControlStateHighlighted = 1,
    CDButtonControlStateDisabled = 2
};


@interface CDButton : UIView

@property(nonatomic,readonly,retain) UIImageView *imageView;
@property(nonatomic,readonly,retain) UILabel *label;

@property(nonatomic,readonly,getter=isState) CDButtonViewControlState state;
@property(nonatomic,readwrite) BOOL enable;


//  set content for state
- (void)setImage:(UIImage *)image forState:(CDButtonViewControlState)state;
- (void)setTitle:(NSString *)title forState:(CDButtonViewControlState)state;
- (void)setTitleColor:(UIColor *)color forState:(CDButtonViewControlState)state;
- (void)setBackgroundColor:(UIColor *)color forState:(CDButtonViewControlState)state;


//  add action event  (provide two way)
- (void)addTarget:(id)taget andAction:(SEL)selector;  //  once way is message send
- (void)addBlockCodeActionEvent:(void (^)(CDButton *view))CDButtonViewPressEventBlock;  //  second way is block call back

@end
