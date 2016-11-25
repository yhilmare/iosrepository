//
//  YHWorkExperience.h
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHWorkExperience : NSObject<MJKeyValue>

/**
 *  id
 */
@property (nonatomic, copy) NSString *WorkId;
/**
 *  工作开始时间
 */
@property (nonatomic, copy) NSString *StartDate;
/**
 *  工作结束时间
 */
@property (nonatomic, copy) NSString *EndDate;
/**
 *  企业名称
 */
@property (nonatomic, copy) NSString *CompanyName;
/**
 *  企业性质编号
 */
@property (nonatomic, copy) NSString *CompanyNature;
/**
 *  企业规模编号
 */
@property (nonatomic, copy) NSString *CompanySize;
/**
 *  企业所属行业编号
 */
@property (nonatomic, copy) NSString *CompanyIndustry;
/**
 *  企业所属行业名称
 */
@property (nonatomic, copy) NSString *IndustryName;
/**
 *  担任职位
 */
@property (nonatomic, copy) NSString *SubFunction;
/**
 *  工作描述
 */
@property (nonatomic, copy) NSString *Responsiblity;

@end
