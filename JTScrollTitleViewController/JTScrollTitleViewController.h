//
//  JTScrollTitleViewController.h
//  Hhstu
//
//  Created by Jorton on 16/10/27.
//  Copyright © 2016年 dlrciosdev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTScrollTitleViewController : UIViewController

/**
 *设置顶部标题固定与滑动的阈值
 */
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
 Initializes an `JTScrollTitleViewController` object with similar child view controllers.
 
 @param titles The titles showed in the top scroll bar.
 @param initialization The initialization defined in the block used to initialize child view controllers with their indexes
 
 @return The newly-initialized scroll title view controller
 */
+ (instancetype)scrollTitleViewControllerWithTitles:(NSArray *)titles withInitializationForChildVCs:( UIViewController* (^)(NSInteger index)) initialization;

/**
 Initializes an `JTScrollTitleViewController` object with different child view controllers.
 
 @param viewControllers The viewControllers which will become child view controllers of this scroll title view controller
 
 @return The newly-initialized scroll title view controller
 */
+ (instancetype)scrollTitleViewControllerWithChildVCs:(NSArray *) viewControllers;


@end
