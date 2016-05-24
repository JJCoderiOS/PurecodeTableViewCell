//
//  WeiboFrame.m
//  代码布局UITableviewCell
//
//  Created by majianjie on 16/5/16.
//  Copyright © 2016年 ddtc. All rights reserved.
//

#import "WeiboFrame.h"
#import <UIKit/UIKit.h>
#import "WeiboStatus.h"
#import "Constants.h"
#import "HMStatusPhotosView.h"


@implementation WeiboFrame

- (void)setStatus:(WeiboStatus *)status{
    
    _status = status;

    //间隙
    CGFloat padding = 10;
   
    //设置头像的frame
    CGFloat iconViewX = padding;
    CGFloat iconViewY = padding;
    CGFloat iconViewW = 30;
    CGFloat iconViewH = 30;
    self.iconF = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    
    //设置昵称的frame
//    昵称的x = 头像最大的X + 间隙
    CGFloat nameLabelX = CGRectGetMaxX(self.iconF) + padding;
    // 计算文字的宽高
    CGSize nameSize = [self sizeWithString:status.name font:NJNameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat nameLabelH = nameSize.height;
    CGFloat nameLabelW = nameSize.width ;
    CGFloat nameLabelY = iconViewY + (iconViewH - nameLabelH) * 0.6;
    self.nameF = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    //设置VIP的frame
    CGFloat vipViewX = CGRectGetMaxX(self.nameF) + padding;
    CGFloat vipViewY = nameLabelY;
    CGFloat vipViewW = VIPW;
    CGFloat vipViewH = VIPH;
    self.vipF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    
    
    //设置角色的frame
    CGSize roleSize = [self sizeWithString:status.role font:NJNameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat roleX = HMScreenW - padding - roleSize.width;
    CGFloat roleY = vipViewY;
    CGFloat roleW = roleSize.width ;
    CGFloat roleH = roleSize.height;
    self.roleF = CGRectMake(roleX, roleY, roleW, roleH);
    
    
    
    // 设置正文的frame
    CGFloat introLabelX = iconViewX;
    CGFloat introLabelY = CGRectGetMaxY(self.iconF) + padding;
    
    CGFloat maxW = HMScreenW - 2 * padding;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize =  [self sizeWithString:status.text font:NJNameFont maxSize:maxSize];
    CGFloat introLabelW = textSize.width;
    CGFloat introLabelH = textSize.height;
    
    self.introF = CGRectMake(introLabelX, introLabelY, introLabelW, [status.text isEqualToString:@""] ? 0 : introLabelH);
    
    // 4.配图相册
    if (status.pic_urls.count) {//有配图
        CGFloat photosX = iconViewX;
        CGFloat photosY = CGRectGetMaxY(self.introF) + padding;
        
        CGSize size = [HMStatusPhotosView sizeWithPhotosCount:status.pic_urls.count];
        self.pictrueF = CGRectMake(photosX, photosY, size.width ,size.height);
        
        self.cellHeight = CGRectGetMaxY(self.pictrueF) + padding;
        
    }else{//没有配图
        self.cellHeight = CGRectGetMaxY(self.introF) + padding;
    }
    
    // 5.时间
    CGSize timeSize = [self sizeWithString:status.time font:JJTimeFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.timeF = CGRectMake(padding, self.cellHeight, timeSize.width, timeSize.height);
    
    // 6 赞和评论
    self.commentPraiseF = CGRectMake(HMScreenW - padding - 120, self.cellHeight, 120, 20);
    self.cellHeight = CGRectGetMaxY(self.commentPraiseF) + padding;
    
}

- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize{
    
     NSDictionary *attributes = @{NSFontAttributeName:font};
     // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
     // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
     CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

- (CGFloat)getWidthWithContent:(NSString *)content height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [content boundingRectWithSize:CGSizeMake(999, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                        context:nil];
    return rect.size.width;
}

- (CGFloat)getHeightWithContent:(NSString *)content width:(CGFloat)width font:(CGFloat)font{
    
    CGRect rect = [content boundingRectWithSize:CGSizeMake(width, 999)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                        context:nil];
    return rect.size.height;
}

@end
