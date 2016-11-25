//
//  YHWorkExperienceTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;
@class YHReturnMsg;

@interface YHWorkExperienceTool : NSObject

/**
 *  获取工作经历数据接
 *
 *  @param block    供数据返回
 *  @param resumeId 简历id
 */
+ (void)getWorkExperienceList:(void (^)(YHResultItem *result))block withResumeId:(NSString *)resumeId;

/**
 *  根据工作经历Id获取工作经历详细内容数据接口
 *
 *  @param block  提供数据返回
 *  @param workId 工作经历id
 */
+ (void)getWorkExperienceInfo:(void (^)(YHResultItem *result))block withWorkId:(NSString *)workId;

/**
 *  添加工作经历
 *
 *  @param block           <#block description#>
 *  @param resumeId        <#resumeId description#>
 *  @param startdate       <#startdate description#>
 *  @param enddate         <#enddate description#>
 *  @param companyName     <#companyName description#>
 *  @param companyNature   <#companyNature description#>
 *  @param companySize     <#companySize description#>
 *  @param companyIndustry <#companyIndustry description#>
 *  @param subFunction     <#subFunction description#>
 *  @param responsiblity   <#responsiblity description#>
 */
+ (void)addWorkExperience:(void (^)(YHReturnMsg *result))block
             withResumeId:(NSString *)resumeId
                startdate:(NSString *)startdate
                  enddate:(NSString *)enddate
              companyName:(NSString *)companyName
            companyNature:(NSString *)companyNature
              companySize:(NSString *)companySize
          companyIndustry:(NSString *)companyIndustry
              subFunction:(NSString *)subFunction
            responsiblity:(NSString *)responsiblity;

/**
 *  删除工作经历
 *
 *  @param block    <#block description#>
 *  @param workId   <#workId description#>
 *  @param resumeId <#resumeId description#>
 */
+ (void)deleteWorkExperice:(void (^)(YHReturnMsg *result))block withWorkId:(NSString *)workId resumeId:(NSString *)resumeId;

+ (void)updateWorkExperience:(void (^)(YHReturnMsg *result))block
             withWorkId:(NSString *)workId
                startdate:(NSString *)startdate
                  enddate:(NSString *)enddate
              companyName:(NSString *)companyName
            companyNature:(NSString *)companyNature
              companySize:(NSString *)companySize
          companyIndustry:(NSString *)companyIndustry
              subFunction:(NSString *)subFunction
            responsiblity:(NSString *)responsiblity;
@end
