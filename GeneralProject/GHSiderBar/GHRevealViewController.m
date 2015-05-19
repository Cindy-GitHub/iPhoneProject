//
//  GHSidebarViewController.m
//  GHSidebarNav
//
//  Created by Greg Haines on 11/20/11.
//

#import "GHRevealViewController.h"
#import <QuartzCore/QuartzCore.h>


#pragma mark -
#pragma mark Constants
const NSTimeInterval kGHRevealSidebarDefaultAnimationDuration = 0.25;
const CGFloat kGHRevealSidebarWidth = 200.0f;
const CGFloat kGHRevealSidebarFlickVelocity = 800.0f;

const CGFloat kGHRevealRightViewWidth = 250.0f;


#pragma mark -
#pragma mark Private Interface
@interface GHRevealViewController ()
@property (nonatomic, readwrite, getter = isSidebarShowing) BOOL sidebarShowing;
@property (nonatomic, readwrite, getter = isSearching) BOOL searching;
@property (nonatomic, strong) UIView *searchView;
- (void)hideSidebar;
@end


#pragma mark -
#pragma mark Implementation
@implementation GHRevealViewController {
@private
	UIView *_sidebarView;
	UIView *_contentView;
    UIView *_rightView;
//	UITapGestureRecognizer *_tapRecog;
    UIPanGestureRecognizer *_panRecog;
    BOOL  _isMoveSlideBar;
    UITapGestureRecognizer *_tapRecogHiddenRightView;
    UIButton *_downloadButton;
}

- (void)setSidebarViewController:(UIViewController *)svc {
	if (_sidebarViewController == nil) {
		svc.view.frame = _sidebarView.bounds;
		_sidebarViewController = svc;
		[self addChildViewController:_sidebarViewController];
		[_sidebarView addSubview:_sidebarViewController.view];
		[_sidebarViewController didMoveToParentViewController:self];
	} else if (_sidebarViewController != svc) {
		svc.view.frame = _sidebarView.bounds;
		[_sidebarViewController willMoveToParentViewController:nil];
		[self addChildViewController:svc];
		self.view.userInteractionEnabled = NO;
		[self transitionFromViewController:_sidebarViewController
						  toViewController:svc 
								  duration:0
								   options:UIViewAnimationOptionTransitionNone
								animations:^{} 
								completion:^(BOOL finished){
									self.view.userInteractionEnabled = YES;
									[_sidebarViewController removeFromParentViewController];
									[svc didMoveToParentViewController:self];
									_sidebarViewController = svc;
								}
		 ];
	}
    
    [svc.view makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sidebarView.top);
        make.left.equalTo(_sidebarView.left);
        make.right.equalTo(_sidebarView.right);
        make.bottom.equalTo(_sidebarView.bottom);
    }];
}

- (void)setContentViewController:(UIViewController *)cvc {
	if (_contentViewController == nil) {
		cvc.view.frame = _contentView.bounds;
		_contentViewController = cvc;
		[self addChildViewController:_contentViewController];
		[_contentView addSubview:_contentViewController.view];
		[_contentViewController didMoveToParentViewController:self];
	} else if (_contentViewController != cvc) {
		cvc.view.frame = _contentView.bounds;
		[_contentViewController willMoveToParentViewController:nil];
		[self addChildViewController:cvc];
		self.view.userInteractionEnabled = NO;
		[self transitionFromViewController:_contentViewController
						  toViewController:cvc 
								  duration:0
								   options:UIViewAnimationOptionTransitionNone
								animations:^{}
								completion:^(BOOL finished){
									self.view.userInteractionEnabled = YES;
									[_contentViewController removeFromParentViewController];
									[cvc didMoveToParentViewController:self];
									_contentViewController = cvc;
								}
		];
	}
    
    [cvc.view makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.top);
        make.left.equalTo(_contentView.left);
        make.right.equalTo(_contentView.right);
        make.bottom.equalTo(_contentView.bottom);
    }];
    
    [_contentView insertSubview:_downloadButton aboveSubview:cvc.view];
}

- (void)setRightViewController:(UIViewController *)controller {
    if (_rightViewController == nil) {
        controller.view.frame = _rightView.bounds;
        _rightViewController = controller;
        [self addChildViewController:_rightViewController];
        [_rightView addSubview:_rightViewController.view];
        [_rightViewController didMoveToParentViewController:self];
    } else if (_rightViewController != controller) {
        controller.view.frame = _rightView.bounds;
        [_rightViewController willMoveToParentViewController:nil];
        [self addChildViewController:controller];
        self.view.userInteractionEnabled = NO;
        [self transitionFromViewController:_rightViewController
                          toViewController:controller
                                  duration:0
                                   options:UIViewAnimationOptionTransitionNone
                                animations:^{}
                                completion:^(BOOL finished){
                                    self.view.userInteractionEnabled = YES;
                                    [_rightViewController removeFromParentViewController];
                                    [controller didMoveToParentViewController:self];
                                    _rightViewController = controller;
                                }
         ];
    }
    
    [controller.view makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rightView.top);
        make.left.equalTo(_rightView.left);
        make.right.equalTo(_rightView.right);
        make.bottom.equalTo(_rightView.bottom);
    }];
    
}

#pragma mark Memory Management
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.sidebarShowing = NO;
		self.searching = NO;
//		_tapRecog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSidebar)];
//		_tapRecog.cancelsTouchesInView = YES;
        _panRecog = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragContentView:)];
        _tapRecogHiddenRightView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenRightView:)];
		
		self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		
		_sidebarView = [[UIView alloc] init];
		_sidebarView.backgroundColor = [UIColor whiteColor];
		[self.view addSubview:_sidebarView];
        [_sidebarView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.top);
            make.left.equalTo(self.view.left);
            make.width.equalTo(kGHRevealSidebarWidth);
            make.bottom.equalTo(self.view.bottom);
        }];
        
		
		_contentView = [[UIView alloc] init];
		_contentView.backgroundColor = [UIColor clearColor];
		_contentView.layer.masksToBounds = NO;
		_contentView.layer.shadowColor = [UIColor grayColor].CGColor;
		_contentView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
		_contentView.layer.shadowOpacity = 1.0f;
		_contentView.layer.shadowRadius = 2.5f;
        [_contentView addGestureRecognizer:_panRecog];
        [self.view addSubview:_contentView];
        [_contentView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.top);
            make.left.equalTo(self.view.left);
            make.right.equalTo(self.view.right);
            make.bottom.equalTo(self.view.bottom);
        }];
        
        _downloadButton = [[UIButton alloc] init];
        _downloadButton.backgroundColor = [UIColor yellowColor];
        [_downloadButton setTitle:@"Download" forState:UIControlStateNormal];
        [_downloadButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _downloadButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_downloadButton addTarget:self action:@selector(rightButtonPressEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_downloadButton];
        [_downloadButton makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentView.top).offset(20.0);
            make.right.equalTo(_contentView.right);
            make.size.equalTo(CGSizeMake(100.0, 44.0));
        }];
        
        
        _rightView = [[UIView alloc] init];
        _rightView.layer.masksToBounds = NO;
        _rightView.layer.shadowColor = [UIColor blackColor].CGColor;
        _rightView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        _rightView.layer.shadowOpacity = 0.3;
        _rightView.layer.shadowRadius = 1.5;
        [self.view addSubview:_rightView];
        [_rightView makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(kGHRevealRightViewWidth);
            make.top.equalTo(self.view.mas_top);
            make.right.equalTo(self.view.mas_right).offset(kGHRevealRightViewWidth);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        
    }
    return self;
}

#pragma mark - CD Method
- (void)rightButtonPressEvent:(UIButton *)sender
{
    NSLog(@"openDownloadListView");
    [self openRightViewWithAnimation:YES andTime:0.5f completion:^(BOOL finished) {}];
}

- (void)openRightViewWithAnimation:(BOOL)animation andTime:(CGFloat)time completion:(void(^)(BOOL finished))completion
{
    UIView *tapView = [[UIView alloc] init];
    tapView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.2];
    tapView.alpha = 0;
    [tapView addGestureRecognizer:_tapRecogHiddenRightView];
    [self.view addSubview:tapView];
    [tapView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(_rightView.mas_left);
    }];
    [self.view layoutIfNeeded];
    
    [_rightView updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
    }];
    
    [UIView animateWithDuration:time animations:^{
        tapView.alpha = 1.0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}

//- (void)closeRightViewWithAnimation:(BOOL)animation andTime:(CGFloat)time completion:(void(^)(BOOL finished))completion
//{
//    
//}

- (void)hiddenRightView:(UITapGestureRecognizer *)tapGesture
{
    [_rightView updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(kGHRevealRightViewWidth);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
        tapGesture.view.alpha = 0;
    } completion:^(BOOL finished) {
        [tapGesture.view removeFromSuperview];
    }];
}

#pragma mark UIViewController
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
	return (orientation == UIInterfaceOrientationPortraitUpsideDown)
		? (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		: YES;
}

#pragma mark Public Methods
- (void)dragContentView:(UIPanGestureRecognizer *)panGesture {
	CGFloat translation = [panGesture translationInView:self.view].x;
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        _isMoveSlideBar = NO;
    } else if (panGesture.state == UIGestureRecognizerStateChanged) {
		if (_sidebarShowing) {
			if (translation > 0.0f) {
				_contentView.frame = CGRectOffset(_contentView.bounds, kGHRevealSidebarWidth, 0.0f);
				self.sidebarShowing = YES;
			} else if (translation < -kGHRevealSidebarWidth) {
				_contentView.frame = _contentView.bounds;
				self.sidebarShowing = NO;
			} else {
				_contentView.frame = CGRectOffset(_contentView.bounds, (kGHRevealSidebarWidth + translation), 0.0f);
			}
		} else {
			if (translation < 0.0f) {
//				_contentView.frame = _contentView.bounds;
//				self.sidebarShowing = NO;
                
                if (_isMoveSlideBar == NO && fabs(translation) <= kGHRevealRightViewWidth) {
                    [_rightView updateConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self.view.right).offset(kGHRevealRightViewWidth - fabs(translation));
                    }]; //  change  constraint
                }
                
			} else if (translation > kGHRevealSidebarWidth) {
//                _contentView.frame = CGRectOffset(_contentView.bounds, kGHRevealSidebarWidth, 0.0f);
//                self.sidebarShowing = YES;
                
                [_rightView updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.view.right).offset(kGHRevealRightViewWidth);
                }]; //  reset  constraint
			} else {
//				_contentView.frame = CGRectOffset(_contentView.bounds, translation, 0.0f);
                _isMoveSlideBar = YES;
			}
		}
	} else if (panGesture.state == UIGestureRecognizerStateEnded) {
		CGFloat velocity = [panGesture velocityInView:self.view].x;
        if (self.sidebarShowing == YES || _isMoveSlideBar == YES) {
//            BOOL show = (fabs(velocity) > kGHRevealSidebarFlickVelocity)?(velocity > 0):(translation > (kGHRevealSidebarWidth / 2));
//            [self toggleSidebar:show duration:kGHRevealSidebarDefaultAnimationDuration];
        } else {
            if (_rightView.frame.origin.x < self.view.bounds.size.width) {
                BOOL show2 = (fabs(velocity) > kGHRevealSidebarFlickVelocity)? (velocity < 0):(translation <  -(kGHRevealRightViewWidth / 2));
                if (show2) {
                    [self openRightViewWithAnimation:YES andTime:0.25f completion:^(BOOL finished) {}];
                } else {
                    [self hiddenRightView:_tapRecogHiddenRightView];
                }
            } else {
//                BOOL show = (fabs(velocity) > kGHRevealSidebarFlickVelocity)?(velocity > 0):(translation > (kGHRevealSidebarWidth / 2));
//                [self toggleSidebar:show duration:kGHRevealSidebarDefaultAnimationDuration];
            }
        }
	}
}

- (void)toggleSidebar:(BOOL)show duration:(NSTimeInterval)duration {
	[self toggleSidebar:show duration:duration completion:^(BOOL finshed){}];
}

- (void)toggleSidebar:(BOOL)show duration:(NSTimeInterval)duration completion:(void (^)(BOOL finsihed))completion {
    __weak GHRevealViewController *selfRef = self;
	void (^animations)(void) = ^{
		if (show) {
			_contentView.frame = CGRectOffset(_contentView.bounds, kGHRevealSidebarWidth, 0.0f);
//			[_contentView addGestureRecognizer:_tapRecog];
            [selfRef.contentViewController.view setUserInteractionEnabled:NO];
		} else {
			if (self.isSearching) {
				_sidebarView.frame = CGRectMake(0.0f, 0.0f, kGHRevealSidebarWidth, CGRectGetHeight(self.view.bounds));
			} else {
//				[_contentView removeGestureRecognizer:_tapRecog];
			}
			_contentView.frame = _contentView.bounds;
            [selfRef.contentViewController.view setUserInteractionEnabled:YES];
		}
		selfRef.sidebarShowing = show;
	};
	if (duration > 0.0) {
		[UIView animateWithDuration:duration
							  delay:0
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:animations
						 completion:completion];
	} else {
		animations();
		completion(YES);
	}
}

#pragma mark Private Methods
- (void)hideSidebar {
	[self toggleSidebar:NO duration:kGHRevealSidebarDefaultAnimationDuration];
}

@end
