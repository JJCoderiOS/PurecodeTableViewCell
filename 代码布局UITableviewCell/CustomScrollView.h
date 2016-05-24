//
//  CustomScrollView.h
//  代码布局UITableviewCell
//
//  Created by majianjie on 16/5/24.
//  Copyright © 2016年 ddtc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomScrollView : UIView

/** scrollView*/
@property (nonatomic,strong)UIScrollView *scrollView;

/** page*/
@property (nonatomic,strong)UIPageControl *page;

/** 图片数组*/
@property (nonatomic,strong)NSMutableArray *picturs;


@end
