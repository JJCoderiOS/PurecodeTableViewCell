//
//  CustomeTableViewController.m
//  代码布局UITableviewCell
//
//  Created by majianjie on 16/5/16.
//  Copyright © 2016年 ddtc. All rights reserved.
//

#import "CustomeTableViewController.h"
#import "WeiboCell.h"
#import "WeiboFrame.h"
#import "WeiboStatus.h"
#import "MJExtension.h"
#import "HMHomeStatusesResult.h"
#import "HMStatusPhotoView.h"
#import "Constants.h"

#define ScrollViewH 160

@interface CustomeTableViewController ()

@property (nonatomic, strong) NSMutableArray *statusFrames;

/** scrollVoew*/
@property (nonatomic,strong)UIScrollView *scrollView;

/** 存放所有的图片*/
@property (nonatomic,strong)NSMutableArray *pictures;

@property (strong, nonatomic)UIPageControl *page;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CustomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
  
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self loadMoreData];
    
    
    [self initScrollView];
    
    
}

- (void)initScrollView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, HMScreenW, ScrollViewH)];
    
    if(self.pictures == nil){
        self.pictures = [NSMutableArray array];
    }
    
    for (int i = 0; i < 5; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * HMScreenW, 0, HMScreenW, ScrollViewH)];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pic_%d",i]];
        imageView.image = image;
        [self.pictures addObject:imageView];
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(HMScreenW  * self.pictures.count, 0);
    
    
    //添加PageControl控件
    self.page  = [[UIPageControl alloc] init];
    self.page.center = CGPointMake(HMScreenW * 0.5, CGRectGetMaxY(self.scrollView.frame) + 10);
    self.page.numberOfPages = self.pictures.count == 1 ? 0 : self.pictures.count ;
    self.page.pageIndicatorTintColor = Color(53, 53, 53, 0.4);
    self.page.currentPageIndicatorTintColor =  Color(53, 53, 53, 1);
    self.page.bounds = CGRectMake(0, 0, HMScreenW / 2, 50);
    self.page.enabled = NO;//不能点了
    [self.view insertSubview:self.page aboveSubview:self.scrollView];
    
    
    self.tableView.tableHeaderView = self.scrollView;

    [self performSelector:@selector(openTimer) withObject:nil afterDelay:1];
}

- (void)openTimer{
    
    [self addTimer];

}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeiboCell *cell = [WeiboCell cellWithTableView:tableView];
    // 3.设置数据
    cell.weiboFrame = self.statusFrames[indexPath.row];
    
    // 4.返回
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出对应航的frame模型
    WeiboFrame *wbF = self.statusFrames[indexPath.row];
    NSLog(@"height = %f", wbF.cellHeight);
    return wbF.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 懒加载
- (NSMutableArray *)statusFrames{
    if (_statusFrames == nil) {
        
        [HMStatusPhotosView mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"pic_urls" : @"HMPhoto",
                     };
        }];
        [WeiboStatus mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"pic_urls" : @"HMPhoto",
                     };
        }];
        
    }
    
    return _statusFrames;
}

- (void)loadMoreData{
    NSArray *dicArr = [self getStatusFromPlistFile];
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:dicArr.count];

    for (NSDictionary *dict in dicArr) {
        // 创建模型
        WeiboStatus *result = [WeiboStatus mj_objectWithKeyValues:dict];
        // 根据模型数据创建frame模型
        WeiboFrame *wbF = [[WeiboFrame alloc] init];
        wbF.status = result;
        [models addObject:wbF];
    }
    self.statusFrames = [models copy];

    [self.tableView reloadData];
    
}

- (NSArray *)getStatusFromPlistFile{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"wbstatus" ofType:@"plist"];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:plistPath];
    return dictArray;
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
    if (page == self.pictures.count - 1) {
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
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}
/***  关闭定时器*/
- (void)removeTimer{
    [self.timer invalidate];
}

@end
