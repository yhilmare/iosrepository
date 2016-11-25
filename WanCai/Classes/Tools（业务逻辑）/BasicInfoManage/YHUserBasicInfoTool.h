//
//  YHUserBasicInfoTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;
@class YHReturnMsg;

@interface YHUserBasicInfoTool : NSObject

/**
 *  根据用户Id获取该用户的基本信息
 *
 */
+ (void)getUserBasicInfo:(void (^)(YHResultItem *result))block withuserId:(NSString *)userId;

/**
 *  修改密码
 *
 */
+ (void)updatePassword:(void (^)(YHReturnMsg *result))block withUserName:(NSString *)userName oldPwd:(NSString *)oldpwd newPwd:(NSString *)newpwd;

/**
 *  修改基本信息
 *
 */
+ (void)updateUserBasicInfo:(void (^)(YHReturnMsg *result))block
                 withuserId:(NSString *)userId
                   userName:(NSString *)userName
                     gender:(NSString *)gender
                   marriage:(NSString *)marriage
                   birthday:(NSString *)birthday
                     degree:(NSString *)degree
                   workyear:(NSString *)workyear
                     mobile:(NSString *)mobile
                      email:(NSString *)email
                   location:(NSString *)location;

/**
 *  上传头像
 *
 */
+ (void)uploadLogo:(void (^)(YHReturnMsg *result))block withuserId:(NSString *)userId path:(NSString *)path;

@end
