//
//  YHResumeTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;
@class YHReturnMsg;
@class YHProfileResumeModel;

@interface YHResumeTool : NSObject

/**
 *  获取用户简历数据接口
 *
 *  @param block     供数据返回
 *  @param userId    用户id
 */
+ (void)getResumeList:(void (^)(YHResultItem *result))block withuserId:(NSString *)userId;
/**
 *  根据简历Id获取简历基本信息详细内容接口
 *
 *  @param block    供数据返回
 *  @param resumeId 简历id
 */
+ (void)getResumeBasicInfo:(void (^)(YHResultItem *result))block withResumeId:(NSString *)resumeId;

/**
 *  创建简历
 *
 *  @param block              <#block description#>
 *  @param userId             <#userId description#>
 *  @param resumeName         <#resumeName description#>
 *  @param userName           <#userName description#>
 *  @param gender             <#gender description#>
 *  @param marriage           <#marriage description#>
 *  @param birthday           <#birthday description#>
 *  @param degree             <#degree description#>
 *  @param workyear           <#workyear description#>
 *  @param mobile             <#mobile description#>
 *  @param email              <#email description#>
 *  @param location           <#location description#>
 *  @param policticalstatus   <#policticalstatus description#>
 *  @param seleveluation      <#seleveluation description#>
 *  @param expectIndustryType <#expectIndustryType description#>
 *  @param expectJob          <#expectJob description#>
 *  @param expectLocation     <#expectLocation description#>
 *  @param jobNature          <#jobNature description#>
 *  @param expectSalary       <#expectSalary description#>
 */
+ (void)createResume:(void (^)(YHReturnMsg *result))block
          withuserId:(NSString *)userId
          resumeName:(NSString *)resumeName
            userName:(NSString *)userName
              gender:(NSString *)gender
            marriage:(NSString *)marriage
            birthday:(NSString *)birthday
              degree:(NSString *)degree
            workyear:(NSString *)workyear
              mobile:(NSString *)mobile
               email:(NSString *)email
            location:(NSString *)location
    policticalstatus:(NSString *)policticalstatus
       seleveluation:(NSString *)seleveluation
  expectIndustryType:(NSString *)expectIndustryType
           expectJob:(NSString *)expectJob
      expectLocation:(NSString *)expectLocation
           jobNature:(NSString *)jobNature
        expectSalary:(NSString *)expectSalary;

/**
 @author SYYH, 2016-07-27
 
 根据model创建简历
 
 @param block    <#block description#>
 @param resumeId <#resumeId description#>
 */
+ (void)createResumeByModel: (YHProfileResumeModel *)dic calback: (void(^)(YHReturnMsg *))block;

/**
 *  根据简历Id删除简历
 *
 *  @param block    <#block description#>
 *  @param resumeId <#resumeId description#>
 */
+ (void)deleteResume:(void (^)(YHReturnMsg *result))block withResumeId:(NSString *)resumeId;

/** *  修改简历
 *
 *  @param block           <#block description#>
 *  @param resumeId        <#resumeId description#>
 *  @param resumeName      <#resumeName description#>
 *  @param userName        <#userName description#>
 *  @param gender          <#gender description#>
 *  @param marriage        <#marriage description#>
 *  @param birthday        <#birthday description#>
 *  @param degree          <#degree description#>
 *  @param location        <#location description#>
 *  @param workyear        <#workyear description#>
 *  @param mobile          <#mobile description#>
 *  @param email           <#email description#>
 *  @param politicalStatus <#politicalStatus description#>
 *  @param selfEvalation   <#selfEvalation description#>
 */
+ (void)updateResumeBasicInfo:(void (^)(YHReturnMsg *result))block
                 withResumeId:(NSString *)resumeId
                   resumeName:(NSString *)resumeName
                     userName:(NSString *)userName
                       gender:(NSString *)gender
                     marriage:(NSString *)marriage
                     birthday:(NSString *)birthday
                       degree:(NSString *)degree
                     location:(NSString *)location
                     workyear:(NSString *)workyear
                       mobile:(NSString *)mobile
                        email:(NSString *)email
              politicalStatus:(NSString *)politicalStatus
                selfEvalation:(NSString *)selfEvalation;

/**
 *  设置简历的公开程度(1:对所有公开，2：完全保密)
 *
 *  @param block    <#block description#>
 *  @param resumeId <#resumeId description#>
 *  @param privacy  <#privacy description#>
 */
+ (void)updateResumePrivacy:(void (^)(YHReturnMsg *result))block withResumeId:(NSString *)resumeId privacy:(NSString *)privacy;
@end
