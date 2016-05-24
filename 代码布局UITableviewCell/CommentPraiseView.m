

#import "CommentPraiseView.h"
#import "Constants.h"
#import "UIView+Extension.h"

#define BtnW  self.frame.size.width / 2
#define BtnH  self.frame.size.height

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
        
        self.backgroundColor = [UIColor clearColor];//Color(30, 32, 40,1);
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
    [self.approvBtn setTitle:@"赞" forState:UIControlStateNormal];
    self.approvBtn.backgroundColor = Color(153, 153, 153, 0.2);
    [self addSubview:approvBtn];
    
     /*添加评论按钮*/
    UIButton *commentBtn = [[UIButton alloc] init];
    self.commentBtn = commentBtn;
    
    self.commentBtn.backgroundColor = Color(153, 153, 153, 0.5);

    [self.commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [self addSubview:commentBtn];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
     self.approvBtn.frame = CGRectMake(0, 0, BtnW - 1,BtnH);
    
    
    [self.approvBtn addTarget:self action:@selector(appAct:) forControlEvents:UIControlEventTouchUpInside];
    
    self.commentBtn.frame = CGRectMake(CGRectGetMaxX(self.approvBtn.frame) + 1, 0, BtnW - 2,BtnH);

    
    [self.commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)appAct:(UIButton *)sender{
    
    NSLog(@"***************增加了一赞***************");

}

- (void)commentAction:(UIButton *)sender{
    
    NSLog(@"***************增加了一条评论***************");
  
    
}

@end
