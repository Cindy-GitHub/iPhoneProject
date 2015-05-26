//
//  CDButton.m
//  GeneralProject
//
//  Created by Chendi on 15/5/26.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import "CDButton.h"
#import <objc/message.h>

@interface CDButton ()
{
    UIImage *_image[3];
    NSString *_labelText[3];
    UIColor *_labelTextColor[3];
    UIColor *_backgroundColor[3];
}
//  image
//@property (nonatomic, retain) UIImage *imageNormal;
//@property (nonatomic, retain) UIImage *imageHighLight;
//@property (nonatomic, retain) UIImage *imageDisenable;

//  label text content
//@property (nonatomic, retain) NSString *labelTextNormal;
//@property (nonatomic, retain) NSString *labelTextHighLight;
//@property (nonatomic, retain) NSString *labelTextDisenable;

//  label text color
//@property (nonatomic, retain) UIColor *labelTextColorNormal;
//@property (nonatomic, retain) UIColor *lableTextColorHighLight;
//@property (nonatomic, retain) UIColor *labelTextColorDisenable;

//  background color
//@property (nonatomic, retain) UIColor *backgroundColorNormal;
//@property (nonatomic, retain) UIColor *backgroundColorHighLight;
//@property (nonatomic, retain) UIColor *backgroundColorDisenable;


@property (weak, nonatomic) id actionTarget; // 监听器
@property (assign, nonatomic) SEL actionSelector; // 监听方法
@property (copy, nonatomic) void (^CDButtonViewPressEventActionBlock)(CDButton *);

@end


@implementation CDButton

#pragma mark  init Method
- (instancetype)init
{
    self = [super init];
    if (self) {
        _enable = YES;
        _state = CDButtonControlStateNormal;
        
        _imageView = [[UIImageView alloc] init];
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:12.0];
        _label.textColor = [UIColor blackColor];
        [self addSubview:_imageView];
        [self addSubview:_label];
    }
    
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _enable = YES;
        _state = CDButtonControlStateNormal;
        
        _imageView = [[UIImageView alloc] init];
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:12.0];
        _label.textColor = [UIColor blackColor];
        [self addSubview:_imageView];
        [self addSubview:_label];
    }
    
    self.backgroundColor = [UIColor clearColor];
    return self;
}

#pragma mark - setter method
- (void)setState:(CDButtonViewControlState)state
{
    if (_state != state) {
        _state = state;
        [self updateButtonContentAndConstraint];
    }
}

#pragma mark - view method
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateButtonContentAndConstraint];
}

#pragma mark - Private Method
- (void)updateButtonContentAndConstraint
{
    //  保存旧的size
    CGSize oldImageSize = [_imageView.image size];
    CGSize oldLabelSize = [_label.text sizeWithAttributes:@{NSForegroundColorAttributeName: _label.textColor , NSFontAttributeName: _label.font}];
    
    //  更新显示内容
    if (_image[self.state]) {
        if (self.imageView.image != _image[self.state]) {
            self.imageView.image = _image[self.state];
        }
    } else {
        self.imageView.image = _image[CDButtonControlStateNormal];
    }
    
    if (_labelTextColor[self.state]) {
        if (self.label.textColor != _labelTextColor[self.state]) {
            self.label.textColor = _labelTextColor[self.state];
        }
    } else {
        self.label.textColor = _labelTextColor[CDButtonControlStateNormal];
    }
    if (_labelText[self.state]) {
        if ([self.label.text isEqualToString:_labelText[self.state]] == NO) {
            self.label.text = _labelText[self.state];
        }
    } else {
        self.label.text = _labelText[CDButtonControlStateNormal];
    }
    
    if (_backgroundColor[self.state]) {
        if (self.backgroundColor != _backgroundColor[self.state]) {
            self.backgroundColor = _backgroundColor[self.state];
        }
    } else {
        self.backgroundColor = _backgroundColor[CDButtonControlStateNormal];
    }
    
    //  根据新旧size来调整subview的约束
    CGSize labelNewSize  = [_label.text sizeWithAttributes:@{NSForegroundColorAttributeName: _label.textColor , NSFontAttributeName: _label.font}];
    if ((CGSizeEqualToSize(oldImageSize, [_imageView.image size]) == NO) || (CGSizeEqualToSize(oldLabelSize, labelNewSize) == NO)) {
        [_imageView updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo([_imageView.image size]);
            make.centerX.equalTo(self.centerX);
            make.centerY.equalTo(self.centerY).offset(-(labelNewSize.height)/2.0);
        }];
        
        [_label updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left);
            make.right.equalTo(self.right);
            make.top.equalTo(_imageView.bottom);
            make.height.equalTo(labelNewSize.height);
        }];
        [self layoutIfNeeded];
    }
}

#pragma mark - public method
- (void)addBlockCodeActionEvent:(void (^)(CDButton *view))CDButtonViewPressEventBlock
{
    self.CDButtonViewPressEventActionBlock = CDButtonViewPressEventBlock;
}

- (void)addTarget:(id)target andAction:(SEL)selector
{
    self.actionTarget = target;
    self.actionSelector = selector;
}

#pragma mark -
- (void)setImage:(UIImage *)image forState:(CDButtonViewControlState)state
{
    _image[state] = image;
    if (self.state == state) {
        [self updateButtonContentAndConstraint];
    }
}

- (void)setTitle:(NSString *)title forState:(CDButtonViewControlState)state
{
    _labelText[state] = title;
    if (self.state == state) {
        [self updateButtonContentAndConstraint];
    }
}

- (void)setTitleColor:(UIColor *)color forState:(CDButtonViewControlState)state
{
    _labelTextColor[state] = color;
    if (self.state == state) {
        [self updateButtonContentAndConstraint];
    }
}

- (void)setBackgroundColor:(UIColor *)color forState:(CDButtonViewControlState)state
{
    _backgroundColor[state] = color;
    if (self.state == state) {
        [self updateButtonContentAndConstraint];
    }
}



#pragma mark - Event Method
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.enable) {  //  能响应点击
        self.state = CDButtonControlStateHighlighted;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.enable) {  //  能响应点击
        self.enable = NO;
        
        if ([self.actionTarget respondsToSelector:self.actionSelector]) { // 回调即消息发送
            messageSend(messageTarget(self.actionTarget), self.actionSelector, self);
        }
        
        if (self.CDButtonViewPressEventActionBlock) {  //  执行点击操作的block
            self.CDButtonViewPressEventActionBlock(self);
        }
        
        dispatch_after( dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.state = CDButtonControlStateNormal;
            self.enable = YES;
        });
    }
}

@end
