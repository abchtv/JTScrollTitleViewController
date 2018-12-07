//
//  JTSttDifferentViewController.m
//  JTScrollTitleViewControllerSample
//
//  Created by User on 2018/12/7.
//  Copyright © 2018 abchtv. All rights reserved.
//

#import "JTSttDifferentViewController.h"

#import "JTScrollTitleTools.h"
#import "JTSimilarSingleViewController.h"
#import "JTDifferentSingleViewController.h"

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

    [self.scrollTitleTools setupUI];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
