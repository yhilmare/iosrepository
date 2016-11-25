//
//  YHAlertView.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/6.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHAlertView.h"
#import "YHResumeButton.h"
#import "YHResume.h"

@interface YHAlertView ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, copy) NSMutableArray *resumeArray;

@property (nonatomic, copy) NSMutableArray *buttonArray;

@end

@implementation YHAlertView

- (NSMutableArray *) resumeArray{
    if(!_resumeArray){
        _resumeArray = [NSMutableArray array];
    }
    return _resumeArray;
}

- (NSMutableArray *) buttonArray{
    if(!_buttonArray){
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}


- (UILabel *) nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [_nameLabel setTextColor:[UIColor blackColor]];
        [_nameLabel setText:@"请选择要投递的简历"];
    }
    return _nameLabel;
}

- (UIImageView *) iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (instancetype) initWithFrame:(CGRect)frame andResumeArray:(NSMutableArray *)array{
    
    if(self = [super init]){
        [self.resumeArray setArray:array];
        int count = (int)array.count;
        CGFloat height = count == 0?(30 + 20):(30 + count * 50 - 0.5);
        CGFloat y = ([UIScreen mainScreen].bounds.size.height - height) / 2.0;
        self.frame = CGRectMake(frame.origin.x, y, frame.size.width, height);
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds  = YES;
        [self addSubview:self.iconView];
        [self addSubview:self.nameLabel];
        
        [self setButton];
    }
    return self;
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    self.iconView.frame = CGRectMake(15, 5, 20, 20);
    [self.iconView setImage:[UIImage imageNamed:@"myprofile2"]];
    
    CGFloat x = CGRectGetMaxX(self.iconView.frame) + 10;
    CGFloat y = self.iconView.frame.origin.y;
    CGFloat width = 150;
    CGFloat height = 20;
    self.nameLabel.frame = CGRectMake(x, y, width, height);
    
    for(UIButton *button in self.buttonArray){
        [self addSubview:button];
    }
}


- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor grayColor] setStroke];
    CGContextSetLineWidth(context, 0.2);
    
    CGContextMoveToPoint(context, 15, 30);
    CGContextAddLineToPoint(context, self.frame.size.width - 15, 30);
    
    CGContextStrokePath(context);
}

- (void) setButton{
    
    for(int i = 0; i < self.resumeArray.count; i++){
        YHResume *res = self.resumeArray[i];
        CGFloat y = 30 + 50 * i;//10 + i * 20 + i * 10;
        CGFloat width = self.frame.size.width - 15;
        YHResumeButton *button = [[YHResumeButton alloc] initWithFrame:CGRectMake(15, y, width, 50) andResume:res];
        button.tag = i;
        [button addTarget:self action:@selector(clickFunction:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:button];
    }
}

- (void)clickFunction:(UIButton *)button{
    if([self.delgate respondsToSelector:@selector(clickFunction:)]){
        [self.delgate clickFunction:button.tag];
    }
}

@end
