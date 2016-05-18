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

@interface CustomeTableViewController ()

@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation CustomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
  
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    

    [WeiboStatus setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"pic_urls" : @"HMPhoto",
                 };
    }];

    
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

//- (void)loadMore{
//    
//    [HMStatusPhotosView setupObjectClassInArray:^NSDictionary *{
//        return @{
//                 @"pic_urls" : @"HMPhoto",
//                 };
//    }];
//    
//    [WeiboStatus setupObjectClassInArray:^NSDictionary *{
//        return @{
//                 @"pic_urls" : @"HMPhoto",
//                 };
//    }];
//    
//    HMHomeStatusesResult *result = [HMHomeStatusesResult objectWithKeyValues:[self getStatusFromPlistFile]];
//    
//    //在这里获取文件中的微博数据
//    self.statusFrames = [self statusFramesWithStatuses:result.statuses];
//    
//    [self.statusFrames addObjectsFromArray:self.statusFrames];
//    
//    [self.tableView reloadData];
//
//}
//
///**
// *  根据微博模型数组 转成 微博frame模型数据
// *  @param statuses 微博模型数组
// */
//- (NSMutableArray *)statusFramesWithStatuses:(NSArray *)statuses
//{
//    NSMutableArray *frames = [NSMutableArray array];
//    for (WeiboStatus *status in statuses) {
//        WeiboFrame *frame = [[WeiboFrame alloc] init];
//        // 传递微博模型数据，计算所有子控件的frame
//        frame.status = status;
//        [frames addObject:frame];
//    }
//    return frames;
//}
//
//- (NSDictionary *)getStatusFromPlistFile
//{
//    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"wbstatus" ofType:@"plist"];
//    NSDictionary *dicInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//    
//    return dicInfo;
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 懒加载
- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"wbstatus.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:dictArray.count];
        for (NSDictionary *dict in dictArray) {
            // 创建模型
            WeiboStatus *status = [WeiboStatus weiboWithDict:dict];
            // 根据模型数据创建frame模型
            WeiboFrame *wbF = [[WeiboFrame alloc] init];
            wbF.status = status;
            
            [models addObject:wbF];
        }
        
        self.statusFrames = [models copy];
        
    }
    
    return _statusFrames;
    
}


@end
