//
//  YHJobObjectiveTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;
@class YHReturnMsg;

@interface YHJobObjectiveTool : NSObject

/**
 *  根据简历id获取求职意向基本信息数据
 *
 *  @param block    供数据返回
 *  @param resumeId 简历id
 */
+ (void)getJobObjectiveInfo:(void (^)(YHResultItem *result))block withResumeId:(NSString *)resumeId;

/**
 *  修改求职意向
 *
 *  @param block              <#block description#>
 *  @param resumeId           <#resumeId description#>
 *  @param expectIndustryType <#expectIndustryType description#>
 *  @param expectjob          <#expectjob description#>
 *  @param expectlocation     <#expectlocation description#>
 *  @param jobnature          <#jobnature description#>
 *  @param expectSalary       <#expectSalary description#>
 */
+ (void)updateJobObjective:(void (^)(YHReturnMsg *result))block
              withResumeId:(NSString *)resumeId
        expectIndustryType:(NSString *)expectIndustryType
                 expectjob:(NSString *)expectjob
            expectlocation:(NSString *)expectlocation
                 jobnature:(NSString *)jobnature
              expectSalary:(NSString *)expectSalary;

@end
