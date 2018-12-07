//
//  JTScrollTitleTools.h
//  JTScrollTitleViewControllerSample
//
//  Created by User on 2018/12/7.
//  Copyright © 2018 abchtv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTScrollTitleViewController.h"

@interface JTScrollTitleTools : NSObject

@property(assign, nonatomic) NSInteger threshold;// default is 0 (3 or 4 depending on screen width)

@property(strong, nonatomic) UIColor *titleViewBgColor;// default is nil (Grey)
@property(assign, nonatomic) NSInteger titleViewHeight;// default is 36

@property(strong, nonatomic) UIColor *barViewColor;// default is nil (Orange)
@property(assign, nonatomic) CGFloat barHeight;// default is 3 must less than titleViewHeight
@property(assign, nonatomic) CGFloat barViewRate; // default is 0.7

@property(strong, nonatomic) UIFont *labelFont;// default is nil [UIFont systemFontOfSize:13]
@property(strong, nonatomic) UIColor *selectedlabelColor;// default is nil (Dark gray)
@property(strong, nonatomic) UIColor *unselectedlabelColor;// default is nil (Light gray)
@property(assign, nonatomic) CGFloat labelScaleRate;// default is 0.1

@property(assign, nonatomic) BOOL disallowContentScroll;//default is NO

/**
 Initializes an `JTScrollTitleTools` object with similar child view controllers.
 
 @param vc The target view controller
 @param titles The titles showed in the top scroll bar.
 @param initialization The initialization defined in the block used to initialize child view controllers with their indexes
 
 @return The newly-initialized scroll title view controller
 */
+ (instancetype)scrollTitleToolsWithVC:(UIViewController *)vc withTitles:(NSArray *)titles withInitializationForChildVCs:(UIViewController *(^)(NSInteger index))initialization;
/**
 Initializes an `JTScrollTitleTools` object with different child view controllers.
 
 @param vc The target view controller
 @param viewControllers The viewControllers which will become child view controllers of this scroll title view controller
 
 @return The newly-initialized scroll title view controller
 */
+ (instancetype)scrollTitleToolsWithVC:(UIViewController *)vc withChildVCs:(NSArray *) viewControllers;

- (void)setupUI;

@end

