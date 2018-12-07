//
//  JTScrollTitleTools.m
//  JTScrollTitleViewControllerSample
//
//  Created by User on 2018/12/7.
//  Copyright © 2018 abchtv. All rights reserved.
//

#define UIColorFromRGBAlpha(rgbValue,alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define MyTitleViewBgColor UIColorFromRGBAlpha(0xF2F2F2, 1.f)
#define MyBarViewColor UIColorFromRGBAlpha(0xFD9F20, 1.f)

#import "JTScrollTitleTools.h"
#import "JTScrollTitleLabel.h"

@interface JTScrollTitleTools ()<UIScrollViewDelegate>

@property(weak, nonatomic) UIScrollView *titleScrollView;
@property(weak, nonatomic) UIScrollView *contentScrollView;

@property(strong, nonatomic) UIView *barView;
@property(assign, nonatomic) CGFloat labelW;
@property(strong, nonatomic) NSArray *titleList;
@property(strong, nonatomic) UIViewController* (^initialization)(NSInteger);
@property(strong, nonatomic) NSArray *viewControllers;

@property(strong, nonatomic) UIViewController *viewController;

@end

@implementation JTScrollTitleTools

- (instancetype)initWithVC:(UIViewController *)vc withTitles:(NSArray *)titles withInitializeChildVcBlock:(UIViewController *(^)(NSInteger index))initialization {
    if (self = [super init]) {
        _titleList =  [NSArray arrayWithArray:titles];
        self.initialization = initialization;
        self.viewController = vc;
    }
    return self;
}

- (instancetype)initWithVC:(UIViewController *)vc withChildVCs:(NSArray *) viewControllers{
    if (self = [super init]) {
        self.viewController = vc;
        self.viewControllers = [NSArray arrayWithArray:viewControllers];
    }
    return self;
}

+ (instancetype)scrollTitleToolsWithVC:(UIViewController *)vc withTitles:(NSArray *)titles withInitializationForChildVCs:(UIViewController *(^)(NSInteger index))initialization {
    return [[self alloc]initWithVC:vc withTitles:titles withInitializeChildVcBlock:initialization];
}

+ (instancetype)scrollTitleToolsWithVC:(UIViewController *)vc withChildVCs:(NSArray *) viewControllers {
    return [[self alloc]initWithVC:vc withChildVCs:viewControllers];
}


- (void)setupUI {
    self.viewController.edgesForExtendedLayout = UIRectEdgeNone;
    self.viewController.extendedLayoutIncludesOpaqueBars = NO;
    self.viewController.automaticallyAdjustsScrollViewInsets = NO;
    
    self.titleViewHeight = self.titleViewHeight ? self.titleViewHeight : 36;
    self.barHeight = self.barHeight ? self.barHeight : 3;
    
    self.viewController.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, _titleViewHeight)];
    _titleScrollView = titleScroll;
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _titleScrollView.showsVerticalScrollIndicator = NO;
    
    [self.viewController.view addSubview:_titleScrollView];
    
    CGFloat extraHeight;
    
    extraHeight = self.viewController.navigationController ? 64 : 20;
    
    UIScrollView *contentScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _titleViewHeight, ScreenWidth, ScreenHeight - extraHeight - _titleViewHeight)];
    _contentScrollView = contentScroll;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.showsVerticalScrollIndicator = NO;
    
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    _contentScrollView.scrollEnabled = !_disallowContentScroll;
    
    [self.viewController.view addSubview:_contentScrollView];
    
    [self setupChildViewControllers];
    [self setupTitles];
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

- (void)setupChildViewControllers {
    if (!self.viewControllers) {
        for (NSInteger i = 0; i < self.titleList.count; i++) {
            UIViewController *vc = _initialization(i);
            [self.viewController addChildViewController:vc];
        }
    }else{
        for (NSInteger i = 0; i < self.viewControllers.count; i++) {
            [self.viewController addChildViewController:self.viewControllers[i]];
        }
    }
}

- (void)setupTitles {
    NSInteger threshold = self.threshold ? self.threshold : ScreenWidth < 350 ? 3 : 4;
    
    self.titleScrollView.backgroundColor = self.titleViewBgColor ? self.titleViewBgColor : MyTitleViewBgColor ;
    
    NSInteger titleCount = self.viewControllers ? self.viewControllers.count : self.titleList.count;
    
    self.titleScrollView.scrollEnabled = titleCount <= threshold ? NO : YES;
    
    CGFloat labelW = titleCount <= threshold ? ScreenWidth/titleCount  : 100;
    self.labelW = labelW;
    CGFloat labelY = 0;
    CGFloat labelH = self.titleScrollView.frame.size.height;
    
    for (NSInteger i = 0; i < titleCount ; i++) {
        
        JTScrollTitleLabel *label = [[JTScrollTitleLabel alloc] init];
        label.unselectedlabelColor = self.unselectedlabelColor;
        label.selectedlabelColor = self.selectedlabelColor;
        label.labelFont = self.labelFont;
        label.labelScaleRate = self.labelScaleRate;
        
        label.text = self.viewControllers ? [self.viewController.childViewControllers[i] title] : self.titleList[i];
        
        CGFloat labelX = i * labelW;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        label.tag = i;
        [self.titleScrollView addSubview:label];
        
        if (i == 0)label.scale = 1.0;
    }
    
    CGFloat barViewRate = self.barViewRate ? self.barViewRate : 0.7;
    
    self.barView = [[UIView alloc]initWithFrame:CGRectMake((1 - barViewRate) * labelW * 0.5, labelH - self.barHeight, labelW * barViewRate, self.barHeight)];
    self.barView.backgroundColor = self.barViewColor ? self.barViewColor : MyBarViewColor;
    [self.titleScrollView addSubview:self.barView];
    
    self.titleScrollView.contentSize = titleCount <= threshold ? CGSizeMake(ScreenWidth, 0) : CGSizeMake(titleCount * labelW, 0);
    self.contentScrollView.contentSize = CGSizeMake(titleCount * ScreenWidth, 0);
}

- (void)labelClick:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag;
    
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * self.contentScrollView.frame.size.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger index = offsetX / width;
    
    JTScrollTitleLabel *label = self.titleScrollView.subviews[index];
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    titleOffset.x = label.center.x - width * 0.5;
    
    if (titleOffset.x < 0) titleOffset.x = 0;
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    
    for (NSInteger i = 0; i < self.titleScrollView.subviews.count - 1 ; i++) {
        JTScrollTitleLabel *otherLabel = self.titleScrollView.subviews[i];
        if (otherLabel != label) otherLabel.scale = 0.0;
    }
    
    UIViewController *willShowVc = self.viewController.childViewControllers[index];
    
    if ([willShowVc isViewLoaded]) return;
    
    willShowVc.view.frame = CGRectMake(offsetX, 0, width, height);
    [scrollView addSubview:willShowVc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (scale < 0 || scale > self.titleScrollView.subviews.count - 2){
        self.contentScrollView.scrollEnabled = NO;
        return;
    }else{
        self.contentScrollView.scrollEnabled = YES;
    }
    
    self.barView.transform = CGAffineTransformMakeTranslation(scale * self.labelW, 0);
    
    NSInteger leftIndex = scale;
    JTScrollTitleLabel *leftLabel = self.titleScrollView.subviews[leftIndex];
    
    NSInteger rightIndex = leftIndex + 1;
    JTScrollTitleLabel *rightLabel = (rightIndex == self.titleScrollView.subviews.count - 1) ? nil : self.titleScrollView.subviews[rightIndex];
    
    CGFloat rightScale = scale - leftIndex;
    CGFloat leftScale = 1 - rightScale;
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
}



@end
