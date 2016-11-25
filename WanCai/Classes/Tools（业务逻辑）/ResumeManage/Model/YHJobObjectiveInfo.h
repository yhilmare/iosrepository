//
//  YHJobObjectiveInfo.h
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHJobObjectiveInfo : NSObject<MJKeyValue>

/**
 *  id
 */
@property (nonatomic, copy) NSString *ObjectiveId;
/**
 *  简历id
 */
@property (nonatomic, copy) NSString *ResumeId;
/**
 *  期望行业编号
 */
@property (nonatomic, copy) NSString *ExpectIndustryType;
/**
 *  期望职位编号
 */
@property (nonatomic, copy) NSString *ExpectJob;
/**
 *  期望工作地点编号
 */
@property (nonatomic, copy) NSString *ExpectLocation;
/**
 *  工作性质编码
 */
@property (nonatomic, copy) NSString *JobNature;
/**
 *  期望薪资编码
 */
@property (nonatomic, copy) NSString *ExpectSalary;
/**
 *  创建时间
 */
@property (nonatomic, copy) NSString *CreateDate;

@end
