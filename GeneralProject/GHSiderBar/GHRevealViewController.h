//
//  GHSidebarViewController.h
//  GHSidebarNav
//
//  Created by Greg Haines on 11/20/11.
//

#import <UIKit/UIKit.h>

extern const NSTimeInterval kGHRevealSidebarDefaultAnimationDuration;
extern const CGFloat kGHRevealSidebarWidth;

@protocol RevealControllerDelegate;

@interface GHRevealViewController : UIViewController

@property (nonatomic,assign) id<RevealControllerDelegate> delegate;

@property (nonatomic, readonly, getter = isSidebarShowing) BOOL sidebarShowing;
@property (strong, nonatomic) UIViewController *sidebarViewController;
@property (strong, nonatomic) UIViewController *contentViewController;
@property (strong, nonatomic) UIViewController *rightViewController;

- (void)dragContentView:(UIPanGestureRecognizer *)panGesture;
- (void)toggleSidebar:(BOOL)show duration:(NSTimeInterval)duration;
- (void)toggleSidebar:(BOOL)show duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

@end


@protocol RevealControllerDelegate <NSObject>

- (UIViewController *)rightControllerOnRevealViewController:(GHRevealViewController *)revealController;

@end