//
//  RSAViewController.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/6/21.
//  Copyright © 2017年 liyanjun. All rights reserved.
//

#import "RSAViewController.h"
#import "RSAEncryptor.h"
#define ENCRYPTIONTAG 1001
#define DECRYPTION 1002

@interface RSAViewController ()

@property (nonatomic,strong)UITextField* sourceText;

@property (nonatomic,strong)UILabel* cipherLable;

@property (nonatomic,strong)UIButton* encryptionButton;//加密

@property (nonatomic,strong)UIButton* decryptionButton;//解密

@property (nonatomic,strong)UILabel* clearLable;

@end

@implementation RSAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --懒加载

- (UITextField *)sourceText{

    if (!_sourceText) {
        _sourceText = [[UITextField alloc] init];
        
        _sourceText.font = [UIFont systemFontOfSize:MasScale_1080(42)];
        
        
        _sourceText.textColor = [UIColor blackColor];
        
     
        _sourceText.layer.cornerRadius = MasScale_1080(20);
        
        _sourceText.layer.borderWidth = MasScale_1080(3);
        
        _sourceText.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        _sourceText.layer.masksToBounds = YES;
        
        
        _sourceText.text = @"";
    }

    return _sourceText;
}

- (void)sourceTextF{

    [_sourceText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(MasScale_1080(30));
        
        make.leading.mas_equalTo(self.view.mas_leading).mas_offset(MasScale_1080(30));
        
        make.trailing.mas_equalTo(self.view.mas_trailing).mas_offset(MasScale_1080(-30));
        
        make.height.mas_equalTo(MasScale_1080(100));
    }];


}



- (UIButton *)encryptionButton{

    if (!_encryptionButton) {
        _encryptionButton = [[UIButton alloc] init];
        
        [_encryptionButton setTitle:@"加密" forState:UIControlStateNormal];
        
        [_encryptionButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        _encryptionButton.tag = ENCRYPTIONTAG;
        
        [_encryptionButton addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _encryptionButton;


}

- (void)encryptionButtonF{


    [_encryptionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.height.trailing.mas_equalTo(_sourceText);
        make.top.mas_equalTo(_sourceText.mas_bottom).mas_offset(MasScale_1080(30));
    }];


}

- (UILabel *)cipherLable{


    if (!_cipherLable) {
        _cipherLable = [[UILabel alloc] init];
        
        
        _cipherLable.font = [UIFont systemFontOfSize:MasScale_1080(42)];
        
        
        _cipherLable.textColor =[UIColor redColor];
        
        _cipherLable.numberOfLines = 0;
        
        
        _cipherLable.text = @"";
    }
    
    return _cipherLable;


}

- (void)cipherLableF{


    [_cipherLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(_sourceText);
        
        make.top.mas_equalTo(_encryptionButton.mas_bottom).mas_offset(MasScale_1080(30));
    }];

}

- (UIButton *)decryptionButton{

    if (!_decryptionButton) {
        _decryptionButton = [[UIButton alloc] init];
        
        [_decryptionButton setTitle:@"解密" forState:UIControlStateNormal];
        
        [_decryptionButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        _decryptionButton.tag = DECRYPTION;
        
        [_decryptionButton addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _decryptionButton;
}

- (void)decryptionButtonF{

    [_decryptionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.height.mas_equalTo(_sourceText);
        
        make.top.mas_equalTo(_cipherLable.mas_bottom).mas_offset(MasScale_1080(30));;
    }];

}


- (UILabel *)clearLable{


    if (!_clearLable) {
        _clearLable = [[UILabel alloc] init];
        
        
        _clearLable.font = [UIFont systemFontOfSize:MasScale_1080(42)];
        
        
        _clearLable.textColor =[UIColor redColor];
        
        _clearLable.numberOfLines = 0;
        
        
        _clearLable.text = @"";
    }
    
    return _clearLable;

}

- (void)clearLableF{


    [_clearLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(_sourceText);
        
        make.top.mas_equalTo(_decryptionButton.mas_bottom).mas_offset(MasScale_1080(30));
    }];

}

#pragma mark --setupUi

- (void)setupUI{

    [self.view addSubview:self.sourceText];
    
    [self.view addSubview:self.encryptionButton];
    
    [self.view addSubview:self.cipherLable];
    
    [self.view addSubview:self.decryptionButton];
    
    [self.view addSubview:self.clearLable];
    
    
    
    [self sourceTextF];
    
     [self encryptionButtonF];
    
     [self cipherLableF];
    
     [self decryptionButtonF];
    
     [self clearLableF];
    
    

  

}

#pragma mark --实例方法

- (void)buttonCLick:(UIButton*)btn{


    if (btn.tag == ENCRYPTIONTAG) {
        NSString *filePath =  [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];

        NSLog(@"加密");
        self.cipherLable.text = [RSAEncryptor encryptString:self.sourceText.text publicKeyWithContentsOfFile:filePath];
    }else{
        NSString *filePath =  [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];
    
        self.clearLable.text = [RSAEncryptor decryptString:self.cipherLable.text privateKeyWithContentsOfFile:filePath password:@"2100201"];
    }
    

}

@end
