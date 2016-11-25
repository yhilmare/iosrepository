//
//  YHLanguageAbilityTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;
@class YHReturnMsg;

@interface YHLanguageAbilityTool : NSObject

/**
 *  获取语言能力数据列表接口
 *
 *  @param block   供数据返回
 *  @param resumeId 简历id
 */
+ (void)getLanguageAbilityList:(void (^)(YHResultItem *result))block withResumeId:(NSString *)resumeId;

/**
 *  根据语言能力id获取详细内容接口
 *
 *  @param block      供数据返回
 *  @param languageId 语言能力id
 */
+ (void)getLanguageAbilityInfo:(void (^)(YHResultItem *result))block withLanguageId:(NSString *)languageId;

/**
 *  添加语言能力
 *
 *  @param block          <#block description#>
 *  @param resumeId       <#resumeId description#>
 *  @param languageType   <#languageType description#>
 *  @param languageMaster <#languageMaster description#>
 *  @param rwability      <#rwability description#>
 *  @param lsability      <#lsability description#>
 */
+ (void)addLanguageAbility:(void (^)(YHReturnMsg *result))block
              withResumeId:(NSString *)resumeId
              languageType:(NSString *)languageType
            languageMaster:(NSString *)languageMaster
                 rwability:(NSString *)rwability
                 lsability:(NSString *)lsability;
/**
 *  删除语言能力
 *
 *  @param block      <#block description#>
 *  @param languageId <#languageId description#>
 *  @param resumeId   <#resumeId description#>
 */
+ (void)deletLanguageAbility:(void (^)(YHReturnMsg *result))block
              withLanguageId:(NSString *)languageId
                    resumeId:(NSString *)resumeId;
@end
