//
//  YHUserDefaultHelper.h
//  WanCai
//
//  Created by 段昊宇 on 16/7/17.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHUserDefaultHelper : NSObject

#pragma mark - 记录用户个人信息
+ (void) saveUserDefaultDataWithUserName: (NSString *)userName
                                password: (NSString *)password
                                  userId: (NSString *)userId
                                    name: (NSString *)name
                                     sex: (NSString *)sex
                           maritalStatus: (NSString *)maritalStatus
                                birthday: (NSString *)birthday
                                 educate: (NSString *)educate
                                location: (NSString *)location
                                workTime: (NSString *)workTime
                                   phone: (NSString *)phone
                                   email: (NSString *)email;

#pragma mark - 记录用户主要信息
+ (void) saveUserDefaultDataWithUserName: (NSString *)userName
                                password: (NSString *)password
                                  userId: (NSString *)userId;


#pragma mark - 读取用户个人信息
+ (NSMutableDictionary *) readUserDefaultData;

#pragma mark - 读取用户主要信息
+ (NSMutableDictionary *) readUserMainMsg;

#pragma mark - 判断登录状态
+ (BOOL) isLogin;
@end
