//
//  YHEducation.h
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHEducation : NSObject<MJKeyValue>

/**
 *  id
 */
@property (nonatomic, copy) NSString *EduId;
/**
 *  简历id
 */
@property (nonatomic, copy) NSString *ResumeId;
/**
 *  入学时间
 */
@property (nonatomic, copy) NSString *StartDate;
/**
 *  毕业时间
 */
@property (nonatomic, copy) NSString *EndDate;
/**
 *  学校名称
 */
@property (nonatomic, copy) NSString *SchoolName;
/**
 *  专业
 */
@property (nonatomic, copy) NSString *Major;
/**
 *  学历
 */
@property (nonatomic, copy) NSString *ChineseName;

@end
