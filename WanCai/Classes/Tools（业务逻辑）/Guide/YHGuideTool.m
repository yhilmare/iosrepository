//
//  YHGuideTool.m
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHGuideTool.h"
#import "YHNewFeatureViewController.h"
#import "YHTabBarController.h"

#define YHVersionKey @"version"

@implementation YHGuideTool

+ (void)guideRootViewController:(UIWindow *)window {
    // 显示StatusBar，并且设置为白色状态
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // 1.获取当前的版本号
    NSString *verKey = (__bridge NSString *)kCFBundleVersionKey;
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[verKey];
    
    // 2.获取之前版本号
    NSString *oldVersion = [YHUserDefaults objectForKey:YHVersionKey];
    
    if ([currentVersion isEqualToString:oldVersion]) {
        //没有新的版本
        //创建tabBarVc
        YHTabBarController *tabBarVc = [[YHTabBarController alloc] init];
        
        //设置根控制器
        window.rootViewController = tabBarVc;
    }else{
        //有新版本。跳转到新特性界面
        YHNewFeatureViewController *vc = [[YHNewFeatureViewController alloc] init];
        
        window.rootViewController = vc;
        
        //保持当前的版本（偏好设置）
        [YHUserDefaults setObject:currentVersion forKey:YHVersionKey];
        [YHUserDefaults synchronize];
    }
    
}


@end
