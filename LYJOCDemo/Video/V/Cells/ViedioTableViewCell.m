//
//  ViedioTableViewCell.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/16.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "ViedioTableViewCell.h"




static NSString* const ViewTableViewCellId=@"ViedioTableViewCellId";

@interface ViedioTableViewCell()



@end



@implementation ViedioTableViewCell



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
    
    
    [self setupUi];
}



#pragma mark - 懒加载





#pragma mark - 设置UI

- (void)setupUi{
    
    
    
}

#pragma mark  - delegate


#pragma mark - 数据改变

#pragma mark - 类方法

+ (NSString*) cellId{
    
    
    return ViewTableViewCellId;
}


@end
