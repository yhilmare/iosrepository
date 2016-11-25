//
//  YHAnswerModel.h
//  WanCai
//
//  Created by abing on 16/9/15.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHAnswerModel : NSObject

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *iconName;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, strong) NSArray *answers;

+ (instancetype) modelWithDic:(NSDictionary *) dic;

@end
