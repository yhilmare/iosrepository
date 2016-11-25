//
//  YHResumeButton.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/6.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHResumeButton.h"
#import "YHResume.h"

@interface YHResumeButton ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, copy) YHResume *resume;

@property (nonatomic, strong) UILabel *rateLabel;

@end

@implementation YHResumeButton

- (UILabel *) rateLabel{
    if(!_rateLabel){
        _rateLabel = [[UILabel alloc] init];
        _rateLabel.font = [UIFont systemFontOfSize:10];
        _rateLabel.textAlignment = NSTextAlignmentCenter;
        [_rateLabel setTextColor:[UIColor whiteColor]];
        
    }
    return _rateLabel;
}

- (UIImageView *) iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_resume2"]];
        _iconView.userInteractionEnabled = NO;
    }
    return _iconView;
}

- (UILabel *) nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [_nameLabel setTextColor:[UIColor blackColor]];
        _nameLabel.userInteractionEnabled = NO;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat width = self.frame.size.height - 13;
    CGFloat height = self.frame.size.height - 13;
    self.iconView.frame = CGRectMake(x, 11.5, width - 10, height - 10);
    
    x = CGRectGetMaxX(self.iconView.frame) + 10;
    width = 120;
    self.nameLabel.frame = CGRectMake(x, 6.5, width, height);
    
    x = self.frame.size.width - 10 - 15 - 15;
    [self.rateLabel setText:[NSString stringWithFormat:@"%@％",self.resume.ResumeIntergrity == nil?@"0":self.resume.ResumeIntergrity]];
    self.rateLabel.layer.cornerRadius = 5;
    self.rateLabel.layer.masksToBounds = YES;
    [self.rateLabel setBackgroundColor:[UIColor colorWithRed:64 / 255.0 green:224 / 255.0 blue:208 / 255.0 alpha:1]];
    self.rateLabel.frame = CGRectMake(x - 5, 14, 28, 10);
}

- (instancetype) initWithFrame:(CGRect)frame andResume:(YHResume *) res{
    if(self = [super initWithFrame:frame]){
        _resume = res;
        [self addSubview:self.iconView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.rateLabel];
        [self.nameLabel setText:res.ResumeName];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat rate = [self.resume.ResumeIntergrity floatValue];
    rate /= 100.0;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
        
    [[UIColor grayColor] setStroke];
    CGContextSetLineWidth(context, 0.5);
        
    CGContextMoveToPoint(context, 0, self.frame.size.height);
    CGContextAddLineToPoint(context, self.frame.size.width - 15, self.frame.size.height);
        
    CGContextStrokePath(context);
    
    CGFloat x = self.frame.size.width - 10 - 15 - 15;
        
    CGContextMoveToPoint(context, x, 25);
    CGContextAddArc(context, x, 25, 10, - M_PI_2, M_PI * 2 * rate - M_PI_2, 0);
    [[UIColor grayColor] setFill];
    CGContextFillPath(context);
    CGContextAddArc(context, x, 25, 11, 0, M_PI * 2, 0);
    CGContextSetLineWidth(context, 0.5);
    CGContextStrokePath(context);

}

@end
