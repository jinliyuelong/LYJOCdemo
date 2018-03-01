//
//  DemoViewController.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2018/2/27.
//  Copyright © 2018年 liyanjun. All rights reserved.
//

#import "DemoViewController.h"
#import "ViewTableViewCell.h"
#import "FMDBDemo.h"
#import "SqlBuilder.h"
#import "FMDBDemo2.h"

@interface DemoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView* tableView;

@property (nonatomic ,strong)NSMutableArray*dataSource;

@property (nonatomic, strong) FMDBDemo* fMDBDemo;

@property (nonatomic, strong) FMDBDemo2* fMDBDemo2;

@end


@implementation DemoViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUi];
    
    [self loadData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - 懒加载

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        
        
        
        _tableView.dataSource = self ;
        
        
        _tableView.delegate = self ;
        
        _tableView.tableFooterView = [[UIView alloc] init];
        
        
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        
        _tableView.separatorInset = UIEdgeInsetsZero;
        
        _tableView.estimatedRowHeight = MasScale_1080(60);;
        
        _tableView.rowHeight = UITableViewAutomaticDimension;
        //注册cell
        [self.tableView registerClass:[ViewTableViewCell class] forCellReuseIdentifier:ViewTableViewCell.cellId];
        
        
        
        
        
    }
    
    return _tableView;
}

-(void)tableViewF{
    
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (FMDBDemo2 *)fMDBDemo2{
    if (!_fMDBDemo2) {
        _fMDBDemo2 = [[FMDBDemo2 alloc] init];
    }
    return _fMDBDemo2;
}

- (FMDBDemo *)fMDBDemo{
    if (!_fMDBDemo) {
        _fMDBDemo = [[FMDBDemo alloc] init];
    }
    return _fMDBDemo;
}

#pragma mark - 设置UI
- (void)setupUi{
 
    [self.view addSubview:self.tableView];
    
    [self tableViewF];
    
}

- (void)loadData{
    [self.dataSource removeAllObjects];

        [self.dataSource addObject:@"创建表"];
        [self.dataSource addObject:@"创建索引"];
       [self.dataSource addObject:@"创建表并创建索引，失败回滚"];
        [self.dataSource addObject:@"插入TestTable"];
        [self.dataSource addObject:@"查询TestTable"];
        [self.dataSource addObject:@"修改TestTable"];
        [self.dataSource addObject:@"删除TestTable"];
        [self.dataSource addObject:@"dropTestTable"];

    [self.tableView reloadData];
}


- (void)creatTable{
    [self.fMDBDemo creatTable];
}

- (void)creatIndex{
    
    [self.fMDBDemo createIndex:@[@"text1",@"number1"]];
}

- (void)creatTableAndIndex{
    
    NSMutableArray* sqlArraqy = [[NSMutableArray alloc] init];
    
    if (![self.fMDBDemo2 isTableExists]) {
        [SqlBuilder buildCreatTableSql:[self.fMDBDemo2 class]];
        
        [sqlArraqy addObject: [SqlBuilder buildCreatTableSql:[self.fMDBDemo2 class]]];
        
          [sqlArraqy addObject: [SqlBuilder buildcreateIndexSql:[self.fMDBDemo2 class] columns:@[@"test"]]];
        
        [self.fMDBDemo2 executeArraySqls:sqlArraqy];
    }
    
   
    
}

- (void)insetTable{
    self.fMDBDemo.text1 = @"测试";
    self.fMDBDemo.istrul = YES;
    self.fMDBDemo.number1 = 2;
    [self.fMDBDemo insert];
}

- (void)queryTable{
  NSArray* arrya =  [self.fMDBDemo queryWithWhereStr:@"1=1" orderBy:nil];
    
    for (FMDBDemo* demo in arrya) {
        NSLog(@"demo==%@",demo.text1);
    }
}


- (void)updateTable{
    self.fMDBDemo.text1 = @"测试123";
    self.fMDBDemo.istrul = YES;
    self.fMDBDemo.number1 = 2;
    [self.fMDBDemo updateWithWhereStr:@"1=1"];
}

- (void)deleteTable{
    [self.fMDBDemo deleteWithWhereStr:@"1=1"];
}

- (void)dropTable1{
    [self.fMDBDemo dropTable];
}

#pragma mark  - delegate

#pragma mark  tableViewDelegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了tableView的第%ld行",(long)indexPath.row);
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    switch (indexPath.row) {
        case 0:
            [self creatTable];
            break;
           case 1:
            [self creatIndex];
            break;
        case 2:
            [self creatTableAndIndex];
            break;
        case 3:
            [self insetTable];
            break;
        case 4:
            [self queryTable];
            break;
        case 5:
            [self updateTable];
            break;
        case 6:
            [self deleteTable];
            break;
        case 7:
            [self dropTable1];
            break;
        default:
            break;
    }
    
    
    
    
}




#pragma mark  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    ViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ViewTableViewCell cellId] ];
    
    
    if (!cell) {
        cell = [[ViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ViewTableViewCell cellId]];
    }
    
    
    [cell databind:self.dataSource[indexPath.row]];
    
    return cell;
    
    
    
}




@end
