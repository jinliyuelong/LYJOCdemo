//
//  TestCocoDataCtl.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/3.
//  Copyright © 2017年 hand. All rights reserved.
//

#import "TestCocoDataCtl.h"
#import "Person+CoreDataClass.h"
#import "AppDelegate.h"
#import "Person+CoreDataProperties.h"


@interface TestCocoDataCtl ()

@end

@implementation TestCocoDataCtl{

    AppDelegate* app;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    app = ApplicationDelegate;
    NSLog(@"进来数据了");
    
    [self creatButton];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)creatButton{

    NSArray* buttons = @[@"增",@"删",@"改",@"查"];
    
    NSLog(@"创建数据");
    
    for (int i = 0; i < 4 ;i++){
    
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(ScreenWidth * 0.1, 20 + i* 60 , ScreenWidth* 0.8, 40);
        
        [button setTitle:buttons[i] forState:UIControlStateNormal];
        
        [button  addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
        [button setTintColor:SystemColor];
        
        [button setBackgroundColor:[UIColor redColor]];
        
        [button setTitleColor:SystemColor forState:UIControlStateNormal];
        
        
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];

      
    
        
        button.tag = i;
        
        [self.view addSubview:button];
    }

}



- (void)buttonClick:(UIButton* )btn{
    
    
    switch (btn.tag) {
        case 0:
            [self cocodataAdd];
            break;
        case 1:
        
            [self cocodataDelete];
            break;
        case 2:
            [self cocodataUpdate];
            break;
        case 3:
            [self cocodataSerch];
            break;
            
            
        default:
            break;
    }

}


//MARK:增加
- (void)cocodataAdd{
    
   
    
    Person* person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:app.persistentContainer.viewContext];
    
    
    
    NSLog(@"path===%@",app.persistentContainer.accessibilityPath.accessibilityValue);
    person.name = [NSString stringWithFormat:@"测试%d",arc4random()%10];
    
    person.age = arc4random()%10;
    
    NSError *error = nil;
    
  BOOL success =  [app.persistentContainer.viewContext save:&error];
    
    if (!success) {
          NSLog(@"错误信息是%@",[error localizedDescription]);
    }
  
    
    
    

}

//MARK:删除
- (void)cocodataDelete{
    
    //删除制定
    NSEntityDescription* enentity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:app.persistentContainer.viewContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    [request setEntity:enentity];
   
    //设置检索条件
    
    NSPredicate* predic = [NSPredicate predicateWithFormat:@"name = %@",@"测试1"];
    
    [request setPredicate:predic];
    
    NSArray* arrya = [app.persistentContainer.viewContext executeFetchRequest:request error:nil];
  
    if (arrya.count) {
        for (Person* person in arrya) {
            
            [app.persistentContainer.viewContext deleteObject:person];
            
        }
        
        [app.persistentContainer.viewContext save:nil];
        
    }
    
}

//MARK:改
- (void)cocodataUpdate{
    
    NSEntityDescription* enentity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:app.persistentContainer.viewContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    [request setEntity:enentity];
    
    
    //设置检索条件
    
    NSPredicate* predic = [NSPredicate predicateWithFormat:@"name = %@",@"测试2"];
    
    [request setPredicate:predic];
    
    NSArray* arrya = [app.persistentContainer.viewContext executeFetchRequest:request error:nil];
    
    if (arrya.count) {
        for (Person* person in arrya) {
            
            person.name = @"小花";
        }
        
        [app.persistentContainer.viewContext save:nil];
        
    }
    
    
}

//MARK:查
- (void)cocodataSerch{

    NSEntityDescription* enentity = [NSEntityDescription entityForName:@"Person"    inManagedObjectContext:app.persistentContainer.viewContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    [request setEntity:enentity];
    
    // 设置排序（按照age降序）
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    
    NSArray* arrya = [app.persistentContainer.viewContext executeFetchRequest:request error:nil];
    
    
    for (Person* person in arrya) {
         NSLog(@"查出来的数据是%@",person.name);
    }
   
    
    
    
    
}



@end
