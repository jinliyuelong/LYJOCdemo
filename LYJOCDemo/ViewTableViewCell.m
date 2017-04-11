//
//  ViewTableViewCell.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/2.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "ViewTableViewCell.h"

static NSString* const ViewTableViewCellId=@"ViewTableViewCellId";

@interface ViewTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialization];
    }
    return self;


}


- (void)initialization {
    
    [self setUpView];
    
}

#pragma mark 设置view
-(void)setUpView{
    
    [self addTitle];
    
    [self setContenViewF];
    
}


- (void)setContenViewF{
    
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        
        make.leading.mas_equalTo(self.mas_leading).offset(0);
        
        make.trailing.mas_equalTo(self.mas_trailing).offset(0);
        
        make.bottom.mas_equalTo(self);
        
        
    }];
    
}

#pragma mark 懒加载title

- (UILabel*) titleLabel{


    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [self settitleP];
        
    }
    return _titleLabel;
}

- (void) addTitle{

    [self.contentView addSubview:self.titleLabel];
    
    [self settitleF];
}


- (void) settitleP {

    _titleLabel.tintColor = TitlelableColor ;
    
    _titleLabel.numberOfLines = 0 ;
    
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    
    
    _titleLabel.font = [UIFont systemFontOfSize:mylableSize];
    
    

}


- (void)settitleF{

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading).offset(mycommonEdge);
        
        
        make.top.equalTo(self.contentView.mas_top).offset(mycommonEdge);
        
        
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-mycommonEdge);
        
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-mycommonEdge).priority(600);
        
    }];
}



-(void)databind:(NSString*)title{


    self.titleLabel.text = title;
    
    
    
    
}


    

+ (NSString*) cellId{


    return ViewTableViewCellId;
}

@end
