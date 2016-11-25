//
//  YHNavController.m
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHNavController.h"
#import "YHTabBar.h"
#import "UINavigationBar+YHAwesome.h"

@interface YHNavController()<UINavigationControllerDelegate>

@end

@implementation YHNavController
//第一次使用本类或者其他的子类的时候会调用
+ (void)initialize {
    if( self == [YHNavController class]){
        // 设置导航条的标题
        [self setUpNavBarTitle];
        
        // 设置导航条的按钮
        [self setUpNavBarButton];
    }
}

+ (void)setUpNavBarButton {
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置不可用状态下的按钮颜色
    NSMutableDictionary *disableDictM = [NSMutableDictionary dictionary];
    disableDictM[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:disableDictM forState:UIControlStateDisabled];
    
    NSMutableDictionary *normalDictM = [NSMutableDictionary dictionary];
    normalDictM[NSForegroundColorAttributeName] = [UIColor orangeColor];
    // 设置普通状态下的按钮颜色
    [item setTitleTextAttributes:normalDictM forState:UIControlStateNormal];
    
}

// 设置导航条的标题(颜色等等)
+ (void)setUpNavBarTitle {
    
    UINavigationBar *nav = [UINavigationBar appearanceWhenContainedIn:[YHNavController class], nil];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = YHNavgationBarTitleFont;
    dictM[NSForegroundColorAttributeName] = YHNavgationBarTitleColor;
    
    [nav setTitleTextAttributes:dictM];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.interactivePopGestureRecognizer.delegate = nil;
    self.delegate = self;
    [self.navigationBar yhSetBackgroundColor:YHBlue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count) { // 不是根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置导航条的按钮
        UIBarButtonItem *popPre = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_back" highImage:@"navigationbar_back_highlighted" target:self action:@selector(popToPre)];
        viewController.navigationItem.leftBarButtonItem = popPre;
        
        UIBarButtonItem *popRoot = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_more" highImage:@"navigationbar_more_highlighted" target:self action:@selector(popToRoot)];
        
        viewController.navigationItem.rightBarButtonItem = popRoot;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)popToRoot {
    [self popToRootViewControllerAnimated:YES];
}

- (void)popToPre {
    [self popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[YHTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
}


@end
