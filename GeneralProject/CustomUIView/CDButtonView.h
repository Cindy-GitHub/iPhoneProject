//
//  CDButtonView.h
//  GeneralProject
//
//  Created by Chendi on 15/5/19.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDButtonView : UIView

@property (nonatomic, retain) UIImage *normalImage;
@property (nonatomic, retain) UIImage *highLightImage;
@property (nonatomic, retain) UIImage *disenableImage;

@property (nonatomic, retain) NSString *textLabel;
@property (nonatomic, retain) UIColor *labelNormalColor;
@property (nonatomic, retain) UIColor *lableHighLightColor;
@property (nonatomic, retain) UIColor *labelDisenableColor;

@property (nonatomic) BOOL enable;


//  init method
- (instancetype)initWithNormalImage:(UIImage *)normalImage  andLableText:(NSString *)textLabel andFont:(UIFont *)labelFont andNormalColor:(UIColor *)normalColor;

//  add action
- (void)addClickActionEvent:(void (^)(CDButtonView *view))CDButtonViewPressEvent;

@end

typedef void (^CDButtonViewPressEventActionBlock)(CDButtonView *view);