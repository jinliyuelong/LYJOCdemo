//
//  ViedioView.h
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/17.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface ViedioView : UIView

// AVPlayer 控制视频播放
@property (nonatomic, strong) AVPlayer *player;

// 播放状态
@property (nonatomic, assign) BOOL isPlaying;

// 是否横屏
@property (nonatomic, assign) BOOL isLandscape;


// 传入视频地址
- (void)updatePlayerWithURL:(NSURL *)url;

// 移除通知
- (void)removeObserveAndNOtification;

// 切换为横屏
- (void)setLandscapeLayout;

// 切换为竖屏
- (void)setProtraitLayout;

// 播放
- (void)play;

// 暂停
- (void)pause;

@end
