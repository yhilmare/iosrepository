//
//  YHJobsTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;
@class YHReturnMsg;

@interface YHJobsTool : NSObject

/**
 *  根据条件获取最新职位列表
 *
 *  @param block            返回数据
 *  @param pagesize         每页显示条数
 *  @param pageindex        页码，从1开始
 *  @param industryId       所属行业id
 *  @param jobFunctionId    职位职能id
 *  @param workLocationId   城市id
 *  @param keywords         关键字
 *  @param degreeId         学历id
 *  @param workexperienceId 工作年限id
 *  @param salaryRangeId    薪资范围id
 *  @param jobNatureId      职位性质id
 */
+ (void)getJobs:(void (^)(YHResultItem *result))block
                            pagesize:(NSString *)pagesize
                           pageindex:(NSString *)pageindex
                          industryId:(NSString *)industryId
                       jobFunctionId:(NSString *)jobFunctionId
                      workLocationId:(NSString *)workLocationId
                            keywords:(NSString *)keywords
                            degreeId:(NSString *)degreeId
                    workexperienceId:(NSString *)workexperienceId
                       salaryRangeId:(NSString *)salaryRangeId
                         jobNatureId:(NSString *)jobNatureId;

/**
 *  根据id获取职位信息
 *
 *  @param block 返回数据
 *  @param jobId 职位id
 */
+ (void)getJobInfo:(void (^)(YHResultItem *result))block withJobId:(NSString *)jobId;

/**
 *  收藏职位
 *
 *  @param block  <#block description#>
 *  @param userId <#userId description#>
 *  @param jobIds <#jobIds description#>
 */
+ (void)addFavoriteJob:(void (^)(YHReturnMsg *result))block withuserId:(NSString *)userId jobIds:(NSString *)jobIds;

/**
 *  申请职位
 *
 *  @param block    <#block description#>
 *  @param userId   <#userId description#>
 *  @param jobIds   <#jobIds description#>
 *  @param resumeId <#resumeId description#>
 */
+ (void)applyJob:(void (^)(YHReturnMsg *result))block withuserId:(NSString *)userId jobIds:(NSString *)jobIds resumeId:(NSString *)resumeId;

/**
 *  删除收藏职位
 *
 *  @param block  <#block description#>
 *  @param userId <#userId description#>
 */
+ (void)deleteMyJobFavoriteById:(void (^)(YHReturnMsg *result))block withuserId:(NSString *)userId;

@end
