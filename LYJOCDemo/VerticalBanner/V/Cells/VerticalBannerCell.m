//
//  VerticalBannerCell.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/10.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "VerticalBannerCell.h"
#import "VerticalBannerView.h"
static NSString* const ViewTableViewCellId=@"ViewTableViewCellId";

@interface VerticalBannerCell()<VerticalScrolDelegate>

@property(nonatomic, strong)VerticalBannerView *verticalBannerView;

@end

@implementation VerticalBannerCell




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


- (VerticalBannerView *)verticalBannerView{


    if (!_verticalBannerView) {
        _verticalBannerView = [[VerticalBannerView alloc] initWithFrame:CGRectMake(mycommonEdge, mycommonEdge, ScreenWidth - mycommonEdge*2 , 23.33)];
        
        
//        _verticalBannerView.backgroundColor = [UIColor redColor];
        
         _verticalBannerView.scrolDelegate = self;
    }
    return _verticalBannerView;
}

- (void)verticalBannerViewF{


    [_verticalBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(self.contentView).offset(mycommonEdge);
        
        make.trailing.mas_equalTo(self.contentView).offset(-mycommonEdge);
        
        
        make.height.mas_equalTo(23.33);
        
        make.bottom.mas_equalTo(self.contentView).offset(-mycommonEdge).priority(600);
        
    }];
    
}




#pragma mark - 设置UI

- (void)setupUi{


    [self.contentView addSubview:self.verticalBannerView];
    
    [self verticalBannerViewF];
    
    [self.verticalBannerView reloadData:@[@"第一行",@"第二行",@"第三行",@"第4行",@"第5行",@"第6行"]];
    
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

#pragma mark  - delegate

- (void)verticalBannerView:(VerticalBannerView *)scrol didSelectedImgWithRow:(NSInteger)row{

    NSLog(@"点击了第几行%lu",row);

}

#pragma mark - 数据改变

#pragma mark - 类方法

+ (NSString*) cellId{
    
    
    return ViewTableViewCellId;
}

@end
