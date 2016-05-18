//
//  WeiboCell.m
//  代码布局UITableviewCell
//
//  Created by majianjie on 16/5/16.
//  Copyright © 2016年 ddtc. All rights reserved.
//

#import "WeiboCell.h"
#import "WeiboStatus.h"
#import "Constants.h"

@interface WeiboCell()

/** icon*/
@property (nonatomic,strong)UIImageView *iconView;
/** vip*/
@property (nonatomic,strong)UIImageView *vipView;
/** 配图*/
@property (nonatomic,strong)UIImageView *pictureView;
/** 昵称*/
@property (nonatomic,strong)UILabel *nameLabel;
/**正文*/
@property (nonatomic,strong)UILabel *introLabel;

@end


@implementation WeiboCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        //昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        self.nameLabel = nameLabel;
        self.nameLabel.font = NJNameFont;
        self.nameLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:nameLabel];

        
        //vip
        UIImageView *vipView =[[UIImageView alloc]init];
        [self.contentView addSubview:vipView];
        self.vipView = vipView;
        
        //正文
        UILabel *introLabel =[[UILabel alloc] init];
        self.introLabel = introLabel;
        self.introLabel.numberOfLines = 0;
        self.introLabel.font = NJNameFont;
        self.introLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self.introLabel sizeToFit];
        [self.contentView addSubview:introLabel];
        
        //配图
        UIImageView *pictureView = [[UIImageView alloc] init];
        self.pictureView = pictureView;
        [self.contentView addSubview:pictureView];
        
        
    }
    
    return self;
    
}

- (void)setWeiboFrame:(WeiboFrame *)weiboFrame{
   
    _weiboFrame = weiboFrame;
    //开始设置数据
    [self setdata];
    //设置frame
    [self setFrame];

}

- (void)setdata{
    
    WeiboStatus *status = self.weiboFrame.status;
    
    //设置头像
    self.iconView.image = [UIImage imageNamed:status.icon];
    //昵称
    self.nameLabel.text = status.name;
    //设置VIP
    if(status.vip){
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:@"vipuser"];
        self.nameLabel.textColor = [UIColor redColor];
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    //内容
    self.introLabel.text = status.text;
    
    //配图
    if(status.picture){
        self.pictureView.image = [UIImage imageNamed:status.picture];
        self.pictureView.hidden = NO;
    }else{
        self.pictureView.hidden = YES;
    }
    
}

- (void)setFrame{
    // 设置头像的frame
     self.iconView.frame = self.weiboFrame.iconF;
     // 设置昵称的frame
         self.nameLabel.frame = self.weiboFrame.nameF;
     // 设置vip的frame
        self.vipView.frame = self.weiboFrame.vipF;
     // 设置正文的frame
        self.introLabel.frame = self.weiboFrame.introF;
     // 设置配图的frame
     if (self.weiboFrame.status.picture) {// 有配图
        self.pictureView.frame = self.weiboFrame.pictrueF;
     }
}

- (CGSize)sizewithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize{

    NSDictionary *dict = @{NSFontAttributeName : font};
    //如果将来计算的文本超出范围,返回的就是指定的范围
    //如果将来计算的文字的范围小于制定的范围,返回的就是真实的范围
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    return size;
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"CELL";
    
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;

}

@end
