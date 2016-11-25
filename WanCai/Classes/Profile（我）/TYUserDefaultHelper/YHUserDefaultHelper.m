//
//  YHUserDefaultHelper.m
//  WanCai
//
//  Created by 段昊宇 on 16/7/17.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHUserDefaultHelper.h"

/*
 YHProfileInfomationName = 0,
 YHProfileInfomationSex,
 YHProfileInfomationMaritalStatus,
 YHProfileInfomationBirthday,
 YHProfileInfomationEducate,
 YHProfileInfomationLocation,
 YHProfileInfomationWorkTime,
 YHProfileInfomationPhone,
 YHProfileInfomationEmail
 */

@interface YHUserDefaultHelper()

@end

@implementation YHUserDefaultHelper

#pragma mark - Save Data
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
                                   email: (NSString *)email {
    
    /**
     @author Desgard_Duan, 2016-07-17
     如果主要的三个字段为空
     直接返回，不进行存储
     */
    if (!userName || !password || !userId) return ;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setObject: userName forKey: @"userName"];
    [user setObject: password forKey: @"password"];
    [user setObject: userId forKey: @"userId"];
    
    if (name) {
        [user setObject: name forKey: @"name"];
    }
    
    if (sex) {
        [user setObject: sex forKey: @"gender"];
    }
    
    if (maritalStatus) {
        [user setObject: maritalStatus forKey: @"marriage"];
    }
    
    if (birthday) {
        [user setObject: birthday forKey: @"birthday"];
    }
    
    if (educate) {
        [user setObject: educate forKey: @"degree"];
    }
    
    if (workTime) {
        [user setObject: workTime forKey: @"workYear"];
    }
    
    if (phone) {
        [user setObject: phone forKey: @"mobile"];
    }
    
    if (email) {
        [user setObject: email forKey: @"email"];
    }
    if (location) {
        [user setObject: email forKey: @"location"];
    }
    
}

+ (void) saveUserDefaultDataWithUserName: (NSString *)userName
                                password: (NSString *)password
                                  userId: (NSString *)userId {
    [self saveUserDefaultDataWithUserName: userName password: password userId: userId name: nil sex: nil maritalStatus: nil birthday: nil educate: nil location: nil workTime: nil phone: nil email: nil];
}

#pragma mark - Read Data
+ (NSMutableDictionary *) readUserDefaultData {
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    NSString *userName = [userDefaultes stringForKey: @"userName"];
    NSString *password = [userDefaultes stringForKey: @"password"];
    NSString *userId = [userDefaultes stringForKey: @"userId"];
    NSString *name = [userDefaultes stringForKey: @"name"];
    NSString *sex = [userDefaultes stringForKey: @"gender"];
    NSString *maritalStatus = [userDefaultes stringForKey: @"marriage"];
    NSString *birthday = [userDefaultes stringForKey: @"birthday"];
    NSString *educate = [userDefaultes stringForKey: @"degree"];
    NSString *workTime = [userDefaultes stringForKey: @"workYear"];
    NSString *phone = [userDefaultes stringForKey: @"mobile"];
    NSString *email = [userDefaultes stringForKey: @"email"];
    NSString *location = [userDefaultes stringForKey: @"location"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys: userName, @"userName",
                                                                                  password, @"password",
                                                                                  userId, @"userId",
                                                                                  name, @"name",
                                                                                  sex, @"gender",
                                                                                  maritalStatus, @"marriage",
                                                                                  birthday, @"birthday",
                                                                                  educate, @"degree",
                                                                                  workTime, @"workYear",
                                                                                  phone, @"mobile",
                                                                                  email, @"email",
                                                                                  location, @"location", nil];
    return dic;
}

+ (NSMutableDictionary *) readUserMainMsg {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userName = [userDefaults stringForKey:@"userName"];
    NSString *password = [userDefaults stringForKey:@"password"];
    NSString *uiserId = [userDefaults stringForKey:@"userId"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys: userName, @"userName",password, @"password", uiserId, @"userId", nil];
    return dic;
}

#pragma mark - 检测登录
+ (BOOL) isLogin {
    NSDictionary *logDic = [self readUserDefaultData];
    
    return YES;
}

@end
