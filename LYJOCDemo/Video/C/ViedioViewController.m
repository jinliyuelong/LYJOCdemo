//
//  ViedioViewController.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/16.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "ViedioViewController.h"
#import "ViedioTableViewCell.h"

//这是学习视频的，后期补充

@interface ViedioViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView* tableView;

@end

@implementation ViedioViewController

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
-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        
        
        
        
        _tableView.dataSource = self ;
        
        
        _tableView.delegate = self ;
        
        _tableView.tableFooterView = [[UIView alloc] init];
        
        
        
        
        _tableView.backgroundColor = mybackgroundColor;
        
        _tableView.separatorInset = UIEdgeInsetsZero;
        
        _tableView.estimatedRowHeight = commonCellHeight;
        
        _tableView.rowHeight = UITableViewAutomaticDimension;
        //注册cell VerticalBannerView
        
        
        [_tableView registerClass:[ViedioTableViewCell class] forCellReuseIdentifier:ViedioTableViewCell.cellId];
        
        
        
        
    }
    
    return _tableView;
}

-(void)tableViewF{
    
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}


#pragma mark - 设置UI
- (void)setupUi{
    
    
    [self.view addSubview:self.tableView];
    
    [self tableViewF];
    
}

#pragma makr - 加载数据

#pragma mark  - delegate

#pragma mark  tableViewDelegate

#pragma mark  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViedioTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[ViedioTableViewCell cellId] ];
    
    
    
    
    if (!cell) {
        cell = [[ViedioTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ViedioTableViewCell cellId]];
    }
    
    
    
    return cell;
}




@end
