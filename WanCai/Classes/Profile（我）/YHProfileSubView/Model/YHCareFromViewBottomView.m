//
//  YHCareFromViewBottomView.m
//  WanCai
//
//  Created by abing on 16/7/22.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHCareFromViewBottomView.h"

@interface YHCareFromViewBottomView ()

@property (nonatomic, strong) UIButton *shareButton;

@end

@implementation YHCareFromViewBottomView


- (UIButton *)shareButton{
    if(!_shareButton){
        
        _shareButton = [[UIButton alloc] init];
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat itemWidth = width * 0.45;
        CGFloat itemHeight = self.frame.size.height * 0.8;
        CGFloat x = (width - itemWidth) / 2.0;
        CGFloat y = (self.frame.size.height - itemHeight) / 2.0;
        
        _shareButton.frame = CGRectMake(x, y, itemWidth, itemHeight);
        _shareButton.layer.cornerRadius = 3;
        _shareButton.layer.masksToBounds = YES;
        
        width = _shareButton.frame.size.width * 0.6;
        CGFloat height = _shareButton.frame.size.height * 0.7;
        x = (_shareButton.frame.size.width - width) / 2.0;
        y = (_shareButton.frame.size.height - height) / 2.0;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        width = view.frame.size.width * 0.6;
        height = view.frame.size.height * 1;
        x = view.frame.size.width * 0.31;
        y = (view.frame.size.height - height) / 2.0;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        label.text = @"查看简历";
        [label setTextColor:[UIColor whiteColor]];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        [view addSubview:label];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toujianli.png"]];
        CGFloat heightAngWidth = view.frame.size.height * 0.8;
        y = (view.frame.size.height - heightAngWidth) / 2.0;
        x = view.frame.size.width * 0.09;
        imageView.frame = CGRectMake(x, y, heightAngWidth, heightAngWidth);
        [view addSubview:imageView];
        view.userInteractionEnabled = NO;
        [_shareButton addSubview:view];
        [_shareButton setBackgroundColor:[UIColor colorWithRed:0 green:175/255.0 blue:240/255.0 alpha:1]];
        
        [_shareButton addTarget:self action:@selector(clickFunction:) forControlEvents:UIControlEventTouchUpInside];
        [_shareButton addTarget:self action:@selector(tounchDown:) forControlEvents:UIControlEventTouchDown];
    }
    return _shareButton;
}
- (void)clickFunction: (UIButton *) button{
    
    if([self.delgate respondsToSelector:@selector(didClickButton:)]){
        [self.delgate didClickButton:button];
    }
}

- (void) tounchDown: (UIButton *)button{
    
    [button setBackgroundColor:[UIColor colorWithRed:0/255.0 green:104/255.0 blue:143/255.0 alpha:1]];
    
}

- (instancetype) initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.shareButton];
    }
    return self;
}


@end
