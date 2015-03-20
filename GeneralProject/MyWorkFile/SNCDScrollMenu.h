//
//  SNCDScrollMenu.h
//  GeneralProject
//
//  Created by Chendi on 15/2/26.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNCDItem.h"

@class ACPScrollMenu;

@protocol SNCDScrollDelegate <NSObject>

/*
 Delegate method, executed when the user press any item
 
 @param	menu	ACPScrollMenu component
 @param	selectedIndex	index of the item selected by the user
 */
- (void)scrollMenu:(ACPScrollMenu *)menu didSelectIndex:(NSInteger)selectedIndex;

@end

@interface SNCDScrollMenu : UIView <SNCDItemDelegate, UIScrollViewDelegate>

//Type of animations
typedef enum {
    ACPFadeZoomIn,
    ACPFadeZoomOut,
    ACPShake,
    ACPClassicAnimation,
    ACPZoomOut
} ACPAnimation;


@property (nonatomic, weak) id <SNCDScrollDelegate> delegate;

@property (nonatomic, strong) NSArray *menuArray;
//@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign) ACPAnimation animationType;

/*
 Set up the menu programatically, if you are using storyboard, you dont need to use it.
 
 @param	frame	frame of the container
 @param	bgColor	background color of the container
 @param	menuItems	Array with the ACPItems
 
 @return	The container with the items in order
 */
- (id)initACPScrollMenuWithFrame:(CGRect)frame withBackgroundColor:(UIColor *)bgColor menuItems:(NSArray *)menuItems;


/*
 The same as the method before, but we should have defined the component in the storyboard or xib file.
 
 @param	frame	frame of the container
 @param	bgColor	background color of the container
 @param	menuItems	Array with the ACPItems
 
 @return	The container with the items in order
 */
- (void)setSNCDScrollMenu:(NSArray *)menuItems;

- (void)updateScrollMenuLayout;

/*
 If you want an item selected by default
 
 @param	itemNumber	This number represent the item in itemsArray
 */
- (void)setThisItemHighlighted:(NSInteger)itemNumber;

/*
 Change the background color of this view.
 
 @param	color	your favorite color.
 */
- (void)setACPBackgroundColor:(UIColor *)color;

@end
