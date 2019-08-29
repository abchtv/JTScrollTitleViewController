[![Version](http://img.shields.io/cocoapods/v/JTScrollTitleViewController.svg)](http://cocoadocs.org/docsets/JTScrollTitleViewController)
[![Issues](http://img.shields.io/github/issues/abchtv/JTScrollTitleViewController.svg)](https://github.com/abchtv/JTScrollTitleViewController/issues?state=open)
[![License](https://img.shields.io/cocoapods/l/JTScrollTitleViewController.svg)](http://cocoadocs.org/docsets/JTScrollTitleViewController)
[![Platform](https://img.shields.io/cocoapods/p/JTScrollTitleViewController.svg)](http://cocoadocs.org/docsets/JTScrollTitleViewController)


# JTScrollTitleViewController
Get a view controller with a title bar which can be scrolled in the top of its view

(关键字：滚动标题，滚动标题栏，滚动，顶部，顶部标题，顶部标题栏)

Author Email address: jorton0105@outlook.com

![img](https://raw.githubusercontent.com/abchtv/JTScrollTitleViewController/master/images/stt-gif02.gif)

## Installation ##

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate JTScrollTitleViewController into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

pod 'JTScrollTitleViewController'
```

Then, run the following command:

```bash
$ pod install
```

### Import to project

To import pod you should add string:

- For `Obj-c` projects:

```obj-c
   #import "JTScrollTitleViewController.h"
```
- For `Swift` projects:

```swift
  import JTScrollTitleViewController
```

## Comment API ##
### JTScrollTitleViewController.h
```obj-c
@interface JTScrollTitleViewController : UIViewController

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
```
## How To Use ##
See the examples.

## Examples ##
### Create a class inherited from JTScrollTitleViewController
```obj-c
#import "JTScrollTitleViewController.h"

@interface JTSimilarHomeViewController : JTScrollTitleViewController

@end
```

### For similar child view controllers

#### 1. Use "JTScrollTitleViewController"

```obj-c
// Only 3 titles Fixed Title
// threshold default is 0 (3 or 4 depending on screen width)
// ScreenWidth < 350 ? 3 : 4
    
NSArray *array = @[@"Title1",@"Title2",@"Title3"];
    
JTSimilarHomeViewController *vc = [JTSimilarHomeViewController scrollTitleViewControllerWithTitles:array withInitializationForChildVCs:^UIViewController *(NSInteger index) {
        JTSimilarSingleViewController *svc = [[JTSimilarSingleViewController alloc]initWithStyle:UITableViewStylePlain];
        svc.title = array[index];
        return svc;
}];
    
[self.navigationController pushViewController:vc animated:YES];
```

#### 2. Use "JTScrollTitleTools" - Recommended

```obj-c
// In your own custom view controller, set the property of JTScrollTitleTools, and initialize it in the method of viewDidLoad

@interface JTSttSimilarViewController ()

@property(strong, nonatomic)JTScrollTitleTools *scrollTitleTools;

@end

@implementation JTSttSimilarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Similar-STT";
    
    NSArray *array = @[@"Title1",@"Title2",@"Title3"];
    self.scrollTitleTools = [JTScrollTitleTools scrollTitleToolsWithVC:self withTitles:array withInitializationForChildVCs:^UIViewController *(NSInteger index) {
        JTSimilarSingleViewController *svc = [[JTSimilarSingleViewController alloc]initWithStyle:UITableViewStylePlain];
        svc.title = array[index];
        return svc;
    }];
    [self.scrollTitleTools setupUI];
}

```

![img](https://raw.githubusercontent.com/abchtv/JTScrollTitleViewController/master/images/stt-gif01.gif)

### For different child view controllers

#### 1. Use "JTScrollTitleViewController"

```obj-c
// Two different types of View Controller(Normal and Table view)
// 6(more than 3 or 4) child view controllers, so the titles can be scrolled.
    
JTDifferentSingleViewController *vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"DifferentSingleViewController"];
vc1.title = @"Normal1";
    
JTSimilarSingleViewController *svc1 = [[JTSimilarSingleViewController alloc]initWithStyle:UITableViewStylePlain];
svc1.title = @"TableView1";
    
JTDifferentSingleViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"DifferentSingleViewController"];
vc2.title = @"Normal2";
    
JTSimilarSingleViewController *svc2 = [[JTSimilarSingleViewController alloc]initWithStyle:UITableViewStylePlain];
svc2.title = @"TableView2";
    
JTDifferentSingleViewController *vc3 =  [self.storyboard instantiateViewControllerWithIdentifier:@"DifferentSingleViewController"];
vc3.title = @"Normal3";
    
JTSimilarSingleViewController *svc3 = [[JTSimilarSingleViewController alloc]initWithStyle:UITableViewStylePlain];
svc3.title = @"TableView3";
    
    
JTDifferentHomeViewController *vc = [JTDifferentHomeViewController scrollTitleViewControllerWithChildVCs:@[vc1,svc1,vc2,svc2,vc3,svc3]];
    
vc.titleViewBgColor = [UIColor cyanColor];
vc.titleViewHeight = 44;
    
vc.barViewColor = [UIColor redColor];
vc.barHeight = 5;
vc.barViewRate = 0.3;
    
vc.labelFont = [UIFont systemFontOfSize:15];
vc.selectedlabelColor = [UIColor redColor];
vc.unselectedlabelColor = [UIColor lightGrayColor];
vc.labelScaleRate = 0.2;
    
[self.navigationController pushViewController:vc animated:YES];
```

#### 2. Use "JTScrollTitleTools" - Recommended

```obj-c

// In your own custom view controller, set the property of JTScrollTitleTools, and initialize it in the method of viewDidLoad

@interface JTSttDifferentViewController ()

@property(strong, nonatomic)JTScrollTitleTools *scrollTitleTools;

@end

@implementation JTSttDifferentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Different-STT";
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    JTDifferentSingleViewController *vc1 = [mainStoryboard instantiateViewControllerWithIdentifier:@"DifferentSingleViewController"];
    vc1.title = @"Normal1";
    
    JTSimilarSingleViewController *svc1 = [[JTSimilarSingleViewController alloc]initWithStyle:UITableViewStylePlain];
    svc1.title = @"TableView1";
    
    JTDifferentSingleViewController *vc2 = [mainStoryboard instantiateViewControllerWithIdentifier:@"DifferentSingleViewController"];
    vc2.title = @"Normal2";
    
    JTSimilarSingleViewController *svc2 = [[JTSimilarSingleViewController alloc]initWithStyle:UITableViewStylePlain];
    svc2.title = @"TableView2";
    
    JTDifferentSingleViewController *vc3 =  [mainStoryboard instantiateViewControllerWithIdentifier:@"DifferentSingleViewController"];
    vc3.title = @"Normal3";
    
    JTSimilarSingleViewController *svc3 = [[JTSimilarSingleViewController alloc]initWithStyle:UITableViewStylePlain];
    svc3.title = @"TableView3";
    
    self.scrollTitleTools = [JTScrollTitleTools scrollTitleToolsWithVC:self withChildVCs:@[vc1,svc1,vc2,svc2,vc3,svc3]];
    
    self.scrollTitleTools.titleViewBgColor = [UIColor cyanColor];
    self.scrollTitleTools.titleViewHeight = 44;
    
    self.scrollTitleTools.barViewColor = [UIColor redColor];
    self.scrollTitleTools.barHeight = 5;
    self.scrollTitleTools.barViewRate = 0.3;
    
    self.scrollTitleTools.labelFont = [UIFont systemFontOfSize:15];
    self.scrollTitleTools.selectedlabelColor = [UIColor redColor];
    self.scrollTitleTools.unselectedlabelColor = [UIColor lightGrayColor];
    self.scrollTitleTools.labelScaleRate = 0.2;
    self.scrollTitleTools.selectedIndex = 2;

    [self.scrollTitleTools setupUI];
}

@end
```


![img](https://raw.githubusercontent.com/abchtv/JTScrollTitleViewController/master/images/stt-gif02.gif)