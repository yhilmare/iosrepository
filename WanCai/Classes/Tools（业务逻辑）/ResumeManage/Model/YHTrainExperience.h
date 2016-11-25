//
//  YHTrainExperience.h
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHTrainExperience : NSObject<MJKeyValue>

/**
 *  id
 */
@property (nonatomic, copy) NSString *TrainId;
/**
 *  简历id
 */
@property (nonatomic, copy) NSString *ResumeId;
/**
 *  培训开始时间
 */
@property (nonatomic, copy) NSString *StartDate;
/**
 *  培训结束时间
 */
@property (nonatomic, copy) NSString *EndeDate;
/**
 *  培训机构名称
 */
@property (nonatomic, copy) NSString *TrainedOrg;
/**
 *  培训课程
 */
@property (nonatomic, copy) NSString *TrainedName;
/**
 *  描述
 */
@property (nonatomic, copy) NSString *Description;
/**
 *  创建时间
 */
@property (nonatomic, copy) NSString *CreateDate;
/**
 *  修改时间
 */
@property (nonatomic, copy) NSString *UpdateDate;

@end
