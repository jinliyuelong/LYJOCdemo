//
//  ViewTableViewCell.h
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/2.
//  Copyright © 2017年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewTableViewCell : UITableViewCell



-(void)databind:(NSString*)title;

+ (NSString*) cellId;
@end
