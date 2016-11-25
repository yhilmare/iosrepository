//
//  YHTrainExperiencTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;
@class YHReturnMsg;

@interface YHTrainExperiencTool : NSObject

/**
 *  获取培训经历列表数据接口
 *
 *  @param block    供数据返回
 *  @param resumeId 简历id
 */
+ (void)getTrainExperienceList:(void (^)(YHResultItem *result))block withResumeId:(NSString *)resumeId;

/**
 *  根据培训经历id获取培训经历的详细内容接口
 *
 *  @param block   供数据返回
 *  @param trainId 培训经历id
 */
+ (void)getTainInfo:(void (^)(YHResultItem *result))block withTrainId:(NSString *)trainId;

/**
 *  添加培训经历
 *
 *  @param block       <#block description#>
 *  @param startdate   <#startdate description#>
 *  @param enddate     <#enddate description#>
 *  @param trainOrg    <#trainOrg description#>
 *  @param className   <#className description#>
 *  @param description <#description description#>
 */
+ (void)addTrainExperience:(void (^)(YHReturnMsg *result))block
              withResumeId:(NSString *)resumeId
                 startdate:(NSString *)startdate
                   enddate:(NSString *)enddate
                  trainOrg:(NSString *)trainOrg
                 className:(NSString *)className
               description:(NSString *)description;

/**
 *  删除培训经历
 *
 *  @param block    <#block description#>
 *  @param resumeId <#resumeId description#>
 *  @param trainId  <#trainId description#>
 */
+ (void)deletetrainExperience:(void (^)(YHReturnMsg *result))block withResumeId:(NSString *)resumeId trainId:(NSString *)trainId;

/**
 *  修改培训经历数据
 *
 *  @param block       <#block description#>
 *  @param trainId     <#trainId description#>
 *  @param startdate   <#startdate description#>
 *  @param enddate     <#enddate description#>
 *  @param trainOrg    <#trainOrg description#>
 *  @param className   <#className description#>
 *  @param description <#description description#>
 */
+ (void)updateTrainExperience:(void (^)(YHReturnMsg *result))block
              withTrainId:(NSString *)trainId
                 startdate:(NSString *)startdate
                   enddate:(NSString *)enddate
                  trainOrg:(NSString *)trainOrg
                 className:(NSString *)className
               description:(NSString *)description;
@end
