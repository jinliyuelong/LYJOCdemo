//
//  VerticalBannerView.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/10.
//  Copyright © 2017年 hand. All rights reserved.
//

#import "VerticalBannerView.h"
#import "BannerContentView.h"

@interface VerticalBannerView()<UIScrollViewDelegate,BannerContentViewDelegate>


@property (strong, nonatomic) UIScrollView *scrolDefault;//scrollView

@property (strong, nonatomic) NSTimer *scrolTimer;//定时器


@end

@implementation VerticalBannerView{
    
    NSMutableArray  *dataSource;//数据来源
    NSInteger       dataSourceCount;//来源个数
    unsigned long   currentIndex;//当前页
    unsigned long   totalPage;//总的页数
    NSMutableArray  *muArrViews;//多个view
    
    NSInteger  currentPage;//当前页
    
    CGFloat  selfHeight;//
    
    CGFloat  selfWidth;//
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
    
    
    self.backgroundColor = [UIColor redColor];
    
}

#pragma mark - 懒加载


#pragma mark  - setUi

- (void)setupUi{
    
}

#pragma mark -  加载数据

#pragma mark -  delegate

#pragma mark  BannerContentViewDelegate

- (void)didSelectedWithView:(UIView *)view pointFromWindow:(CGPoint)point row:(NSInteger)row{
    //初始化时间
    [self initTime];
    
    NSInteger index = row%dataSourceCount;
    if ([self.scrolDelegate respondsToSelector:@selector(verticalBannerView:didSelectedImgWithRow:)]) {
        [self.scrolDelegate verticalBannerView:self didSelectedImgWithRow:index];
    } else {
        NSLog(@"滚动视图的代理没有响应，过来看看吧");
    }
}
#pragma mark  - 实例方法

#pragma mark  停止定时器
- (void)invalidateTimer
{
    [self.scrolTimer invalidate];
    self.scrolTimer = nil;
}


#pragma mark  初始定时器
- (void)initTime
{
    if (dataSource.count < 2) {
        return;
    }
    
    [self invalidateTimer];
    self.scrolTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeSource) userInfo:nil repeats:YES];
}


#pragma mark 定时器的循环方法
- (void)changeSource
{
    if (self.scrolTimer == nil) {
        return;
    }
    
    currentIndex += 1;
    
    NSInteger endX = 100/dataSourceCount*dataSourceCount+currentIndex%dataSourceCount;//到指定数量(pageCount的整数倍+偏移量)的时候切换到中间偏移量
    if (currentIndex <= endX || currentIndex >= totalPage-endX) {
        currentIndex = totalPage/2;
        
        NSLog(@"当前1是%lu,endX=%lu,totalPage=%lu",currentIndex,endX,totalPage);
        
        [self loadImgWithIndex:currentIndex];
        [_scrolDefault setContentOffset:CGPointMake(0, selfHeight*currentIndex) animated:NO];
        [self changeImgWithIndex:currentIndex];
    } else {
        
        NSLog(@"当前2是%lu,endX=%lu,totalPage=%lu selfheight= %f",currentIndex,endX,totalPage,selfHeight);
        
        [_scrolDefault setContentOffset:CGPointMake(0,selfHeight*currentIndex) animated:YES];
        [self changeImgWithIndex:currentIndex];
    }
    
}


#pragma mark  加载数据
- (void)reloadData:(NSArray*)source {
    if (source.count == 0) {
        return;
    }
    
    [self invalidateTimer];
    
    dataSource = [NSMutableArray arrayWithArray:source];
    dataSourceCount = source.count;
    
    if (source.count == 1) { //只有一张  不动
        [self reloadOnlyView];
        
    } else {
        
        
        //初始化时间
        [self initTime];
        
        [self reloadViews];
    }
}



#pragma mark 只有一条数据时候
- (void)reloadOnlyView
{
    if (![dataSource isKindOfClass:[NSArray class]] || dataSource.count == 0) {
        return ;
    }
    
    @autoreleasepool {
        
        CGFloat width = self.frame.size.width;
        
        CGFloat height = self.frame.size.height;
        
        selfHeight = height;
        
        selfWidth = width;
        
        [_scrolDefault removeFromSuperview];
        _scrolDefault = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        
        
        _scrolDefault.backgroundColor = [UIColor whiteColor];
        _scrolDefault.showsHorizontalScrollIndicator = NO;
        _scrolDefault.pagingEnabled = YES;
        _scrolDefault.delegate = self;
        [self addSubview:_scrolDefault];
        //
        
        
        
        
        BannerContentView *uiviewDefalut = [self addview:CGRectMake(0, 0, width, height) url:[dataSource firstObject] tag:0 ];
        
        
        
        
        
        [_scrolDefault addSubview:uiviewDefalut];
        
        
        
        
        
        
        self.clipsToBounds = YES;
    }
}

#pragma mark 添加view
- (BannerContentView *)addview:(CGRect)frame url:(NSString *)url tag:(NSInteger)tag
{
    BannerContentView *view = [[BannerContentView alloc] initWithFrame:frame];
    
    view.backgroundColor = [GlobalFunc  randomColor];
    
    
    view.index = tag;
    
    view.bannerContentViewDelegate = self;
    
    view.userInteractionEnabled = YES;
    
    view.contentLable.text = url;
    
    //    if (full) {
    //        imgViewDefault.contentMode = UIViewContentModeScaleAspectFit;
    //    }
    
    
    [self.scrolDefault addSubview:view];
    
    return view;
}

#pragma mark 多条数据的时候
- (void)reloadViews
{
    muArrViews = [NSMutableArray array];
    @autoreleasepool {
        
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        
        selfHeight = height;
        
        selfWidth = width;
        
        [_scrolDefault removeFromSuperview];
        _scrolDefault = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _scrolDefault.backgroundColor = [UIColor blueColor];
        _scrolDefault.showsHorizontalScrollIndicator = NO;
        
        
        _scrolDefault.pagingEnabled = YES;
        _scrolDefault.delegate = self;
        [self addSubview:_scrolDefault];
        
        
        if (![dataSource isKindOfClass:[NSArray class]] || dataSource.count == 0) {
            return ;
        }
        
        totalPage = 100000/dataSource.count*dataSource.count;
        currentIndex = totalPage/2;
        for (int i = 0; i < dataSource.count; ++i) {
            
            BannerContentView *viewDefalut = [self addview:CGRectMake(0, (currentIndex+i)*height, width, height) url:[dataSource firstObject] tag:(currentIndex+i) ];
            
            [muArrViews addObject:viewDefalut];
        }
        
        
        
        self.clipsToBounds = YES;
        
        _scrolDefault.contentSize = CGSizeMake(width, currentIndex*height*2);
        [_scrolDefault setContentOffset:CGPointMake(0, currentIndex*height) animated:NO];
        [self loadImgWithIndex:currentIndex];
        [self changeImgWithIndex:currentIndex];
    }
}


#pragma make 重新加载current
- (void)loadImgWithIndex:(NSInteger)index
{
    if (muArrViews.count == 0) {
        return;
    }
    
    NSInteger count = index%muArrViews.count;
    if ((dataSource.count <= count) || (dataSource.count <= count)) {
        return;
    }
    
    BannerContentView *imgViewDefault = muArrViews[index%muArrViews.count];
    imgViewDefault.index = index;
    
    NSInteger indexTemp = index%muArrViews.count;
    NSString *imgUrl = dataSource[indexTemp];
    
    
    
    imgViewDefault.contentLable.text = imgUrl;
    
    imgViewDefault.frame = CGRectMake(0, selfHeight*index, selfWidth, selfHeight);
}



- (void)changeImgWithIndex:(NSInteger)index
{
    currentIndex = index;
    if (index > 0) {
        [self loadImgWithIndex:index-1];
    }
    if (index < totalPage) {
        [self loadImgWithIndex:index+1];
    }
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //初始化时间
    [self initTime];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //跟踪滚动视图页面
    CGFloat pageHeight = scrollView.bounds.size.height;
    int scrollcurrentPage = (scrollView.contentOffset.y - pageHeight/2) / pageHeight + 1;
    
    if (scrollcurrentPage != currentPage) {
        [self changeImgWithIndex:scrollcurrentPage];
    }
    
    
    currentPage =  currentPage%dataSourceCount;
    
    
}



#pragma mark -  类方法

@end
