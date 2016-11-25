//
//  YHProfileResumeModel.m
//  WanCai
//
//  Created by 段昊宇 on 16/7/26.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileResumeModel.h"

@implementation YHProfileResumeModel

#pragma mark - 性别（1：男，2：女）
- (void)setGenderWithName:(NSString *)gender {
    if ([gender isEqualToString:@"男"]) {
        self.gender = @"男";
        self.genderCoder = @1;
    } else {
        self.gender = @"女";
        self.genderCoder = @2;
    }
}

- (NSString *)getGenderName {
    return self.gender;
}

#pragma mark - 婚姻状况（1：已婚，2：未婚）
- (void)setMarriageWithName:(NSString *)marriage {
    if ([marriage isEqualToString:@"已婚"]) {
        self.marriageCoder = @1;
        self.marriage = @"已婚";
    } else {
        self.marriageCoder = @2;
        self.marriage = @"未婚";
    }
}

- (NSString *)getMarriageName {
//    if ([self.marriage isEqual:@1]) {
//        return @"已婚";
//    } else {
//        return @"未婚";
//    }
    return self.marriage;
}

#pragma mark - 生日
- (void)setBirthdayWithName: (NSString *)date {
    self.birthday = date;
    self.birthdayDate = [YHProfileResumeModel convertDateFromString:date];
}

- (NSString *)getBirthdayName {
    return self.birthday;
}


#pragma mark - 最高学历
- (void)setDegreeWithName: (NSString *)degree {
    self.degreeCoder = [YHProfileResumeModel findTheCodeInArrayBy:@"education.plist" name:degree];
    self.degree = degree;
}

- (NSString *)getDegreeName {
    return self.degree;
}

#pragma mark - 工作年限
- (void)setWorkyearWithName: (NSString *)workyear {
    self.workyear = workyear;
    self.workyearCoder = [YHProfileResumeModel findTheCodeInArrayBy:@"workYear.plist" name:workyear];
}

- (NSString *)getWorkyearName {
    return self.workyear;
}

#pragma mark - 现居地
- (void)setLocationWithCityName:(NSString *)location {
    NSString *file = [[NSBundle mainBundle] pathForResource:@"cityMappingFile.plist" ofType:nil];
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithContentsOfFile:file];
    NSNumber *cityNum = [temp objectForKey:location];
    self.locationCoder = cityNum;
    self.location = location;
}

- (NSString *)getLocationCityName {
    return self.location;
}

#pragma mark - 期待工作地
- (void)setExpectLocationWithName: (NSString *)expectLocation {
    NSString *file = [[NSBundle mainBundle] pathForResource:@"cityMappingFile.plist" ofType:nil];
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithContentsOfFile:file];
    NSNumber *cityNum = [temp objectForKey:expectLocation];
    self.expectLocationCoder = cityNum;
    self.expectLocation = expectLocation;
}

- (NSString *)getExpectLocationName {
    return self.expectLocation;
}

#pragma mark - 政治面貌（若不选择政治面貌则该字段值0）
- (void)setPolicicalstatusWithName:(NSString *)po {
    self.policicalstatus = po;
    self.policicalstatusCoder = [YHProfileResumeModel findTheCodeInArrayBy:@"policicalstatus.plist" name:po];
}

- (NSString *)getPolicicalstatusName {
    return self.policicalstatus;
}

#pragma mark - 工作性质（1：全职，2：兼职，3：实习）
- (void)setJobNatureWithName:(NSString *)jobNature {
    if ([jobNature isEqualToString:@"全职"]) {
        self.jobNatureCoder = @1;
    } else if ([jobNature isEqualToString:@"兼职"]) {
        self.jobNatureCoder = @2;
    } else {
        self.jobNatureCoder = @3;
    }
    self.jobNature = jobNature;
}

- (NSString *)getJobNatureName {
    return self.jobNature;
}

#pragma mark - 期待薪水
- (void)setExpectSalaryWithName:(NSString *)expectSalary {
    self.expectSalary = expectSalary;
    self.expectSalaryCoder = [YHProfileResumeModel findTheCodeInArrayBy:@"expectSalary.plist" name:expectSalary];
}

- (NSString *)getExpectSalaryName {
    return self.expectSalary;
}

+ (NSNumber *)findTheCodeInArrayBy: (NSString *)plistName name:(NSString *)item {
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    return [NSNumber numberWithInteger:[array indexOfObject:item]];
}

+ (NSString *)findTheNameInArrayBy: (NSString *)plistName index:(NSNumber *)index {
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    return array[[index integerValue]];
}

+ (NSDate *)convertDateFromString:(NSString *)uiDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString: uiDate];
    return date;
}

+ (NSString *)covertDateStringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormater stringFromDate:date];
    return strDate;
}


@end
