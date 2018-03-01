//
//  AnimationFirstViewController.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/6/26.
//  Copyright © 2017年 liyanjun. All rights reserved.
//

#import "AnimationFirstViewController.h"

@interface AnimationFirstViewController ()

@property (nonatomic,strong)UITextField* userName;

@property (nonatomic,strong)UITextField* password;

@property (nonatomic,strong)UIButton* login;
@end

@implementation AnimationFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUi];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidDisappear:(BOOL)animated{

//    [self fuyuan];

    
    [super viewDidDisappear:animated];

}

- (void) viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    [self aniton];

}
#pragma mark --懒加载

- (UITextField *)userName{

    if (!_userName) {
        _userName = [[UITextField alloc] initWithFrame:CGRectMake(MasScale_1080(30), MasScale_1080(30), ScreenWidth-MasScale_1080(60), MasScale_1080(100))];
        
        _userName.font = [UIFont systemFontOfSize:MasScale_1080(42)];
        
        
        _userName.textColor = [UIColor blackColor];
        
        _userName.placeholder = @"请输入用户名";
        
        
        _userName.layer.cornerRadius = MasScale_1080(20);
        
        _userName.layer.borderWidth = MasScale_1080(3);
        
        _userName.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        _userName.layer.masksToBounds = YES;
        
        
        _userName.text = @"";
    }
    
    return _userName;
}


- (UITextField *)password{

    if (!_password) {
        _password = [[UITextField alloc] init];
        
        
        _password.top = _userName.bottom+ MasScale_1080(30);
        
        _password.width= _userName.width;
        
        
        _password.height= _userName.height;
        

        
        _password.left= _userName.left;
        

        
        _password.font = [UIFont systemFontOfSize:MasScale_1080(42)];
        
        
        _password.textColor = [UIColor blackColor];
        
        _password.placeholder = @"请输入密码";
        
        
        _password.layer.cornerRadius = MasScale_1080(20);
        
        _password.layer.borderWidth = MasScale_1080(3);
        
        _password.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        _password.layer.masksToBounds = YES;
        
        
        _password.text = @"";
    }
    
    return _password;

}


- (UIButton *)login{

    if (!_login) {
        _login = [[UIButton alloc] initWithFrame:CGRectMake(_password.left, _password.bottom+MasScale_1080(30), _password.width, _password.height)];
        
        _login.backgroundColor = [UIColor blueColor];
        
        
        [_login addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_login setTitle:@"动画开始" forState:UIControlStateNormal];
    }
    
    return _login;

}


#pragma  mark --ui

- (void)setupUi{

    [self.view addSubview:self.userName];
    
    [self.view addSubview:self.password];
    
    [self.view addSubview:self.login];

    
   
}


- (void)fuyuan{


    //设置文本框初始位置为屏幕左侧
    CGPoint accountCenter = self.userName.center;
    CGPoint psdCenter = self.password.center;
    accountCenter.x -= ScreenWidth;
    psdCenter.x -= ScreenWidth;
    self.userName.center = accountCenter;
    self.password.center = psdCenter;
    self.login.alpha = 0;
    
}

#pragma mark 实例
- (void)buttonClick:(UIButton*)btn{

    [self aniton];

}

- (void)aniton{

    //设置文本框初始位置为屏幕左侧
    CGPoint accountCenter = self.userName.center;
    CGPoint psdCenter = self.password.center;
   
    accountCenter.x -= ScreenWidth;
    psdCenter.x -= ScreenWidth;

    self.userName.center = accountCenter;
    self.password.center = psdCenter;
    
    self.login.bottom -= ScreenHeight;
    
    
    accountCenter.x += ScreenWidth;
    psdCenter.x += ScreenWidth;

//
    
//    [UIView transitionWithView: self.userName duration: 0.5 options: UIViewAnimationOptionTransitionFlipFromLeft animations: ^{
//        self.userName.transform =  CGAffineTransformMakeRotation(M_PI*90);
//    } completion: ^(BOOL finished) {
////        isAnimating = NO;
//    }];
    
  
    
    [UIView animateWithDuration: 0.5 delay: 0.35 options: UIViewAnimationOptionTransitionFlipFromLeft animations: ^{
        
        self.userName.center = accountCenter;
        self.password.center = psdCenter;
    } completion: ^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0.35 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.login.bottom += ScreenHeight;

        } completion:nil];
    }];
}

@end
