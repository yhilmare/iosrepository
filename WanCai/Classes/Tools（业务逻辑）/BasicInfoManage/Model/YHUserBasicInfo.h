//
//  YHUserBasicInfo.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHUserBasicInfo : NSObject<MJKeyValue>

/**
 *  编号
 */
@property (nonatomic, copy) NSString *BasicInfoId;
/**
 *  用户id
 */
@property (nonatomic, copy) NSString *userId;
/**
 *  姓名
 */
@property (nonatomic, copy) NSString *UserName;
/**
 *  性别
 */
@property (nonatomic, copy) NSString *Gender;
/**
 *  婚姻状况
 */
@property (nonatomic, copy) NSString *Marrige;
/**
 *  出生日期，暂时用nsstring
 */
@property (nonatomic, copy) NSString *Birthday;
/**
 *  最高学历
 */
@property (nonatomic, copy) NSString *Degree;
/**
 *  工作年限
 */
@property (nonatomic, copy) NSString *YearOfWork;
/**
 *  手机号码
 */
@property (nonatomic, copy) NSString *Mobile;
/**
 *  邮箱
 */
@property (nonatomic, copy) NSString *Email;
/**
 *  现居地城市编码
 */
@property (nonatomic, copy) NSString *Location;
/**
 *  头像【url】
 */
@property (nonatomic, copy) NSString *Photo;
/**
 *  创建时间
 */
@property (nonatomic, copy) NSString *CreateDate;
/**
 *  更新时间
 */
@property (nonatomic, copy) NSString *UpdateDate;
/**
 *  现居住地城市名称
 */
@property (nonatomic, copy) NSString *CityName;

@end
