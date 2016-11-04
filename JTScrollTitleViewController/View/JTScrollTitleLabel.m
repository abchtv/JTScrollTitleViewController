//
//  JTScrollTitleLabel.m
//  Hhstu
//
//  Created by Jorton on 16/8/24.
//  Copyright © 2016年 dlrciosdev. All rights reserved.
//

#import "JTScrollTitleLabel.h"

@implementation JTScrollTitleLabel

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}


- (void)setScale:(CGFloat)scale {
    _scale = scale;

    self.font = self.labelFont ? self.labelFont : [UIFont systemFontOfSize:13];
    
    CGFloat defaultRed = 170/255.f;
    CGFloat defaultGreen = 170/255.f;
    CGFloat defaultBlue = 170/255.f;
 
    CGFloat changeRed = 43/255.f;
    CGFloat changeGreen = 43/255.f;
    CGFloat changeBlue = 43/255.f;
    
    if (self.unselectedlabelColor) {
        CGFloat components[3];
        [self getRGBComponents:components forColor:self.unselectedlabelColor];
        defaultRed = components[0];
        defaultGreen = components[1];
        defaultBlue = components[2];
    }
    
    if (self.selectedlabelColor) {
        CGFloat components[3];
        [self getRGBComponents:components forColor:self.selectedlabelColor];
        changeRed = components[0];
        changeGreen = components[1];
        changeBlue = components[2];
    }
    
    CGFloat red = defaultRed + (changeRed - defaultRed) * scale;
    CGFloat green = defaultGreen + (changeGreen - defaultGreen) * scale;
    CGFloat blue = defaultBlue + (changeBlue - defaultBlue) * scale;
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    CGFloat scaleRate = self.labelScaleRate ? self.labelScaleRate : 0.1;
    
    CGFloat transformScale = 1 + scale * scaleRate; 
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}

- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
}

@end
