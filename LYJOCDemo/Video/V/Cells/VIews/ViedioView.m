//
//  ViedioView.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/17.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "ViedioView.h"
#import <AVFoundation/AVFoundation.h>

@interface ViedioView()

@property (nonatomic, strong)AVPlayer *aVPlayer;//核心播放器

@property (nonatomic, strong)UIButton *playOrPause;//播放暂停

@end

@implementation ViedioView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        [self initialization];
    }
    
    return self;
    
    
}
- (instancetype)init{
    self = [super init];
    if(self){
        
        [self initialization];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        
        [self initialization];
    }
    
    return self;
    
}

- (void)initialization
{
    
    
}

#pragma mark - 懒加载

#pragma mark - setUi

#pragma mark - 加载数据

#pragma mark - delegate

#pragma mark - 实例方法

#pragma mark - 类方法

@end
