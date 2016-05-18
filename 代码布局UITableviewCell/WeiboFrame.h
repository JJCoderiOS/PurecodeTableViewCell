//
//  WeiboFrame.h
//  代码布局UITableviewCell
//
//  Created by majianjie on 16/5/16.
//  Copyright © 2016年 ddtc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WeiboStatus;
@interface WeiboFrame : NSObject


/** iconF*/
@property (nonatomic,assign)CGRect iconF;

/** nameF*/
@property (nonatomic,assign)CGRect nameF;

/** vipF*/
@property (nonatomic,assign)CGRect vipF;

/** introF*/
@property (nonatomic,assign)CGRect introF;

/** pictrueF*/
@property (nonatomic,assign)CGRect pictrueF;


/** 行高*/
@property (nonatomic, assign) CGFloat cellHeight;

/** sttus*/
@property (nonatomic,strong)WeiboStatus *status;


@end
