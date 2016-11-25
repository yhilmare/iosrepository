//
//  YHMyJobApply.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHMyJobApply : NSObject<MJKeyValue>

/**
 *  申请记录id
 */
@property (nonatomic, copy) NSString *ApplyId;
/**
 *  用户id
 */
@property (nonatomic, copy) NSString *userId;
/**
 *  企业名称
 */
@property (nonatomic, copy) NSString *CompanyName;
/**
 *  职位id
 */
@property (nonatomic, copy) NSString *JobId;
/**
 *  职位名称
 */
@property (nonatomic, copy) NSString *JobName;
/**
 *  工作地点编码
 */
@property (nonatomic, copy) NSString *WorkLocation;
/**
 *  城市名称
 */
@property (nonatomic, copy) NSString *CityName;
/**
 *  申请日期
 */
@property (nonatomic, copy) NSString *ApplyDate;
/**
 *  发布日期
 */
@property (nonatomic, copy) NSString *CreateDate;
/**
 *  简历id
 */
@property (nonatomic, copy) NSString *ResumeId;

@end
