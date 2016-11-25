//
//  YHSettingItem.h
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^YHSettingItemOption)();

@interface YHSettingItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) YHSettingItemOption option;

@property (nonatomic, assign) Class descVc;

+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image;

@end
