//
//  YHTopicModel.h
//  WanCai
//
//  Created by abing on 16/9/14.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHTopicModel : NSObject

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *iconName;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *detailMsg;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *like;

@property (nonatomic, copy) NSString *comment;

+ (instancetype) modelWithDic:(NSDictionary *) dic;

@end
