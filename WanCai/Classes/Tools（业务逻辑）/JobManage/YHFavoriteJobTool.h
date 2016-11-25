//
//  YHFavoriteJobTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;

@interface YHFavoriteJobTool : NSObject

/**
 *  获取个人职位收藏夹的数据列表接口
 *
 *  @param block     供数据返回
 *  @param userId    用户id
 *  @param pagesize  页面展示数据条数
 *  @param pageindex 当前页的索引，从1开始计算
 *  @param keywords  按照关键字搜索（职位名称或公司名称）
 */
+ (void)getMyJobFavoriteList:(void (^)(YHResultItem *result))block
                  withuserId:(NSString *)userId
                    pagesize:(NSNumber *)pagesize
                   pageindex:(NSNumber *)pageindex
                    keywords:(NSString *)keywords;

@end
