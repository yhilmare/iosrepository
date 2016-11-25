//
//  YHJobs.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHJobs : NSObject<MJKeyValue>


@property (nonatomic, copy) NSString *JobRequirements;

/**
 *  row
 */
@property (nonatomic, copy) NSString *Row;
/**
 *  职位id
 */
@property (nonatomic, copy) NSString *JobId;
/**
 *  职位名称
 */
@property (nonatomic, copy) NSString *JobName;
/**
 *  职能名称
 */
@property (nonatomic, copy) NSString *JobFunctionName;
/**
 *  期望工作城市
 */
@property (nonatomic, copy) NSString *CityName;
/**
 *  发布时间
 */
@property (nonatomic, copy) NSString *PublishDate;
/**
 *  学历名称
 */
@property (nonatomic, copy) NSString *DegreeName;
/**
 *  工作经验
 */
@property (nonatomic, copy) NSString *WorkYears;
/**
 *  工作性质
 */
@property (nonatomic, copy) NSString *NatureName;
/**
 *  薪资范围
 */
@property (nonatomic, copy) NSString *SalaryName;
/**
 *  职位描述
 */
@property (nonatomic, copy) NSString *JobDescription;
/**
 *  更新职位时间
 */
@property (nonatomic, copy) NSString *UpdteDate;
/**
 *  所属行业
 */
@property (nonatomic, copy) NSString *IndustryName;
/**
 *  公司id
 */
@property (nonatomic, copy) NSString *CompanyId;
/**
 *  公司名称
 */
@property (nonatomic, copy) NSString *CompanyName;
/**
 *  公司性质
 */
@property (nonatomic, copy) NSString *CompanyNatureName;
/**
 *  公司规模
 */
@property (nonatomic, copy) NSString *CompanySizeName;
/**
 *  公司介绍
 */
@property (nonatomic, copy) NSString *CompanyIntroduce;
/**
 *  公司联系人
 */
@property (nonatomic, copy) NSString *CompanyContact;
/**
 *  公司详细地址
 */
@property (nonatomic, copy) NSString *CompanyAddress;
/**
 *  公司联系方式
 */
@property (nonatomic, copy) NSString *Contact;

@end
