//
//  CDButtonView.m
//  GeneralProject
//
//  Created by Chendi on 15/5/19.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import "CDButtonView.h"

enum State{
    NormalState = 0,
    HighLightState,
    DisenableState
};

@interface CDButtonView()

@property (nonatomic, retain, getter = isImageView) UIImageView *imageView;
@property (nonatomic, retain, getter = isLabel) UILabel *label;
@property (nonatomic, getter = isState) enum State state;

@property (copy, nonatomic) void (^CDButtonViewPressEventActionBlock)(CDButtonView *);

@end

@implementation CDButtonView
#pragma mark  init Method
- (instancetype)init
{
    self = [super init];
    if (self) {
        _enable = YES;
        _state = NormalState;
        
        _imageView = [[UIImageView alloc] init];
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:_imageView];
        [self addSubview:_label];
        
        
//        CGSize imageSize = [_normalImage size];
//        CGSize labelSize = [_label.text sizeWithAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName: _label.font}];
//        
//        [_imageView makeConstraints:^(MASConstraintMaker *make) {
//            make.size.equalTo(imageSize);
//            make.centerX.equalTo(self.centerX);
//            make.centerY.equalTo(self.centerY).offset(-(labelSize.height)/2.0);
//        }];
//        
//        [_label makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.left);
//            make.right.equalTo(self.right);
//            make.top.equalTo(_imageView.bottom);
//            make.height.equalTo(labelSize.height);
//        }];
    }
    
    return self;
}

- (instancetype)initWithNormalImage:(UIImage *)normalImage  andLableText:(NSString *)textLabel andFont:(UIFont *)labelFont andNormalColor:(UIColor *)normalColor
{
    self = [super init];
    if (self) {
        
        _enable = YES;
        _state = NormalState;
        _normalImage = normalImage;
        _labelNormalColor = normalColor;
        
        _imageView = [[UIImageView alloc] initWithImage:_normalImage];
        _label = [[UILabel alloc] init];
        _label.text = textLabel;
        _label.font = labelFont;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = _labelNormalColor;
        [self addSubview:_imageView];
        [self addSubview:_label];
        
        
        CGSize imageSize = [_normalImage size];
        CGSize labelSize = [_label.text sizeWithAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName: _label.font}];
        
        [_imageView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(imageSize);
            make.centerX.equalTo(self.centerX);
            make.centerY.equalTo(self.centerY).offset(-(labelSize.height)/2.0);
        }];
        
        [_label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left);
            make.right.equalTo(self.right);
            make.top.equalTo(_imageView.bottom);
            make.height.equalTo(labelSize.height);
        }];
        
    }
    
    return self;
}

#pragma mark setter method
- (void)setNormalImage:(UIImage *)normalImage
{
    _normalImage = normalImage;
    [self updateImageAndLabelState];
}

- (void)setHighLightImage:(UIImage *)highLightImage
{
    _highLightImage = highLightImage;
    [self updateImageAndLabelState];
}

- (void)setDisenableImage:(UIImage *)disenableImage
{
    _disenableImage = disenableImage;
    [self updateImageAndLabelState];
}

- (void)setTextLabel:(NSString *)textLabel
{
    _textLabel = textLabel;
    [self updateImageAndLabelState];
}

- (void)setEnable:(BOOL)enable
{
    if (enable) {
        self.state = NormalState;
    } else {
        self.state = DisenableState;
    }
    _enable = enable;
}

- (void)setState:(enum State)state
{
    _state = state;
    [self updateImageAndLabelState];
}

#pragma mark - Private Method
- (void)updateImageAndLabelState
{
    CGSize oldImageSize = [_imageView .image size];
    CGSize oldLabelSize = [_label.text sizeWithAttributes:@{NSForegroundColorAttributeName: _label.textColor , NSFontAttributeName: _label.font}];
    switch (self.state) {
        case NormalState:
        {
            if (_normalImage && self.imageView.image != _normalImage) {
                self.imageView.image = _normalImage;
            }
            if (_labelNormalColor && self.label.textColor != _labelNormalColor) {
                self.label.textColor = _labelNormalColor;
            }
            if ([_label.text isEqualToString:_textLabel] == NO) {
                _label.text = _textLabel;
            }
        }
            break;
        case HighLightState:
        {
            if (_highLightImage && self.imageView.image != _highLightImage) {
                self.imageView.image = _highLightImage;
            }
            if (_lableHighLightColor && self.label.textColor != _lableHighLightColor) {
                self.label.textColor = _lableHighLightColor;
            }
            if ([_label.text isEqualToString:_textLabel] == NO) {
                _label.text = _textLabel;
            }
        }
            break;
        case DisenableState:
        {
            if (_disenableImage && self.imageView.image != _disenableImage) {
                self.imageView.image = _disenableImage;
            }
            if (_labelDisenableColor && self.label.textColor != _labelDisenableColor) {
                self.label.textColor = _labelDisenableColor;
            }
            if ([_label.text isEqualToString:_textLabel] == NO) {
                _label.text = _textLabel;
            }
        }
            break;
        default:
            break;
    }
    
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
- (void)addClickActionEvent:(void (^)(CDButtonView *view))CDButtonViewPressEvent
{
    self.CDButtonViewPressEventActionBlock = CDButtonViewPressEvent;
}


#pragma mark - UIKit Method
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.enable) {  //  能响应点击
        self.state = HighLightState;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.enable) {  //  能响应点击
        self.CDButtonViewPressEventActionBlock(self); //  执行点击操作
        dispatch_after( dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.state = NormalState;
        });
    }
}

- (void)layoutSubviews
{
    [self updateImageAndLabelState];
}

@end
