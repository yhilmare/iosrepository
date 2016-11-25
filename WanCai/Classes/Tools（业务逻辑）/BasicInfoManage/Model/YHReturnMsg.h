//
//  YHReturnMsg.h
//  WanCai
//
//  Created by CheungKnives on 16/7/8.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHReturnMsg : NSObject<MJKeyValue>

/**
 *  返回结果，true成功，falese失败
 */
@property (nonatomic, copy) NSString *result;

/**
 *  返回提示信息
 */
@property (nonatomic, copy) NSString *msg;

@end
