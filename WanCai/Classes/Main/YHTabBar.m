//
//  YHTabBar.m
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHTabBar.h"
#import "YHTabBarButton.h"

@interface YHTabBar()

@property (nonatomic, strong) NSMutableArray *tabBarbuttons;
@property (nonatomic, strong) UIButton *selctedButton;

@end

@implementation YHTabBar

- (NSMutableArray *)tabBarbuttons {
    if (_tabBarbuttons == nil) {
        _tabBarbuttons = [NSMutableArray array];
    }
    return _tabBarbuttons;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item {
    
    YHTabBarButton *button = [YHTabBarButton buttonWithType:UIButtonTypeCustom];
    
    button.item = item;
    
    // 监听按钮点击
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    button.tag = self.tabBarbuttons.count;
    
    if (self.tabBarbuttons.count == 0) {
        [self btnClick:button];
    }
    
    [self addSubview:button];
    
    [self.tabBarbuttons addObject:button];
}


- (void)btnClick:(UIButton *)button {
    _selctedButton.selected = NO;
    button.selected = YES;
    _selctedButton = button;
    
    
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectedIndex:)]) {
        [_delegate tabBar:self didSelectedIndex:button.tag];
    }
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置内部按钮的位置
    [self setUpAllTabBarButtonFrame];
}

- (void)setUpAllTabBarButtonFrame {
    NSInteger i = 0;
    NSInteger count = self.tabBarbuttons.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    
    for (UIView *tabBarButton in self.tabBarbuttons) {
        tabBarButton.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        i++;
    }
}


@end
