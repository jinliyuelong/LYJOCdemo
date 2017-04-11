//
//  TopSlideNavViewController.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/17.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "TopSlideNavViewController.h"
#import "LYJTopSlideNavView.h"

@interface TopSlideNavViewController ()

@property (nonatomic, strong)LYJTopSlideNavView* lYJTopSlideNavView;

@end

@implementation TopSlideNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    
    [self setupUi];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 懒加载

- (LYJTopSlideNavView *)lYJTopSlideNavView{


    if (!_lYJTopSlideNavView) {
        _lYJTopSlideNavView = [[LYJTopSlideNavView alloc] init];
        
        _lYJTopSlideNavView.backgroundColor = [UIColor yellowColor];
        
        
        
      
        NSMutableArray* array = [[NSMutableArray alloc] init];
        
        [array addObject:[[LYJTopSlideModel alloc] initWithtextStr:@"首页" isSelectTed:YES]];
        
        
        
        [array addObject:[[LYJTopSlideModel alloc] initWithtextStr:@"体育" isSelectTed:NO]];
        
        
        [array addObject:[[LYJTopSlideModel alloc] initWithtextStr:@"新闻联播" isSelectTed:NO]];
        
        [array addObject:[[LYJTopSlideModel alloc] initWithtextStr:@"财经" isSelectTed:NO]];
        
        
        
        
       
      

        
        [_lYJTopSlideNavView dataBind:array];
        
      
        
    }
    
    return _lYJTopSlideNavView;
}


- (void) lYJTopSlideNavViewF{



    [_lYJTopSlideNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self.view);
        
        make.height.mas_equalTo(MasScale_1080(150));
    }];
    
}


#pragma mark - setUi

- (void)setupUi{


    
    
    [self.view addSubview:self.lYJTopSlideNavView];
    
    [self lYJTopSlideNavViewF];
    
    
    self.view.backgroundColor = [UIColor redColor];
    
}


#pragma mark - 加载数据

#pragma mark - delegate

#pragma mark - 实例方法

#pragma mark - 类方法


@end
