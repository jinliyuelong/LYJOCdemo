//
//  BaseUINavigationController.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2018/2/27.
//  Copyright © 2018年 liyanjun. All rights reserved.
//

#import "BaseUINavigationController.h"

@interface BaseUINavigationController ()

@end

@implementation BaseUINavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}


+ (instancetype)navigationWithRootViewController:(UIViewController *)viewController {
    return [[[self class] alloc] initWithRootViewController:viewController];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count>0){
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        [back setImage:[UIImage imageNamed:@"white_back"] forState:UIControlStateNormal];
        back.size = CGSizeMake(25, 25);
        back.contentMode = UIViewContentModeLeft;
        back.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        //        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        //        flexItem.width = -7;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)backAction:(UIButton *)btn{
    
    [self popViewControllerAnimated:YES];
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
