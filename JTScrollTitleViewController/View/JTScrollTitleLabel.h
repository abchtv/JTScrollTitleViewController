//
//  JTScrollTitleLabel.h
//  Hhstu
//
//  Created by Jorton on 16/8/24.
//  Copyright © 2016年 dlrciosdev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTScrollTitleLabel : UILabel

@property(nonatomic, assign) CGFloat scale;

@property(strong, nonatomic) UIFont *labelFont;// default is nil [UIFont systemFontOfSize:13]

@property(strong, nonatomic) UIColor *unselectedlabelColor;// default is nil (Light gray)
@property(strong, nonatomic) UIColor *selectedlabelColor;// default is nil (Dark gray)

@property(assign, nonatomic) CGFloat labelScaleRate;// default is 0.1

@end
