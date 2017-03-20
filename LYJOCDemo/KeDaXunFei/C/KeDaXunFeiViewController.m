//
//  KeDaXunFeiViewController.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/20.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "KeDaXunFeiViewController.h"
#import <MBProgressHUD.h>
#import "iflyMSC/IFlyMSC.h"
#import "LCVoiceHud.h"
#import "IATConfig.h"
#import "ISRDataHelper.h"

#define TOPRIGHTTAG  1000//头部搜索的按钮

@interface KeDaXunFeiViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate,IFlySpeechRecognizerDelegate,IFlyPcmRecorderDelegate,IFlyRecognizerViewDelegate>



@property (nonatomic, strong) MBProgressHUD     *progressHUD;//等待控件

@property (strong, nonatomic) UIImageView *iamgeViewPassWorld;//左边图片

@property (strong, nonatomic) UIButton * rightButtonPassWorld;//搜索框右边按钮

@property (strong, nonatomic) UIView *headContainerView;//包含搜索框、地址、邮件图标的view

@property (nonatomic,strong) UITextField * textFieldSearchKey;//搜索框

@property (strong, nonatomic) UIView *viewkeDaXunfei;  //科大讯飞


//语音识别
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;//不带界面的识别对象
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象

@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;//录音器，用于音频流识别的数据传入

//@property (nonatomic, strong) PopupView *popUpView;

@property (nonatomic, strong) NSString * result;



@property (nonatomic, assign) BOOL isCanceled;
@property (nonatomic,assign) BOOL isStreamRec;//是否是音频流识别
@property (nonatomic,assign) BOOL isBeginOfSpeech;//是否返回BeginOfSpeech回调


@property (nonatomic, strong) LCVoiceHud * voiceHud_;//显示语音的hud

@end

@implementation KeDaXunFeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUi];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma setupUi

- (void)setupUi{

    [self.view addSubview:self.headContainerView];
    
    [self.view addSubview:self.viewkeDaXunfei];
    
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    
//    [self headContainerViewSubViewsF];
    
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification{
    
    CGRect frame = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.viewkeDaXunfei.top = ScreenHeight - frame.size.height - self.viewkeDaXunfei.height - self.navigationController.navigationBar.height - [[UIApplication sharedApplication] statusBarFrame].size.height;
}


//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
    
    self.viewkeDaXunfei.top = self.view.bottom;
}

#pragma mark --获取headContainerView 懒加载

- (UIView *)headContainerView{
    
    if (!_headContainerView) {
        _headContainerView = [[UIView alloc] init];
        
        _headContainerView.frame = [UIView getFrame_x_1080:0 y:0 width:MasScale_1080(1080) height:MasScale_1080(140)];
        
        _headContainerView.backgroundColor = SystemColor;
        
        
        
        [_headContainerView addSubview:self.textFieldSearchKey];
        
        
        
        
        
        [self headContainerViewSubViewsF];
    }
    
    
    return _headContainerView;
}


- (void)headContainerViewSubViewsF{
    
    [self textFieldSearchKeyF];
    
   
}



- (UIView *)viewkeDaXunfei{

    if (!_viewkeDaXunfei) {
        
        _viewkeDaXunfei = [[UIView alloc] init];
        
        _viewkeDaXunfei.frame = [UIView getFrame_x_1080:0 y:self.view.bottom  width:MasScale_1080(1080) height:MasScale_1080(130)];
       
        
        _viewkeDaXunfei.backgroundColor = [UIColor redColor];
        
        
       
        
        
        UIButton *btnFunctionTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        btnFunctionTitle.size = [UIView getSize_width:250 height:250*51/340];
        btnFunctionTitle.origin = [UIView getPoint_x:(self.viewkeDaXunfei.width - btnFunctionTitle.width)/2 y:(self.viewkeDaXunfei.height - btnFunctionTitle.height)/2];
        
    
          //[btnFunctionTitle addTarget:self action:@selector(keDaXunfeiClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnFunctionTitle setBackgroundImage:[UIImage imageNamed:@"keda_xunfei"] forState:UIControlStateNormal];
        [_viewkeDaXunfei addSubview:btnFunctionTitle];
        
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressBtn:)];
        [longPressGesture setDelegate:self];
        longPressGesture.minimumPressDuration = 0.2;//默认0.5秒
        [btnFunctionTitle addGestureRecognizer:longPressGesture];
        
        
        

    }
    
    return _viewkeDaXunfei;

}


#pragma mark  --懒加载  搜索框
-(UITextField *)textFieldSearchKey{
    
    if (!_textFieldSearchKey) {
        _textFieldSearchKey = [[UITextField alloc] init];
        
        //        UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 36, 20)];
        
        UIView * leftView = [[UIView alloc] init];
        
        
        leftView.frame = [UIView getFrame_x_1080:0 y:0 width:MasScale_1080(86) height:MasScale_1080(78)];
        
        
        
        //        UIImageView * iamgeViewPassWorld = [[UIImageView alloc]initWithFrame:CGRectMake(9, 1, 18, 18)];
        
        self.iamgeViewPassWorld = [[UIImageView alloc] init];
        
        
        self.iamgeViewPassWorld.frame = [UIView getFrame_x_1080:MasScale_1080(22) y:MasScale_1080(18) width:MasScale_1080(42) height:MasScale_1080(42)];
        
        
        self.iamgeViewPassWorld.image = [UIImage imageNamed:@"main_chaobiao_seach_left"];
        [leftView addSubview:self.iamgeViewPassWorld];
        
        
        
        
        UIView * rightView = [[UIView alloc] init];
        
        rightView.frame = [UIView getFrame_x_1080:0 y:0 width:MasScale_1080(64) height:MasScale_1080(78)];
        
        
        //
        //        UILabel *lableVertical = [[UILabel alloc] init];
        //
        //        lableVertical.size = [UIView getSize_width:0.5 height:rightView.height];
        //        lableVertical.origin = [UIView getPoint_x:0 y:0];
        //        lableVertical.backgroundColor = defaultZJGrayColor;
        //        [rightView addSubview:lableVertical];
        //
        self.rightButtonPassWorld = [[UIButton alloc] init];
        
        
        self.rightButtonPassWorld .frame = [UIView getFrame_x_1080:0 y:MasScale_1080(18) width:MasScale_1080(27) height:MasScale_1080(48)];
        
        
        [self.rightButtonPassWorld  setBackgroundImage:[UIImage imageNamed:@"main_chaobiao_seach_right"] forState:UIControlStateNormal];
        self.rightButtonPassWorld .tag = TOPRIGHTTAG;
        [self.rightButtonPassWorld  addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [rightView addSubview:self.rightButtonPassWorld ];
        
        
        _textFieldSearchKey.leftView = leftView;
        _textFieldSearchKey.rightView = rightView;
        //        _textFieldSearchKey.placeholder = @"请输入搜索关键词";
        
        _textFieldSearchKey.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textFieldSearchKey.leftViewMode = UITextFieldViewModeAlways;
        _textFieldSearchKey.rightViewMode = UITextFieldViewModeAlways;
        _textFieldSearchKey.delegate = self;
        //        _textFieldSearchKey.layer.borderWidth = 0.5;
        _textFieldSearchKey.layer.cornerRadius = 11;
        //        _textFieldSearchKey.layer.borderColor = defaultLineColor.CGColor;
        _textFieldSearchKey.returnKeyType = UIReturnKeySearch;
        _textFieldSearchKey.font = [UIFont systemFontOfSize:MasScale_1080(42)];
        
        NSString* placeHolder = @"请输入搜索关键词";
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:placeHolder];
        
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:[UIColor whiteColor]
                        range:NSMakeRange(0, placeHolder.length)];
        
        _textFieldSearchKey.attributedPlaceholder =  attrStr;
        
        
        
        _textFieldSearchKey.backgroundColor =  RGBA(255, 255, 255, 0.7);
    }
    
    return _textFieldSearchKey;
    
}

-(void)textFieldSearchKeyF{
    
    [_textFieldSearchKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_headContainerView);
        
        make.height.mas_equalTo(MasScale_1080(78));
        
        make.top.mas_equalTo(_headContainerView.mas_top).offset(MasScale_1080(22));
        make.width.mas_equalTo(MasScale_1080(532));
        
    }];
    
}


#pragma mark - 其他


#pragma mark - Helper Function

-(void) showVoiceHudOrHide:(BOOL)yesOrNo{
    
    if (_voiceHud_) {
        [_voiceHud_ hide];
        _voiceHud_ = nil;
    }
    
    if (yesOrNo) {
        
        _voiceHud_ = [[LCVoiceHud alloc] init];
        [_voiceHud_ show];
    }else{
        
    }
    
}


-(void)longPressBtn:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        
        //长按事件开始"
        //do something
        
        
        NSLog(@"长按事件开始");
        
        [self showVoiceHudOrHide:YES];
        
        
        [self keDaXunfeiClick:nil];  //开始录音
    }
    else if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) {
        
        [self showVoiceHudOrHide:NO];
        
        //长按事件结束
        //do something
        NSLog(@"长按事件结束");
        
        
        NSLog(@"%s",__func__);
        
        if(self.isStreamRec && !self.isBeginOfSpeech){
            NSLog(@"%s,停止录音",__func__);
            [_pcmRecorder stop];
            //[_popUpView showText: @"停止录音"];
        }
        
        [_iFlySpeechRecognizer stopListening];

        
    }
}



- (BOOL)createHUD{  //alloc一个等待控件出来
    
    if (_progressHUD){
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.navigationController.view addSubview:_progressHUD];
    return YES;
}

- (void)showFaliureHUD:(NSString *)message{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        if(message != nil && message.trim.length > 0){
            [self createHUD];
            _progressHUD.mode = MBProgressHUDModeCustomView;
            _progressHUD.detailsLabel.text = message;
            
            [_progressHUD showAnimated:YES];
            [_progressHUD hideAnimated:YES afterDelay:1.5];
    
        }
        
    });
    
}


#pragma mark - 界面上按钮的点击

-  (void)btnClicked:(UIButton *)btn{
    
    switch (btn.tag) {
        case TOPRIGHTTAG:
            NSLog(@"顶部搜索被点击");
            break;
     
        default:
            break;
    }
    
    
}
-(void)keDaXunfeiClick:(UIButton*)btn{
    
    NSLog(@"启动科大讯飞。。。。");
    
    
    //点击语音按钮的时候，清空上一次语音的内容
    
    self.textFieldSearchKey.text = @"";
    
    NSLog(@"%s[IN]",__func__);
    
    if ([IATConfig sharedInstance].haveView == NO) {//无界面
        
        //        [_textView setText:@""];
        //        [_textView resignFirstResponder];
        
        self.isCanceled = NO;
        self.isStreamRec = NO;
        
        
        if(_iFlySpeechRecognizer == nil)
        {
            [self initRecognizer];
        }
        
        [_iFlySpeechRecognizer cancel];
        
        //设置音频来源为麦克风
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        //设置听写结果格式为json
        [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
        [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        [_iFlySpeechRecognizer setDelegate:self];
        
        BOOL ret = [_iFlySpeechRecognizer startListening];
        
        if (ret) {
            //            [_audioStreamBtn setEnabled:NO];
            //            [_upWordListBtn setEnabled:NO];
            //            [_upContactBtn setEnabled:NO];
            
        }else{
            //[_popUpView showText: @"启动识别服务失败，请稍后重试"];//可能是上次请求未结束，暂不支持多路并发
        }
    }else {
        
        if(_iflyRecognizerView == nil)
        {
            [self initRecognizer ];
        }
        
        //        [_textView setText:@""];
        //        [_textView resignFirstResponder];
        
        //设置音频来源为麦克风
        [_iflyRecognizerView setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        //设置听写结果格式为json
        [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
        [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        BOOL ret = [_iflyRecognizerView start];
        if (ret) {
            //            [_startRecBtn setEnabled:NO];
            //            [_audioStreamBtn setEnabled:NO];
            //            [_upWordListBtn setEnabled:NO];
            //            [_upContactBtn setEnabled:NO];
        }
    }
    
}


/**
 设置识别参数
 ****/
-(void)initRecognizer
{
    NSLog(@"%s",__func__);
    
    if ([IATConfig sharedInstance].haveView == NO) {//无界面
        
        //单例模式，无UI的实例
        if (_iFlySpeechRecognizer == nil) {
            _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
            
            [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
            
            //设置听写模式
            [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        }
        _iFlySpeechRecognizer.delegate = self;
        
        if (_iFlySpeechRecognizer != nil) {
            IATConfig *instance = [IATConfig sharedInstance];
            
            //设置最长录音时间
            [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //设置后端点
            [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //设置前端点
            [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //网络等待时间
            [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //设置采样率，推荐使用16K
            [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            
            if ([instance.language isEqualToString:[IATConfig chinese]]) {
                //设置语言
                [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
                //设置方言
                [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            }else if ([instance.language isEqualToString:[IATConfig english]]) {
                [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            }
            //设置是否返回标点符号
            [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
            
        }
        
        //初始化录音器
        if (_pcmRecorder == nil)
        {
            _pcmRecorder = [IFlyPcmRecorder sharedInstance];
        }
        
        _pcmRecorder.delegate = self;
        
        [_pcmRecorder setSample:[IATConfig sharedInstance].sampleRate];
        
        [_pcmRecorder setSaveAudioPath:nil];    //不保存录音文件
        
    }else  {//有界面
        
        //单例模式，UI的实例
        if (_iflyRecognizerView == nil) {
            //UI显示剧中
            _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
            
            [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
            
            //设置听写模式
            [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
            
        }
        _iflyRecognizerView.delegate = self;
        
        if (_iflyRecognizerView != nil) {
            IATConfig *instance = [IATConfig sharedInstance];
            //设置最长录音时间
            [_iflyRecognizerView setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //设置后端点
            [_iflyRecognizerView setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //设置前端点
            [_iflyRecognizerView setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //网络等待时间
            [_iflyRecognizerView setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //设置采样率，推荐使用16K
            [_iflyRecognizerView setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            if ([instance.language isEqualToString:[IATConfig chinese]]) {
                //设置语言
                [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
                //设置方言
                [_iflyRecognizerView setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            }else if ([instance.language isEqualToString:[IATConfig english]]) {
                //设置语言
                [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            }
            //设置是否返回标点符号
            [_iflyRecognizerView setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
            
        }
    }
}



#pragma mark - 一些代理的地方

#pragma -mark --------------- IFlySpeechRecognizerDelegate

#pragma mark - IFlySpeechRecognizerDelegate

/**
 音量回调函数
 volume 0－30
 ****/
- (void) onVolumeChanged: (int)volume
{
    if (self.isCanceled) {
        //[_popUpView removeFromSuperview];
        return;
    }
    
    NSString * vol = [NSString stringWithFormat:@"音量：%d",volume];
    //[_popUpView showText: vol];
    
    [_voiceHud_ setProgress:volume];
    
}

- (void) onError:(IFlySpeechError *) error
{
    NSLog(@"%s",__func__);
    
    if ([IATConfig sharedInstance].haveView == NO ) {
        
        //        if (self.isStreamRec) {
        //            //当音频流识别服务和录音器已打开但未写入音频数据时stop，只会调用onError不会调用onEndOfSpeech，导致录音器未关闭
        //            [_pcmRecorder stop];
        //            self.isStreamRec = NO;
        //            NSLog(@"error录音停止");
        //        }
        
        NSString *text ;
        
        if (self.isCanceled) {
            text = @"识别取消";
            
        } else if (error.errorCode == 0 ) {
            if (_result.length == 0) {
                //text = @"无识别结果";
                text = @"识别结束";
            }else {
                text = @"识别成功";
                //清空识别结果
                _result = nil;
            }
        }else {
            text = [NSString stringWithFormat:@"发生错误：%d %@", error.errorCode,error.errorDesc];
            NSLog(@"%@",text);
        }
        
        //[_popUpView showText: text];
        
    }else {
        //[_popUpView showText:@"识别结束"];
        NSLog(@"errorCode:%d",[error errorCode]);
    }
    
    //    [_startRecBtn setEnabled:YES];
    //    [_audioStreamBtn setEnabled:YES];
    //    [_upWordListBtn setEnabled:YES];
    //    [_upContactBtn setEnabled:YES];
    
}


/**
 无界面，听写结果回调
 results：听写结果
 isLast：表示最后一次
 ****/
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    //    _result =[NSString stringWithFormat:@"%@%@", _textView.text,resultString];
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:resultString];
    
    
    NSLog(@"-------------------%@",resultFromJson);
    if([resultFromJson.trim isEqualToString:@"。" ]){
        return;
    }
    
    self.textFieldSearchKey.text = [NSString stringWithFormat:@"%@%@", self.textFieldSearchKey.text,resultFromJson];
    
    //    if (isLast){
    //        NSLog(@"听写结果(json)：%@测试",  self.result);
    //    }
    //    NSLog(@"_result=%@",_result);
    //    NSLog(@"resultFromJson=%@",resultFromJson);
    //    NSLog(@"isLast=%d,_textView.text=%@",isLast,_textView.text);
}


#pragma mark  textFiledelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    //[textField resignFirstResponder];//关闭键盘
    
    NSString *keyWord = textField.text.trim;
    if(keyWord.length == 0){
        
        [self showFaliureHUD:@"请输入关键字"];
       
        return NO;
    }
    [textField resignFirstResponder];//关闭键盘
    
    //[self dealTags:keyWord]; //保存关键字
    
    //    SPReadingsCheckSearchViewController *readingsCheckViewController = [[SPReadingsCheckSearchViewController alloc] init];
    //    //readingsCheckViewController.keyWork = keyWord;
    //    [self pushNewVC:readingsCheckViewController animated:YES];
    //
    return YES;
}


@end
