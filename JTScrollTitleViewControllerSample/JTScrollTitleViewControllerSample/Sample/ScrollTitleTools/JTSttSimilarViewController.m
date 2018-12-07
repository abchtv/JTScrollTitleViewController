//
//  JTSttSimilarViewController.m
//  JTScrollTitleViewControllerSample
//
//  Created by User on 2018/12/7.
//  Copyright © 2018 abchtv. All rights reserved.
//

#import "JTSttSimilarViewController.h"

#import "JTScrollTitleTools.h"
#import "JTSimilarSingleViewController.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
