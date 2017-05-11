//
//  ViedioView.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/17.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "ViedioView.h"


@interface ViedioView()

@property (nonatomic, strong) UIView* topView;//顶部的view
@property (strong, nonatomic)  UILabel *titleLabel;//标题

@property (nonatomic, strong) UIView* downView;//底部防止进度条的view
@property (nonatomic, strong) UIButton *playButton;//播放暂停的button
@property (strong, nonatomic)  UILabel *beginLabel;//开始时间lable
@property (strong, nonatomic)  UILabel *endLabel;//结束时间lable
@property (strong, nonatomic)  UISlider *playProgress;//进度条
@property (strong, nonatomic)  UIProgressView *loadedProgress; // 缓冲进度条
@property (strong, nonatomic)  UIButton *rotationButton;//全屏按钮


@end

@implementation ViedioView{
    BOOL _isIntoBackground; // 是否在后台
    BOOL _isShowToolbar; // 是否显示工具条
    BOOL _isSliding; // 是否正在滑动
    AVPlayerItem *_playerItem;
    AVPlayerLayer *_playerLayer;
    NSTimer *_timer;
    id _playTimeObserver; // 观察者

}


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

#pragma mark -- 懒加载topView
- (UIView *)topView{

    if (!_topView) {
        _topView = [[UIView alloc] init];
        
        _topView.backgroundColor = [UIColor lightGrayColor];
        
        [_topView addSubview:self.titleLabel];
    }

    
    return _topView;
}

- (void)topVIewF{

    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(self);
        make.height.mas_equalTo(MasScale_1080(100));
    }];

}
#pragma mark -- 懒加载 标题

- (UILabel *)titleLabel{

    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        
        _titleLabel.font = [UIFont systemFontOfSize:MasScale_1080(42)];
        
        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.text = @"我是标题";
    }

    return _titleLabel;
}

- (void)titleLableF{


    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(_topView);
        
        make.leading.mas_equalTo(_topView.mas_leading).offset(MasScale_1080(90));
        
    }];
    
}

#pragma mark -- 懒加载 底部view

- (UIView *)downView{
    if (!_downView) {
        _downView = [[UIView alloc] init];
        
        _downView.backgroundColor = [UIColor lightGrayColor];
        
     
    }

    
    return _downView;
}

- (void)downviewF{

    [_downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self);
        make.height.mas_equalTo(MasScale_1080(100));
    }];

}

#pragma mark -- 懒加载 开始时间
- (UILabel *)beginLabel{

    if (!_beginLabel) {
        _beginLabel = [[UILabel alloc] init];
        
        
        _beginLabel.font = [UIFont systemFontOfSize:MasScale_1080(42)];
        
        _beginLabel.textColor = [UIColor whiteColor];
        
        _beginLabel.text = @"00:00";
    }
    
    return _beginLabel;

}

- (void)beginLabelF{

    [_beginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_downView);
        
        make.leading.mas_equalTo(_downView.mas_leading).offset(MasScale_1080(36));
        
        make.width.mas_greaterThanOrEqualTo(MasScale_1080(130));
    }];
    

}

#pragma make --懒加载 playGrogress

- (UISlider *)playProgress{

    if (!_playProgress) {
        _playProgress = [[UISlider alloc] init];
        
        _playProgress.minimumValue = 0;
        
        _playProgress.maximumValue = 1;
        
        [_playProgress addTarget:self action:@selector(playerSliderTouchDown:) forControlEvents:UIControlEventTouchDown];
        
        [_playProgress addTarget:self action:@selector(playerSliderTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        [_playProgress addTarget:self action:@selector(playerSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
       
    }
    
    return _playProgress;

}


- (void)playProgressF{

 [_playProgress mas_makeConstraints:^(MASConstraintMaker *make) {
    

 }];
    

}




#pragma mark -- 懒加载 播放暂停的button

- (UIButton *)playButton{

    if (!_playButton) {
        _playButton = [[UIButton alloc] init];
        
        [_playButton addTarget:self action:@selector(playButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        _playButton.imageView.image = [UIImage imageNamed:@"main_Viedio_play"];
    }

    return _playButton;
}



- (void)playButtonF{

    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.height.mas_equalTo(MasScale_1080(127));

    }];


}

#pragma mark - 按钮的事件

#pragma mark -- 播放暂停事件
- (void)playButtonClicked{
    
    NSLog(@"播放按钮被点击");
    
    if (_isPlaying) {
        [self pause];
    } else {
        [self play];
    }
    
    //    // inspectorAnimation
    //    [self inspectorViewShow];
    
}

#pragma mark -- 滑块事件

- (void)playerSliderTouchDown:(id)sender {
    [self pause];
}

- (void)playerSliderTouchUpInside:(id)sender {
    _isSliding = NO; // 滑动结束
    [self play];
}

// 不要拖拽的时候改变， 手指抬起来后缓冲完成再改变
- (void)playerSliderValueChanged:(id)sender {
    _isSliding = YES;
    
    [self pause];
    // 跳转到拖拽秒处
    // self.playProgress.maxValue = value / timeScale
    // value = progress.value * timeScale
    // CMTimemake(value, timeScale) =  (progress.value, 1.0)
    CMTime changedTime = CMTimeMakeWithSeconds(self.playProgress.value, 1.0);
    NSLog(@"%.2f", self.playProgress.value);
    [_playerItem seekToTime:changedTime completionHandler:^(BOOL finished) {
        // 跳转完成后做某事
    }];
    
}

#pragma mark - setUi

#pragma mark - 加载数据


#pragma mark - delegate

#pragma mark - 实例方法

- (void)removeObserveAndNOtification {
    [_player replaceCurrentItemWithPlayerItem:nil];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [_player removeTimeObserver:_playTimeObserver];
    _playTimeObserver = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 类方法

#pragma mark - 系统方法

- (void)dealloc {
    [self removeObserveAndNOtification];
    [_player removeTimeObserver:_playTimeObserver]; // 移除playTimeObserver
}


@end
