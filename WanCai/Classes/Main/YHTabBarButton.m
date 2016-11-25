//
//  YHTabBarButton.m
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHTabBarButton.h"
#import "YHBadgeView.h"

#define YHImageRatio 0.7
#define YHMargin 6

@interface YHTabBarButton ()

@property (nonatomic, weak) YHBadgeView *badgeView;

@end

@implementation YHTabBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:YHBlue forState:UIControlStateSelected];
        
    }
    return self;
}

- (UIButton *)badgeView {
    if (_badgeView == nil) {
        YHBadgeView *badgeView = [YHBadgeView buttonWithType:UIButtonTypeCustom];
        [self addSubview:badgeView];
        _badgeView = badgeView;
    }
    return _badgeView;
}

- (void)setItem:(UITabBarItem *)item {
    _item = item;
    
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
    [self setTitle:item.title forState:UIControlStateNormal];
    
    self.badgeView.badgeValue = item.badgeValue;
    if (self.badgeView.hidden == YES){
        [self.badgeView removeFromSuperview];
    }
    
    
    [_item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    self.badgeView.badgeValue = _item.badgeValue;
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
    [self setTitle:_item.title forState:UIControlStateNormal];
    
}

- (void)dealloc {
    [_item removeObserver:self forKeyPath:@"badgeValue"];
    [_item removeObserver:self forKeyPath:@"image"];
    [_item removeObserver:self forKeyPath:@"selectedImage"];
    [_item removeObserver:self forKeyPath:@"title"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnW = self.width;
    CGFloat btnH = self.height;
    CGFloat imageH = btnH * YHImageRatio;
    self.imageView.frame = CGRectMake(0, 0, btnW, imageH);
    
    CGFloat titleH = btnH - imageH;
    CGFloat titleY = imageH - 2;
    self.titleLabel.frame = CGRectMake(0, titleY, btnW, titleH);
    
    // 设置badgeView尺寸
    self.badgeView.x = self.width - self.badgeView.width - YHMargin;
    self.badgeView.y = 0;
}

- (void)setHighlighted:(BOOL)highlighted {//重写此方法，取消高亮事务
}


@end
