//
//  YHButtomView.m
//  WanCai
//
//  Created by abing on 16/7/16.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHButtomView.h"

@interface YHButtomView()

@property (nonatomic, strong) UIButton *shareButton;


@end

@implementation YHButtomView

- (CGRect) calculateFramUtils: (CGFloat) itemWidthPercent
                   itemHeight: (CGFloat) itemHeightPercent
                        itemY: (CGFloat) itemY
                        itemX: (CGFloat) itemX{
    
    CGRect viewFrame = self.frame;
    CGFloat viewWidth = viewFrame.size.width;
    CGFloat viewHeight = viewFrame.size.height;
    CGFloat itemWidth = itemWidthPercent * viewWidth;
    CGFloat itemHeight = itemHeightPercent * viewHeight;
    
    CGFloat x = viewWidth * itemX;
    CGFloat y = itemY * (viewHeight - itemHeight);
    CGRect rect = CGRectMake(x, y, itemWidth, itemHeight);
    return rect;
}


- (UIButton *)shareButton{
    if(!_shareButton){
        _shareButton = [[UIButton alloc] init];
        _shareButton.tag = 0;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat itemWidth = (width / 2.0) * 0.9;
        CGFloat margin = ((width / 2.0) - itemWidth) / 2.0;
        
        _shareButton.frame = [self calculateFramUtils:0.45 itemHeight:0.8 itemY:0.5 itemX:(margin + 5) / width];
        _shareButton.layer.cornerRadius = 3;
        _shareButton.layer.masksToBounds = YES;
        
        width = _shareButton.frame.size.width * 0.6;
        CGFloat height = _shareButton.frame.size.height * 0.7;
        CGFloat x = (_shareButton.frame.size.width - width) / 2.0;
        CGFloat y = (_shareButton.frame.size.height - height) / 2.0;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        width = view.frame.size.width * 0.6;
        height = view.frame.size.height * 1;
        x = view.frame.size.width * 0.31;
        y = (view.frame.size.height - height) / 2.0;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        label.text = @"投递简历";
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

- (UIButton *)collectButton{
    if(!_collectButton){
        _collectButton = [[UIButton alloc] init];
        _collectButton.tag = 1;
        [_collectButton setBackgroundColor:[UIColor colorWithRed:66 / 255.0 green:200/255.0 blue:125/255.0 alpha:1]];
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat itemWidth = (width / 2.0) * 0.9;
        CGFloat margin = ((width / 2.0) - itemWidth) / 2.0;
        margin += (width / 2.0);

        _collectButton.frame = [self calculateFramUtils:0.45 itemHeight:0.8 itemY:0.5 itemX:(margin - 5) / width];
        _collectButton.layer.cornerRadius = 3;
        _collectButton.layer.masksToBounds = YES;
        
        width = _collectButton.frame.size.width * 0.6;
        CGFloat height = _collectButton.frame.size.height * 0.7;
        CGFloat x = (_collectButton.frame.size.width - width) / 2.0;
        CGFloat y = (_collectButton.frame.size.height - height) / 2.0;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        
        width = view.frame.size.width * 0.4;
        height = view.frame.size.height * 1;
        x = view.frame.size.width * 0.41;
        y = (view.frame.size.height - height) / 2.0;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        label.text = @"收藏";
        [label setTextColor:[UIColor whiteColor]];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        
        [view addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shoucang.png"]];
        //[imageView setBackgroundColor:[UIColor blueColor]];
        CGFloat heightAngWidth = view.frame.size.height * 0.8;
        y = (view.frame.size.height - heightAngWidth) / 2.0;
        x = view.frame.size.width * 0.19;
        imageView.frame = CGRectMake(x, y, heightAngWidth, heightAngWidth);
        [view addSubview:imageView];
        view.userInteractionEnabled = NO;
        [_collectButton addSubview:view];
        [_collectButton addTarget:self action:@selector(clickFunction:) forControlEvents:UIControlEventTouchUpInside];
        [_collectButton addTarget:self action:@selector(tounchDown:) forControlEvents:UIControlEventTouchDown];
    }
    return _collectButton;
}

- (void)clickFunction: (UIButton *) button{
    if([self.delgate respondsToSelector:@selector(didClickButton:)]){
        [self.delgate didClickButton:button];
    }
}

- (void) tounchDown: (UIButton *)button{
    if(button.tag == 0){
        [button setBackgroundColor:[UIColor colorWithRed:0/255.0 green:104/255.0 blue:143/255.0 alpha:1]];
    }else if (button.tag == 1){
        [button setBackgroundColor:[UIColor colorWithRed:26 / 255.0 green:162 / 255.0 blue:96 / 255.0 alpha:1]];
    }
}

- (instancetype) initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.shareButton];
        [self addSubview:self.collectButton];
    }
    return self;
}


@end
