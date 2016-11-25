//
//  YHCompanyInfo.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHCompanyInfo : NSObject<MJKeyValue>

/**
 *  公司id
 */
@property (nonatomic, copy) NSString *CompanyId;
/**
 *  公司注册id
 */
@property (nonatomic, copy) NSString *userId;
/**
 *  公司名称
 */
@property (nonatomic, copy) NSString *CompanyName;
/**
 *  公司所在城市
 */
@property (nonatomic, copy) NSString *CurrentCityName;
/**
 *  手机号
 */
@property (nonatomic, copy) NSString *Mobile;
/**
 *  公司联系方式
 */
@property (nonatomic, copy) NSString *ContactWay;
/**
 *  公司邮箱
 */
@property (nonatomic, copy) NSString *Email;
/**
 *  公司联系人
 */
@property (nonatomic, copy) NSString *CompanyContact;
/**
 *  更新时间
 */
@property (nonatomic, copy) NSString *UpdateDate;
/**
 *  公司网址
 */
@property (nonatomic, copy) NSString *CompanyUrl;
/**
 *  公司logo
 */
@property (nonatomic, copy) NSString *CompanyLogo;
/**
 *  公司性质
 */
@property (nonatomic, copy) NSString *CompanyNatureName;
/**
 *  公司规模
 */
@property (nonatomic, copy) NSString *CompanySizeName;
/**
 *  公司所属行业
 */
@property (nonatomic, copy) NSString *CompanyIndustryName;
/**
 *  公司简介
 */
@property (nonatomic, copy) NSString *CompanyIntroduce;
/**
 *  公司详细地址
 */
@property (nonatomic, copy) NSString *CompanyAddress;



@end
