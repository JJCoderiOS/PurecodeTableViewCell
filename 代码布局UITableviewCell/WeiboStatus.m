//

//  WeiboStatus.m
//  代码布局UITableviewCell
//
//  Created by majianjie on 16/5/16.
//  Copyright © 2016年 ddtc. All rights reserved.
//

#import "WeiboStatus.h"

@implementation WeiboStatus

- (id)initWithDict:(NSDictionary *)dict {
 
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (id)weiboWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}

@end
