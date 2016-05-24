//
//  CustomScrollView.m
//  代码布局UITableviewCell
//
//  Created by majianjie on 16/5/24.
//  Copyright © 2016年 ddtc. All rights reserved.
//

#import "CustomScrollView.h"
#import "Constants.h"

//#define ScrollViewH 160

@interface CustomScrollView()<UIScrollViewDelegate>

/** timer*/
@property (nonatomic,strong)NSTimer *timer;


@end

@implementation CustomScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];//Color(153, 153, 153, 0.1);
        //添加UIScrollView 和page
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.scrollEnabled = YES;
        [self addSubview:self.scrollView];
        //添加PageControl控件
        self.page  = [[UIPageControl alloc] init];
        self.page.center = CGPointMake(HMScreenW * 0.5, CGRectGetMaxY(self.scrollView.frame) + 10);
        self.page.pageIndicatorTintColor = Color(53, 53, 53, 0.4);
        self.page.currentPageIndicatorTintColor =  Color(53, 53, 53, 1);
        self.page.bounds = CGRectMake(0, 0, HMScreenW / 2, 50);
        self.page.enabled = NO;//不能点了
        [self insertSubview:self.page aboveSubview:self.scrollView];
        
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat scrollViewX = 0;
    CGFloat scrollViewY = 0;
    CGFloat scrollViewW = self.frame.size.width;
    CGFloat scrollViewH = self.frame.size.height - 20;
    
    self.scrollView.frame = CGRectMake(scrollViewX, scrollViewY, scrollViewW, scrollViewH);
    
    self.page.center = CGPointMake(HMScreenW * 0.5, CGRectGetMaxY(self.scrollView.frame) + 10);    
    
}

- (void)setPicturs:(NSMutableArray *)picturs{

    _picturs = picturs;
    
    self.scrollView.contentSize = CGSizeMake(HMScreenW  * self.picturs.count, 0);
    
    NSLog(@"%f",self.scrollView.contentSize.width);
    NSLog(@"%f",self.scrollView.frame.size.width);
    
    self.page.numberOfPages = self.picturs.count == 1 ? 0 : self.picturs.count ;
    
    for (int i = 0; i<self.picturs.count; i++) {
        UIImageView *imageView = self.picturs[i];
        [self.scrollView addSubview:imageView];
    }
    
    [self performSelector:@selector(openTimer) withObject:nil afterDelay:1];
    

}

- (void)openTimer{
    
    [self addTimer];
    
}
#pragma mark scrollView Delegate 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //    关闭定时器(注意点; 定时器一旦被关闭,无法再开启)
    [self removeTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //    开启定时器
    [self addTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = (scrollView.contentOffset.x / scrollView.frame.size.width);//滚动的距离/一个页的宽度 = 几页
    self.page.currentPage = page;//设置pageControl 的当前页
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"当前是第 %ld 页 ",(long)self.page.currentPage);
    
}

#pragma mark 定时器(轮播图)
- (void)nextImage{
    int page = (int)self.page.currentPage;
    if (page == self.picturs.count - 1) {
        page = 0;
    }else{
        page++;
    }
    
    //  滚动scrollview
    CGFloat x = page * self.scrollView.frame.size.width;
    self.scrollView.contentOffset = CGPointMake(x, 0);
}
/***  开启定时器*/
- (void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}
/***  关闭定时器*/
- (void)removeTimer{
    [self.timer invalidate];
}


@end
