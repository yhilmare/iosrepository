//
//  YHTabBarController.m
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHTabBarController.h"
#import "YHTabBar.h"
#import "YHNavController.h"
#import "YHHomeViewController.h"
#import "YHOpportunityViewController.h"
#import "YHDiscoveryViewController.h"
#import "YHProfileViewController.h"

@interface YHTabBarController ()<YHTabBarDelegate>

@property (nonatomic, weak) YHTabBar *customTabBar;

@property (nonatomic, weak) YHHomeViewController *home;
@property (nonatomic, strong) YHOpportunityViewController *opporyunity;
@property (nonatomic, strong) YHDiscoveryViewController *discovery;
@property (nonatomic, strong) YHProfileViewController *profile;

@property (nonatomic, assign) NSInteger selIndex;

@end

@implementation YHTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1.自定义tabBar
    [self setUpTabBar];
    
    // 2.添加子控制器
    [self setUpAllChildViewController];
}

//移除系统的button
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for (UIView *tabbarButton in self.tabBar.subviews) {
        if ([tabbarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarButton removeFromSuperview];
        }
    }
}

- (void)setUpTabBar {
    YHTabBar *tabBar = [[YHTabBar alloc] init];
    
    tabBar.frame = self.tabBar.bounds;
    tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    tabBar.delegate = self;
    
    [self.tabBar addSubview:tabBar];
    _customTabBar = tabBar;
}

- (void)setUpAllChildViewController {
//    ZZMessageViewController *message = [[ZZMessageViewController alloc] init];
//    [self setUpOneChildViewController:message imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected" title:@"信息"];
//    message.tabBarItem.badgeValue = @"1";
//    _message = message;

    // Home
    YHHomeViewController *home = [[YHHomeViewController alloc] init];
    [self setUpOneChildViewController:home imageName:@"tabbar_home" selectedImageName:@"tabbar_home_highlight" title:@"首页"];
    _home = home;
    
    // Opportunity
    YHOpportunityViewController *opportunity = [[YHOpportunityViewController alloc] init];
    [self setUpOneChildViewController:opportunity imageName:@"tabbar_opp" selectedImageName:@"tabbar_opp_highlight" title:@"机会"];
    _opporyunity = opportunity;
    
    // Discovery
    YHDiscoveryViewController *discovery = [[YHDiscoveryViewController alloc] init];
    [self setUpOneChildViewController:discovery imageName:@"tabbar_discovery" selectedImageName:@"tabbar_discovery_highlight" title:@"发现"];
    _discovery = discovery;
    
    // Profile
    YHProfileViewController *profile = [[YHProfileViewController alloc] init];
    [self setUpOneChildViewController:profile imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_highlight" title:@"我"];
    
}


- (void)setUpOneChildViewController:(UIViewController *)vc imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName title:(NSString *)title{// 添加一个控制器的属性
    vc.title = title;
    
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (iOS7) {
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    vc.tabBarItem.selectedImage = selectedImage;
    
    YHNavController *nav = [[YHNavController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
    [self.customTabBar addTabBarButtonWithItem:vc.tabBarItem];
    
}

#pragma mark - YHTabBar Delegate
- (void)tabBar:(YHTabBar *)tabBar didSelectedIndex:(NSInteger)selectedIndex{
    if (selectedIndex == 0 && selectedIndex == _selIndex ) { // 点击首页 刷新首页
        // 刷新数据
        //        [_home refresh];
    }
    
    self.selectedIndex = selectedIndex;
    
    _selIndex = selectedIndex;
}

@end
