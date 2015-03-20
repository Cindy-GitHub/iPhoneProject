//
//  SNCDItem.h
//  GeneralProject
//
//  Created by Chendi on 15/2/26.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNCDItem;

@protocol SNCDItemDelegate <NSObject>

- (void)itemTouchesBegan:(SNCDItem *)item;
- (void)itemTouchesEnd:(SNCDItem *)item;

@end


@interface SNCDItem : UIView

typedef enum {
    ACPImageItem,
    ACPLabelItem,
    ACPImageAndLabeItem
} ACPItemType;

@property (nonatomic, weak) id <SNCDItemDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
//@property (weak, nonatomic) IBOutlet UILabel *labelItem;
//@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@property (assign, nonatomic) BOOL highlighted;


/*
 Initialization of the item inside of the scrollview
 
 @param	backgroundImage	The background image
 @param	iconImage	Icon of the item. Could be nil if you dont want an icon
 @param	labelItem	Text of the item. Could be nil if you only want the icon
 
 @return	Item
 */
- (id)initSNCDItem:(UIImage *)backgroundImage iconImage:(UIImage *)iconImage andLabel:(NSString *)labelItem;

/*
 Implement this method if you want a custom highlighted state for you item
 */

- (void)setHighlightedBackground:(UIImage *)backgroundImageHightlighted iconHighlighted:(UIImage *)iconImageHighlighted textColorHighlighted:(UIColor *)texColorHighlighted;

@end
