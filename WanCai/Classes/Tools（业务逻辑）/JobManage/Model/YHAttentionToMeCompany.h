//
//  YHAttentionToMeCompany.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHAttentionToMeCompany : NSObject<MJKeyValue>

/**
 *  id
 */
@property (nonatomic, copy) NSString *PayAttentionId;
/**
 *  用户id
 */
@property (nonatomic, copy) NSString *userId;
/**
 *  企业id
 */
@property (nonatomic, copy) NSString *CompanyId;
/**
 *  职位id
 */
@property (nonatomic, copy) NSString *JobId;
/**
 *  简历id
 */
@property (nonatomic, copy) NSString *ResumeId;
/**
 *  浏览时间
 */
@property (nonatomic, copy) NSString *ViewDate;
/**
 *  创建时间
 */
@property (nonatomic, copy) NSString *CreateDate;
/**
 *  是否删除
 */
@property (nonatomic, assign, getter=isDelete) BOOL IsDelete;
/**
 *  企业名称
 */
@property (nonatomic, copy) NSString *CompanyName;
/**
 *  职位名称
 */
@property (nonatomic, copy) NSString *JobName;
/**
 *  简历名称
 */
@property (nonatomic, copy) NSString *ResumeName;

@end
