//
//  WeiboCell.h
//  代码布局UITableviewCell
//
//  Created by majianjie on 16/5/16.
//  Copyright © 2016年 ddtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboFrame.h"

@interface WeiboCell : UITableViewCell


+ (WeiboCell *)cellWithTableView:(UITableView *)tableView;

/**  接收外界传入的模型*/
@property (nonatomic, strong) WeiboFrame *weiboFrame;

@end
