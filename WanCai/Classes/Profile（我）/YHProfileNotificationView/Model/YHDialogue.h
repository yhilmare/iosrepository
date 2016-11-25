//
//  YHDialogue.h
//  WanCai
//
//  Created by yh_swjtu on 16/8/4.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHDialogue : NSObject

@property (nonatomic, assign, getter=isShowTime) BOOL ShowTime;

@property (nonatomic, assign)NSInteger viewTag;

@property (nonatomic, copy) NSString *iconName;

@property (nonatomic, copy) NSString *comName;

@property (nonatomic, copy) NSString *detailMsg;

@property (nonatomic, copy) NSString *date;

+ (instancetype) getObjectWithDictionary:(NSDictionary *) dic;

@end
