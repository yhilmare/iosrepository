//
//  YHSettingItem.m
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHSettingItem.h"

@implementation YHSettingItem

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image {
    YHSettingItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    return item;
}
+ (instancetype)itemWithTitle:(NSString *)title {
    YHSettingItem *item = [self itemWithTitle:title image:nil];
    return item;
}

@end
