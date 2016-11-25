//
//  UIBarButtonItem+YHItem.h
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YHItem)

/**
 *  给按钮设置图片及触发事件
 *
 *  @param imageName     图片名称
 *  @param highImageName 高亮图片名称
 *  @param target        target
 *  @param action        action
 *
 *  @return UIBarButtonItem
 */
+ (instancetype)barButtonItemWithImage:(NSString *)imageName highImage:(NSString *)highImageName target:(id)target action:(SEL)action;

@end
