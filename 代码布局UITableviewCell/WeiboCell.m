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
#import "CommentPraiseView.h"


@interface WeiboCell()

/** icon*/
@property (nonatomic,strong)UIImageView *iconView;
/** vip*/
@property (nonatomic,strong)UIImageView *vipView;
/** 角色*/
@property (nonatomic,strong)UILabel *roleView;

/** 配图*/
@property (nonatomic,strong)UIImageView *pictureView;
/** 昵称*/
@property (nonatomic,strong)UILabel *nameLabel;
/**正文*/
@property (nonatomic,strong)UILabel *introLabel;

/** time*/
@property (nonatomic,strong)UILabel *timeLabel;


/** 点赞和评论的View*/
@property (nonatomic,strong)CommentPraiseView *commentPraiseView;


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
//        self.nameLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:nameLabel];

        
        //vip
        UIImageView *vipView =[[UIImageView alloc]init];
        [self.contentView addSubview:vipView];
        self.vipView = vipView;
        
        //角色
        UILabel *roleView = [[UILabel alloc] init];
        self.roleView = roleView;
        self.roleView.font = NJNameFont;
        self.roleView.textColor = [UIColor lightGrayColor];
//        self.nameLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.roleView];

        //正文
        UILabel *introLabel =[[UILabel alloc] init];
        self.introLabel = introLabel;
        self.introLabel.numberOfLines = 0;
        self.introLabel.font = NJNameFont;
        self.introLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self.introLabel sizeToFit];
        [self.contentView addSubview:introLabel];
        
        //配图
        HMStatusPhotosView *photosView = [[HMStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        //时间
        UILabel *timeLabel = [[UILabel alloc]init];
        self.timeLabel = timeLabel;
        self.timeLabel.font = JJTimeFont;
        self.timeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.timeLabel];
        
        
        //点赞和评论的View
        CommentPraiseView *commentPraise = [[CommentPraiseView alloc] init];
        [self.contentView addSubview:commentPraise];
        self.commentPraiseView = commentPraise;
        
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
    
    //角色
    self.roleView.text = status.role;
    //内容
    self.introLabel.text = status.text;
    //时间
    self.timeLabel.text = status.time;
    
}

- (void)setFrame{
    // 设置头像的frame
     self.iconView.frame = self.weiboFrame.iconF;
     // 设置昵称的frame
         self.nameLabel.frame = self.weiboFrame.nameF;
     // 设置vip的frame
        self.vipView.frame = self.weiboFrame.vipF;
    
    //设置角色的frame
    self.roleView.frame = self.weiboFrame.roleF;
//    self.roleView.backgroundColor = [UIColor lightGrayColor];
    
     // 设置正文的frame
        self.introLabel.frame = self.weiboFrame.introF;

    //6.配图相册
    if (self.weiboFrame.status.pic_urls.count) {
        self.photosView.frame = self.weiboFrame.pictrueF;
        self.photosView.hidden = NO;
        self.photosView.pic_urls = self.weiboFrame.status.pic_urls;
    }else{
        self.photosView.hidden = YES;
    }
    
    self.timeLabel.frame = self.weiboFrame.timeF;
    
    self.commentPraiseView.frame = self.weiboFrame.commentPraiseF;

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
