//
//  ViewController.m
//  JTScrollTitleViewControllerSample
//
//  Created by Jorton on 2016/11/2.
//  Copyright © 2016年 abchtv. All rights reserved.
//

#import "ViewController.h"
#import "JTSimilarHomeViewController.h"
#import "JTSimilarSingleViewController.h"
#import "JTDifferentHomeViewController.h"
#import "JTDifferentSingleViewController.h"
#import "JTScrollTitleTools.h"
#import "JTSttSimilarViewController.h"
#import "JTSttDifferentViewController.h"

@interface ViewController ()

@property(strong, nonatomic)JTScrollTitleTools *scrollTitleTools;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)similar {
    
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
}

- (IBAction)different {
    
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
}


- (IBAction)similarWithTools:(UIButton *)sender {
    JTSttSimilarViewController *vc = [JTSttSimilarViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)differentWithTools:(UIButton *)sender {
    // Two different types of View Controller(Normal and Table view)
    // 6(more than 3 or 4) child view controllers, so the titles can be scrolled.
    JTSttDifferentViewController *vc = [JTSttDifferentViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
