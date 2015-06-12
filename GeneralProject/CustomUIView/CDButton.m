//
//  CDButton.m
//  ScaleNet
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
    
@private
    BOOL  _canResponsed;  //  避免重复响应
    CGFloat  _contentModeOffset;
}

@property (weak, nonatomic) id actionTarget; // 监听器
@property (assign, nonatomic) SEL actionSelector; // 监听方法
@property (copy, nonatomic) void (^CDButtonViewPressEventActionBlock)(CDButton *);

@end


@implementation CDButton

#pragma mark  init Method

- (void)awakeFromNib
{
    [self initSubview];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubview];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)initSubview
{
    if (_imageView == nil || _label == nil) {
        _enable = YES;
        _canResponsed = YES;
        _state = CDButtonControlStateNormal;
        _buttonContentMode = CDButtonContentCenter;
        _contentModeOffset = 0;
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:12.0];
        _label.textColor = [UIColor blackColor];
        [self addSubview:_imageView];
        [self addSubview:_label];
    }
}

#pragma mark - setter method
- (void)setState:(CDButtonViewControlState)state
{
    if (_state != state) {
        _state = state;
        [self updateButtonContentDisplay];
    }
}

- (void)setButtonContentMode:(CDButtonContentMode)buttonContentMode
{
    if (_buttonContentMode != buttonContentMode) {
        _buttonContentMode = buttonContentMode;
        [self updateConstraintWithContentModeChanged:YES];
    }
}

- (void)setEnable:(BOOL)enable
{
    if (enable) {
        self.state = CDButtonControlStateNormal;
    } else {
        self.state = CDButtonControlStateDisabled;
    }
    _enable = enable;
}

#pragma mark - view method
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateButtonContentDisplay];
}

#pragma mark - Private Method
- (void)updateButtonContentDisplay
{
    if (_label == nil || _imageView == nil) {
        return;
    }
    //  更新显示内容
    if (_image[self.state]) {
        self.imageView.alpha = 1.0f;
        if (self.imageView.image != _image[self.state]) {
            self.imageView.image = _image[self.state];
        }
    } else {
        self.imageView.image = _image[CDButtonControlStateNormal];
        if (self.state == CDButtonControlStateHighlighted || self.state == CDButtonControlStateDisabled) {
            self.imageView.alpha = 0.4f;
        } else {
            self.imageView.alpha = 1.0f;
        }
    }
    
    if (_labelTextColor[self.state]) {
        self.label.alpha = 1.0f;
        if (self.label.textColor != _labelTextColor[self.state]) {
            self.label.textColor = _labelTextColor[self.state];
        }
    } else {
        self.label.textColor = _labelTextColor[CDButtonControlStateNormal];
        if (self.state == CDButtonControlStateHighlighted || self.state == CDButtonControlStateDisabled) {
            self.label.alpha = 0.4f;
        } else {
            self.label.alpha = 1.0f;
        }
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
    
    [self updateConstraintWithContentModeChanged:NO];
}

- (void)updateConstraintWithContentModeChanged:(BOOL)modeChanged
{
    //  根据新size来调整subview的约束
    CGFloat maxWidth;
    CGSize imageNewSize = [_imageView.image size];
    CGSize labelNewSize  = [_label.text sizeWithAttributes:@{NSForegroundColorAttributeName: _label.textColor , NSFontAttributeName: _label.font}];
    if (imageNewSize.width >= labelNewSize.width + 2.0) {
        maxWidth = imageNewSize.width;
    } else {
        maxWidth = labelNewSize.width + 2.0;
    }
    
    if (modeChanged) {   //  content位置更改
        [_imageView remakeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(maxWidth, imageNewSize.height));
            make.centerY.equalTo(self.centerY).offset(-(labelNewSize.height)/2.0);
            if (_buttonContentMode == CDButtonContentRight) {
                make.centerX.equalTo(self.right).offset(-maxWidth/2.0 - _contentModeOffset);
            } else if (_buttonContentMode == CDButtonContentLeft) {
                make.centerX.equalTo(self.left).offset(maxWidth/2.0 + _contentModeOffset);
            } else {
                make.centerX.equalTo(self.centerX);
            }
        }];
        
        [_label remakeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(maxWidth, labelNewSize.height));
            make.top.equalTo(_imageView.bottom);
            make.centerX.equalTo(_imageView.centerX);
        }];
        
    } else {    //  content位置没有更改
        [_imageView updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(maxWidth, imageNewSize.height));
            make.centerY.equalTo(self.centerY).offset(-(labelNewSize.height)/2.0);
            if (_buttonContentMode == CDButtonContentRight) {
                make.centerX.equalTo(self.right).offset(-maxWidth/2.0 - _contentModeOffset);
            } else if (_buttonContentMode == CDButtonContentLeft) {
                make.centerX.equalTo(self.left).offset(maxWidth/2.0 + _contentModeOffset);
            } else {
                make.centerX.equalTo(self.centerX);
            }
        }];
        
        [_label updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(maxWidth, labelNewSize.height));
            make.top.equalTo(_imageView.bottom);
            make.centerX.equalTo(_imageView.centerX);
        }];
        
    }
    
    [self layoutIfNeeded];
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
        [self updateButtonContentDisplay];
    }
}

- (void)setTitle:(NSString *)title forState:(CDButtonViewControlState)state
{
    _labelText[state] = title;
    if (self.state == state) {
        [self updateButtonContentDisplay];
    }
}

- (void)setTitleColor:(UIColor *)color forState:(CDButtonViewControlState)state
{
    _labelTextColor[state] = color;
    if (self.state == state) {
        [self updateButtonContentDisplay];
    }
}

- (void)setBackgroundColor:(UIColor *)color forState:(CDButtonViewControlState)state
{
    _backgroundColor[state] = color;
    if (self.state == state) {
        [self updateButtonContentDisplay];
    }
}

- (void)setButtonContentMode:(CDButtonContentMode)contentMode withOffset:(CGFloat)offset
{
    _contentModeOffset = offset;
    self.buttonContentMode = contentMode;
}

#pragma mark - Event Method
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.enable && _canResponsed) {  //  能响应点击
        self.state = CDButtonControlStateHighlighted;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.enable && _canResponsed) {  //  能响应点击
        dispatch_after( dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.enable = _enable;
        });
        
        _canResponsed = NO;
        if ([self.actionTarget respondsToSelector:self.actionSelector]) { // 回调即消息发送
            messageSend(messageTarget(self.actionTarget), self.actionSelector, self);
        }
        
        if (self.CDButtonViewPressEventActionBlock) {  //  执行点击操作的block
            self.CDButtonViewPressEventActionBlock(self);
        }
        _canResponsed = YES;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after( dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.enable = _enable;
    });
}

@end
