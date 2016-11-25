//
//  YHAttentionToMeCommpanyTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;

@interface YHAttentionToMeCommpanyTool : NSObject

/**
 *  获取查看我简历的企业数据列表
 *
 *  @param block     供数据返回
 *  @param userId    用户id
 *  @param pagesize  页面展示数据条数
 *  @param pageindex 当前页的索引，从1开始计算
 */
+ (void)getAttentionToMeCommpanyList:(void (^)(YHResultItem *result))block
               withuserId:(NSString *)userId
                 pagesize:(NSNumber *)pagesize
                pageindex:(NSNumber *)pageindex;

@end
