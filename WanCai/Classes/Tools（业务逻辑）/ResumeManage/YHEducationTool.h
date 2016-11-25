//
//  YHEducationTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;
@class YHReturnMsg;

@interface YHEducationTool : NSObject

/**
 *  根据简历id获取教育经历数据列表
 *
 *  @param block    供数据返回
 *  @param resumeId 简历id
 */
+ (void)getEducationList:(void (^)(YHResultItem *result))block withResumeId:(NSString *)resumeId;

/**
 *  根据教育经历id获取教育经历详细内容数据接口
 *
 *  @param block    供数据返回
 *  @param eduId    教育经历id
 */
+ (void)getEducationInfo:(void (^)(YHResultItem *result))block withEduId:(NSString *)eduId;

/**
 *  添加教育经历
 *
 *  @param block      <#block description#>
 *  @param resumeId   <#resumeId description#>
 *  @param startDate  <#startDate description#>
 *  @param endDate    <#endDate description#>
 *  @param schoolName <#schoolName description#>
 *  @param major      <#major description#>
 *  @param degree     <#degree description#>
 */
+ (void)addEducation:(void (^)(YHReturnMsg *result))block
        withResumeId:(NSString *)resumeId
           startDate:(NSString *)startDate
             endDate:(NSString *)endDate
          schoolName:(NSString *)schoolName
               major:(NSString *)major
              degree:(NSString *)degree;

/**
 *  删除教育经历
 *
 *  @param block    <#block description#>
 *  @param eduId    <#eduId description#>
 *  @param resumeId <#resumeId description#>
 */
+ (void)deleteEducation:(void (^)(YHReturnMsg *result))block withEduId:(NSString *)eduId resumeId:(NSString *)resumeId;

/**
 *  根据教育经历Id修改教育经历数据
 *
 *  @param block      <#block description#>
 *  @param eduId      <#eduId description#>
 *  @param startdate  <#startdate description#>
 *  @param schoolName <#schoolName description#>
 *  @param major      <#major description#>
 *  @param degree     <#degree description#>
 */
+ (void)updateEduInfoByEduId:(void (^)(YHReturnMsg *result))block
                   withEduId:(NSString *)eduId
                   startdate:(NSString *)startdate
                   schoolName:(NSString *)schoolName
                   major:(NSString *)major
                   degree:(NSString *)degree;
@end
