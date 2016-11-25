//
//  YHPickerViewHelper.h
//  WanCai
//
//  Created by 段昊宇 on 16/8/16.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YHProfileInfomationType)  {
    YHProfileInfomationName = 0,
    YHProfileInfomationSex,
    YHProfileInfomationMaritalStatus,
    YHProfileInfomationBirthday,
    YHProfileInfomationEducate,
    YHProfileInfomationLocation,
    YHProfileInfomationWorkTime,
    YHProfileInfomationPhone,
    YHProfileInfomationEmail,
    YHProfileInfomationPolicalstatus,
    YHProfileInfomationSeleveluation,
    YHProfileInfomationExpectIndustryType,
    YHProfileInfomationExpectJob,
    YHProfileInfomationExpectLocation,
    YHProfileInfomationJobNature,
    YHProfileInfomationExpectSalary
};

typedef void (^ReturnTextBlock)(UIPickerView *picker, NSString *showText, YHProfileInfomationType type);

@interface YHPickerViewHelper : NSObject

@property (nonatomic, copy) ReturnTextBlock returnTextBlock;

- (UIPickerView *) sharedInstance: (YHProfileInfomationType)type initValue: (NSString *)val ;
- (void)returnText: (ReturnTextBlock)block;

@end
