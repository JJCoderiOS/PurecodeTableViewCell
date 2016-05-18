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

@interface CustomeTableViewController ()

@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation CustomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
  
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self loadMoreData];
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
- (NSMutableArray *)statusFrames
{
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
    
/*
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
 */
    return _statusFrames;
}

- (void)loadMoreData
{
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

- (NSArray *)getStatusFromPlistFile
{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"wbstatus" ofType:@"plist"];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:plistPath];
    return dictArray;
}

@end
