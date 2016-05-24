//
//  WeiboStatus.h
//  代码布局UITableviewCell
//
//  Created by majianjie on 16/5/16.
//  Copyright © 2016年 ddtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboStatus : NSObject


@property (nonatomic, copy) NSString *text; // 内容
@property (nonatomic, copy) NSString *icon; // 头像
@property (nonatomic, copy) NSString *name; // 昵称
//@property (nonatomic, copy) NSString *picture; // 配图
@property (nonatomic, strong) NSArray *pic_urls;

@property (nonatomic, assign) BOOL vip;
/** 角色*/
@property (nonatomic,strong)NSString *role;


- (id)initWithDict:(NSDictionary *)dict;
+ (id)weiboWithDict:(NSDictionary *)dict;


@end
