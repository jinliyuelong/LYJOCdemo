//
//  AppDelegate.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/2.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "AppDelegate.h"
#import "TSStorageManager.h"
#import "ViewController.h"
#import "BaseUINavigationController.h"

#import "iflyMSC/iflyMSC.h"

#define APPID_VALUE           @"58cf37c5"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
   
    //设置bar的颜色
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    //    UIImage *navbar = [UIImage imageNamed:@"NavBar"];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        
        //        [[UINavigationBar appearance] setBackgroundImage:navbar forBarMetrics:UIBarMetricsDefault];
        [UINavigationBar appearance].barTintColor = SystemColor;
        
        //        [[UINavigationBar appearance] setTintColor:RGB(54, 100, 173)];
        
    } else {
        [UINavigationBar appearance].barTintColor = SystemColor;
        
       
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        
        
        
    }
    
    
    [self onBaseContextWillStartupWithOptions:launchOptions]; //程序启动，还没有加载 RootViewController。
    
    
      ViewController *indexCtrl = [[ViewController alloc] init];
     BaseUINavigationController *nav = [[BaseUINavigationController alloc] initWithRootViewController:indexCtrl];
     self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    return YES;
}


//加载一些配置文件
- (void)onBaseContextWillStartupWithOptions:(NSDictionary *)launchOptions{

     [[TSStorageManager sharedStorageManager] open];//初始化本地数据库
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"LYJOCDemo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                
                NSLog(@"路径是%@",_persistentContainer.name);
                
                if (error != nil) {
                    
                    
                  
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
