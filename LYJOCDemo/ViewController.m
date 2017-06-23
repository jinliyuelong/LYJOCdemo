//
//  ViewController.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/2.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "ViewController.h"
#import "ViewTableViewCell.h"
#import "TestCocoDataCtl.h"
#import "VerticalBannerViewController.h"
#import "KeDaXunFeiViewController.h"
#import "TopSlideNavViewController.h"
#import "AVViewController.h"
#import "RSAViewController.h"//加密

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) NSArray* controllers;
@property(strong,nonatomic) UITableView* tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self setupUI];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 懒加载一些数据



- (NSArray* )controllers {

    if (!_controllers) {
        _controllers = @[[[TestCocoDataCtl alloc] initWithTitle:@"Cocodata"],
                         [[VerticalBannerViewController alloc] initWithTitle:@"垂直轮播"],
                          [[KeDaXunFeiViewController alloc] initWithTitle:@"科大讯飞语音搜索"],
                         [[TopSlideNavViewController alloc] initWithTitle:@"LYJTopSlideNav"],
                         [[AVViewController alloc] initWithTitle:@"AVPLAYER"],
                         
                         [[RSAViewController alloc] initWithTitle:@"RSA"],
                         
                         
                         ];;
        
    }
    
    return _controllers;

    
}

- (UITableView* )tableView {


    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        [self setTableViewP];
    }
    
    return _tableView;
}


#pragma mark 设置tableView属性

- (void)addTableView {

    [self.view addSubview:self.tableView];
    
    [self setTableViewF];
    
}

- (void)setTableViewP {

    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    _tableView.tableFooterView = [[UIView alloc] init];
    
    _tableView.backgroundColor = mybackgroundColor;
    
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _tableView.estimatedRowHeight = commonCellHeight;
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    //注册cell
    
    [_tableView registerClass:[ViewTableViewCell class] forCellReuseIdentifier:ViewTableViewCell.cellId];

}



- (void)setTableViewF {
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

}


#pragma mark 设置ui

- (void)setupUI{

    [self addTableView];

}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.controllers.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{


    return  1;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ViewTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[ViewTableViewCell cellId] forIndexPath:indexPath];
    
    UIViewController *viewController = self.controllers[indexPath.row];
    
    
    
    if (!cell) {
        cell = [[ViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ViewTableViewCell cellId]];
    }
    
    [cell databind:viewController.title];
    
    
    return cell;
}



#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController = self.controllers[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}




@end

