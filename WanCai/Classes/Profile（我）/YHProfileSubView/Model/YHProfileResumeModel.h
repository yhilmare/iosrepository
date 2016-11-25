//
//  YHProfileResumeModel.h
//  WanCai
//
//  Created by 段昊宇 on 16/7/26.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHProfileResumeModel : NSObject

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *resumeName;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSNumber *genderCoder;
@property (nonatomic, copy) NSString *gender;

@property (nonatomic, copy) NSNumber *marriageCoder;
@property (nonatomic, copy) NSString *marriage;

@property (nonatomic, strong) NSDate *birthdayDate;
@property (nonatomic, strong) NSString *birthday;

@property (nonatomic, copy) NSNumber *degreeCoder;
@property (nonatomic, copy) NSString *degree;

@property (nonatomic, copy) NSNumber *workyearCoder;
@property (nonatomic, copy) NSString *workyear;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSNumber *locationCoder;
@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSNumber *policicalstatusCoder;
@property (nonatomic, copy) NSString *policicalstatus;

@property (nonatomic, copy) NSString *seleveluation;

@property (nonatomic, copy) NSString *expectIndustryType;

@property (nonatomic, copy) NSString *expertJob;

@property (nonatomic, copy) NSString *expectLocation;
@property (nonatomic, copy) NSNumber *expectLocationCoder;

@property (nonatomic, copy) NSNumber *jobNatureCoder;
@property (nonatomic, copy) NSString *jobNature;

@property (nonatomic, copy) NSNumber *expectSalaryCoder;
@property (nonatomic, copy) NSString *expectSalary;

@property (nonatomic, copy) NSString *selfEvaluation;

@property (nonatomic, copy) NSNumber *privacyCoder;
@property (nonatomic, copy) NSString *privacy;

@property (nonatomic, copy) NSString *resumeIntergrity;

@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, copy) NSString *resumeId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *photoUrl;

@property (nonatomic, copy) NSNumber *expertIndustryType;
@property (nonatomic, copy) NSString *indChineseName;

@property (nonatomic, copy) NSNumber *expectJob;
@property (nonatomic, copy) NSString *funName;

- (void)setGenderWithName:(NSString *)gender ;
- (NSString *)getGenderName;

- (void)setMarriageWithName:(NSString *)marriage;
- (NSString *)getMarriageName;

- (void)setBirthdayWithName: (NSString *)date;
- (NSString *)getBirthdayName;

- (void)setDegreeWithName: (NSString *)degree ;
- (NSString *)getDegreeName ;

- (void)setWorkyearWithName: (NSString *)workyear;
- (NSString *)getWorkyearName ;

- (void)setLocationWithCityName:(NSString *)location;
- (NSString *)getLocationCityName;

- (void)setExpectLocationWithName: (NSString *)expectLocation;
- (NSString *)getExpectLocationName;

- (void)setPolicicalstatusWithName:(NSString *)po;
- (NSString *)getPolicicalstatusName;

- (void)setJobNatureWithName:(NSString *)jobNature;
- (NSString *)getJobNatureName;

- (void)setExpectSalaryWithName:(NSString *)expectSalary;
- (NSString *)getExpectSalaryName;
@end
