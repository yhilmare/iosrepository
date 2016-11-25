//
//  YHJobApplyTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;

@interface YHJobApplyTool : NSObject

/**
 *  申请记录查询接口（只可查询到近2个月内的记录）
 *
 *  @param block     供数据返回
 *  @param userId    用户id
 *  @param pagesize  页面展示数据条数
 *  @param pageindex 当前页的索引，从1开始计算
 */
+ (void)getMyJobApplyList:(void (^)(YHResultItem *result))block
                  withuserId:(NSString *)userId
                    pagesize:(NSString *)pagesize
                   pageindex:(NSString *)pageindex;

@end
