//
//  YHResume.h
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHResume : NSObject<MJKeyValue>

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
 *  简历公开程度（1:对所有人公开，2：完全保密）
 */
@property (nonatomic, copy) NSString *Privacy;
/**
 *  简历完整程度
 */
@property (nonatomic, copy) NSString *ResumeIntergrity;
/**
 *  更新时间
 */
@property (nonatomic, copy) NSString *UpdateTime;

@end
