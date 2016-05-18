//
//  WeiboCell.h
//  代码布局UITableviewCell
//
//  Created by majianjie on 16/5/16.
//  Copyright © 2016年 ddtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboFrame.h"
#import "HMStatusPhotosView.h"

@interface WeiboCell : UITableViewCell


+ (WeiboCell *)cellWithTableView:(UITableView *)tableView;

/**  接收外界传入的模型*/
@property (nonatomic, strong) WeiboFrame *weiboFrame;
/**配图相册*/
@property (nonatomic,strong) HMStatusPhotosView *photosView;


@end
