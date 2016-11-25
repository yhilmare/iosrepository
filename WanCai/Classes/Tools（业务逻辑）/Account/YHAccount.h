//
//  YHAccount.h
//  WanCai
//
//  Created by CheungKnives on 16/6/7.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

/*  字段	说明
 result	返回结果，True:成功,false：失败
 msg	返回提示信息
 userId	用户id
 */


@interface YHAccount : NSObject<NSCoding,MJKeyValue>

/**
 *  获取成功之后的结果 result
 */
@property (nonatomic, copy) NSString *result;
/**
 *  返回的提示信息 msg
 */
@property (nonatomic, copy) NSString *msg;
/**
 *  返回的用户userId
 */
@property (nonatomic, copy) NSString *userId;
/**
 *  用户名字
 */
@property (nonatomic, copy) NSString *UserName;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
