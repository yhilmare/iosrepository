//
//  YHUserInfo.h
//  WanCai
//
//  Created by abing on 16/7/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHUserInfo : NSObject <NSCoding>

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, copy) NSString *marriage;

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, copy) NSString *degree;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSString *workYear;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *userId;

- (instancetype) initWithDictionary:(NSDictionary *)dic;

+ (instancetype) yhUserInfoWithDictionary:(NSDictionary *)dic;

@end
