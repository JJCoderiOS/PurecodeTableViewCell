

#import "CommentPraiseView.h"
#import "Constants.h"
#import "UIView+Extension.h"

@interface CommentPraiseView()
{
    int i;
}
@property (nonatomic,strong)UIButton *approvBtn;
@property (nonatomic,strong)UIButton *commentBtn;
@property (nonatomic,strong)UIView *lineView;

@property (strong, nonatomic) IBOutlet UIImageView *image1;


@end

@implementation CommentPraiseView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = Color(30, 32, 40,1);
        self.layer.cornerRadius = 5;
        
        [self setUpBtn];
        
    }
    
    return self;
}

//添加"赞"和"评论"按钮
- (void)setUpBtn
{
    /*添加赞按钮*/
    UIButton *approvBtn = [[UIButton alloc] init];
    self.approvBtn = approvBtn;
    [self addSubview:approvBtn];
    
    /*赞 和 评论 中间的 竖线*/
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    self.lineView = lineView;
    
    
    /*添加评论按钮*/
    UIButton *commentBtn = [[UIButton alloc] init];
    self.commentBtn = commentBtn;
    [self addSubview:commentBtn];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnX = 0;
    CGFloat btnY = 10;
    CGFloat btnW = self.width / 2;
    CGFloat btnH = self.height / 3 * 1.5;
    
    [self setUpapproveBtnAndCommentBtn:self.approvBtn andTitle:@"赞" andX:btnX andY:btnY andW:btnW andH:btnH andImage:@"1"];
    [self.approvBtn addTarget:self action:@selector(appAct:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setUpapproveBtnAndCommentBtn:self.commentBtn andTitle:@"评论" andX:CGRectGetMaxX(self.approvBtn.frame) andY:btnY andW:CGRectGetWidth(self.approvBtn.frame) andH:CGRectGetHeight(self.approvBtn.frame) andImage:@"tab_icon_wo_hl"];
    [self.commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

//提取共有的代码
- (void) setUpapproveBtnAndCommentBtn:(UIButton *)btn andTitle:(NSString *)title andX:(CGFloat)x andY:(CGFloat)y andW:(CGFloat)w andH:(CGFloat)h andImage:(NSString *)name
{
    
    btn.frame = CGRectMake(x,y,w,h);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textColor = White;
    btn.titleLabel.font = Small_Font;
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
}


- (void)appAct:(UIButton *)sender{
    
    NSLog(@"***************增加了一赞***************");

}

- (void)commentAction:(UIButton *)sender{
    
    NSLog(@"***************增加了一条评论***************");
  
    
}

@end
