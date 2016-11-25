//
//  YHResumeBasicInfo.h
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHResumeBasicInfo : NSObject<MJKeyValue>

/**
 *  简历id
 */
@property (nonatomic, copy) NSString *ResumeId;
/**
 *  简历名称
 */
@property (nonatomic, copy) NSString *ResumeName;
/**
 *  用户id
 */
@property (nonatomic, copy) NSString *userId;
/**
 *  姓名
 */
@property (nonatomic, copy) NSString *UserName;
/**
 *  性别id
 */
@property (nonatomic, copy) NSString *GenderCode;
/**
 *  性别
 */
@property (nonatomic, copy) NSString *Gender;
/**
 *  婚姻状况
 */
@property (nonatomic, copy) NSString *MarrigeCode;
/**
 *  婚姻状况
 */
@property (nonatomic, copy) NSString *Marriage;
/**
 *  出生日期
 */
@property (nonatomic, copy) NSString *Birthday;
/**
 *  最高学历id
 */
@property (nonatomic, copy) NSString *HighDegreeCode;
/**
 *  最高学历
 */
@property (nonatomic, copy) NSString *HighDegree;
/**
 *  现居住城市id
 */
@property (nonatomic, copy) NSString *xjdLocaltionCode;
/**
 *  现居住城市
 */
@property (nonatomic, copy) NSString *xjdLocaltion;
/**
 *  工作年限id
 */
@property (nonatomic, copy) NSString *WorkYearsCode;
/**
 *  工作年限
 */
@property (nonatomic, copy) NSString *WorkYears;
/**
 *  政治面貌id
 */
@property (nonatomic, copy) NSString *PoliticalStatusCode;
/**
 *  政治面貌
 */
@property (nonatomic, copy) NSString *PoliticalStatus;
/**
 *  手机
 */
@property (nonatomic, copy) NSString *Mobile;
/**
 *  邮箱
 */
@property (nonatomic, copy) NSString *Email;
/**
 *  创建时间
 */
@property (nonatomic, copy) NSString *CreateTime;
/**
 *  更新时间
 */
@property (nonatomic, copy) NSString *UpdateTime;
/**
 *  自我评价
 */
@property (nonatomic, copy) NSString *SelfEvaluation;
/**
 *  头像
 */
@property (nonatomic, copy) NSString *Photo;
/**
 *  求职意向id
 */
@property (nonatomic, copy) NSString *ObjectiveId;
/**
 *  期望行业编码
 */
@property (nonatomic, copy) NSString *ExpretIndustryType;
/**
 *  期望行业名称
 */
@property (nonatomic, copy) NSString *IndChineseName;
/**
 *  期望职位编码
 */
@property (nonatomic, copy) NSString *ExpectJob;
/**
 *  期望职位名称
 */
@property (nonatomic, copy) NSString *FunName;
/**
 *  期望工作地点编码
 */
@property (nonatomic, copy) NSString *ExpectLocation;
/**
 *  期望工作地点名称
 */
@property (nonatomic, copy) NSString *CityName;
/**
 *  工作性质id
 */
@property (nonatomic, copy) NSString *JobNatureCode;
/**
 *  工作性质
 */
@property (nonatomic, copy) NSString *JobNature;
/**
 *  期望薪资id
 */
@property (nonatomic, copy) NSString *ExpectSalaryCode;
/**
 *  期望薪资
 */
@property (nonatomic, copy) NSString *ExpectSalary;
/**
 *  简历公开程度
 */
@property (nonatomic, copy) NSString *Privacy;


@end
