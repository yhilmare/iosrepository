//
//  YHAccountTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/7.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHAccount;
@class YHAccountReturnMsg;

@interface YHAccountTool : NSObject

/**
 *  归档形式保存账号信息到YHAccountFile
 *
 *  @param account 账号Model
 */
+ (void)saveAccount:(YHAccount *)account;

/**
 *  获取当前账号信息
 *
 *  @return 返回YHAccount，若没有则返回nil
 */
+ (YHAccount *)account;

/**
 *  登录
 *
 *  @param block <#block description#>
 *  @param uName <#uName description#>
 *  @param pwd   <#pwd description#>
 */
+ (void)login:(void (^)(YHAccountReturnMsg *result))block WithUName:(NSString *)uName andPwd:(NSString *)pwd;

/**
 *  注册账号
 *
 *  @param uName <#uName description#>
 *  @param pwd   <#pwd description#>
 *  @param email <#email description#>
 */
+ (void)registerAccount:(void (^)(YHAccountReturnMsg *result))block WithUName:(NSString *)uName Pwd:(NSString *)pwd Email:(NSString *)email;

@end
