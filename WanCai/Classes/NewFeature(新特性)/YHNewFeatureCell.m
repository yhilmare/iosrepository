//
//  YHNewFeatureCell.m
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHNewFeatureCell.h"
#import "YHTabBarController.h"

@interface YHNewFeatureCell()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIButton *startButton;

@end

@implementation YHNewFeatureCell

- (UIButton *)startButton {
    if (_startButton == nil) {
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn setTitle:@"开始使用" forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [startBtn sizeToFit];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startBtn];
        _startButton = startBtn;
        
    }
    return _startButton;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        
        _imageView = imageV;
        
        // 注意:一定要加载contentView
        [self.contentView addSubview:imageV];
        
    }
    return _imageView;
}

// 布局子控件的frame
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    // 开始按钮
    self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.9 - 20);
    [self.startButton.layer setMasksToBounds:YES];
    [self.startButton.layer setCornerRadius:5]; //设置矩形四个圆角半径
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = image;
}

// 判断当前cell是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count {
    if (indexPath.row == count - 1) { // 最后一页,显示分享和开始按钮
        self.startButton.hidden = NO;
        
    }else{ // 非最后一页，隐藏分享和开始按钮
        self.startButton.hidden = YES;
    }
}

// 点击开始的时候调用
- (void)start {
    // 进入tabBarVc
    YHTabBarController *tabBarVc = [[YHTabBarController alloc] init];
    
    // 切换根控制器:可以直接把之前的根控制器清空
    YHKeyWindow.rootViewController = tabBarVc;
    
}


@end
