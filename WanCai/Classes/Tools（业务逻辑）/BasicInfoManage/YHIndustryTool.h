//
//  YHIndustryTool.h
//  WanCai
//
//  Created by CheungKnives on 16/7/8.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;

@interface YHIndustryTool : NSObject

/**
 *  获取行业分类
 *
 *  @param block <#block description#>
 */
+ (void)getIndustry:(void (^)(YHResultItem *result))block;

/**
 *  得到职位职能类别
 *
 *  @param block <#block description#>
 */
+ (void)getJobFunction:(void (^)(YHResultItem *result))block;

/**
 *  根据职能类别ID获取该类别下的职位职能数据
 *
 *  @param block        <#block description#>
 *  @param parentFuncId <#parentFuncId description#>
 */
+ (void)getJobFunction:(void (^)(YHResultItem *result))block withParentId:(NSString *)parentFuncId;


@end
