//
//  JTDifferentSingleViewController.m
//  JTScrollTitleViewControllerSample
//
//  Created by Jorton on 2016/11/3.
//  Copyright © 2016年 abchtv. All rights reserved.
//

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#import "JTDifferentSingleViewController.h"

@interface JTDifferentSingleViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;

@end

@implementation JTDifferentSingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = randomColor;
    self.mainLabel.text = self.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
