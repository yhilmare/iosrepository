//
//  YHTabBar.h
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHTabBar;

@protocol YHTabBarDelegate <NSObject>

@optional

- (void)tabBar:(YHTabBar *)tabBar didSelectedIndex:(NSInteger)selectedIndex;
- (void)tabBarDidClickAddBtn:(YHTabBar *)tabBar;

@end

@interface YHTabBar : UIView

@property (nonatomic, weak) id<YHTabBarDelegate> delegate;

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@end
