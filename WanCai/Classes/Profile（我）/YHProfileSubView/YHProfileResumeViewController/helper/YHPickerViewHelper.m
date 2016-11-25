//
//  YHPickerViewHelper.m
//  WanCai
//
//  Created by 段昊宇 on 16/8/16.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHPickerViewHelper.h"

@interface YHPickerViewHelper()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIPickerView *expectIndustry;
@property (strong, nonatomic) UIPickerView *jobNature;
@property (strong, nonatomic) UIPickerView *expectSalary;

@property (strong, nonatomic) NSArray<NSString *> *expectIndustryData;
@property (strong, nonatomic) NSArray<NSString *> *jobNatureData;
@property (strong, nonatomic) NSArray<NSString *> *expectSalaryData;
@end

@implementation YHPickerViewHelper

- (UIPickerView *) sharedInstance: (YHProfileInfomationType)type initValue: (NSString *)val {
    if (type == YHProfileInfomationExpectJob) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"industry.plist" ofType:nil];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *temp = dic[@"rows"];
        NSMutableArray *arrays = [NSMutableArray arrayWithObject:@"请选择"];
        for(NSDictionary *tempDic in temp){
            [arrays addObject:tempDic[@"IndName"]];
        }
        self.expectIndustryData = arrays;
        
        if ([arrays containsObject:val]) {
            NSUInteger index = [arrays indexOfObject:val];
            [self.expectIndustry selectedRowInComponent:index];
        }
        
        return self.expectIndustry;
    } else if (type == YHProfileInfomationJobNature) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"jobNature.plist" ofType:nil];
        NSArray *arrays = [NSArray arrayWithContentsOfFile:path];
        self.jobNatureData = arrays;
        
        if ([arrays containsObject:val]) {
            NSUInteger index = [arrays indexOfObject:val];
            [self.jobNature selectedRowInComponent:index];
        }
        return self.jobNature;
    } else if (type == YHProfileInfomationExpectSalary) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"expectSalary.plist" ofType:nil];
        NSArray *arrays = [NSArray arrayWithContentsOfFile:path];
        self.expectSalaryData = arrays;
        
        if ([arrays containsObject:val]) {
            NSUInteger index = [arrays indexOfObject:val];
            [self.expectSalary selectedRowInComponent:index];
        }
        return self.expectSalary;
    }
    return nil;
}

- (void)returnText: (ReturnTextBlock)block {
    self.returnTextBlock = block;
}

- (UIPickerView *)expectIndustry {
    if (!_expectIndustry) {
        _expectIndustry = [[UIPickerView alloc] init];
        _expectIndustry.delegate = self;
        _expectIndustry.dataSource = self;
    }
    return _expectIndustry;
}

- (UIPickerView *)jobNature {
    if (!_jobNature) {
        _jobNature = [[UIPickerView alloc] init];
        _jobNature.delegate = self;
        _jobNature.dataSource = self;
    }
    return _jobNature;
}

- (UIPickerView *)expectSalary {
    if (!_expectSalary) {
        _expectSalary = [[UIPickerView alloc] init];
        _expectSalary.delegate = self;
        _expectSalary.dataSource = self;
    }
    return _expectSalary;
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.expectIndustry) {
        return self.expectIndustryData.count;
    } else if (pickerView == self.jobNature) {
        return self.jobNatureData.count;
    } else if (pickerView == self.expectSalary) {
        return self.expectSalaryData.count;
    }
    return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == self.expectIndustry) {
        return self.expectIndustryData[row];
    } else if (pickerView == self.jobNature) {
        return self.jobNatureData[row];
    } else if (pickerView == self.expectSalary) {
        return self.expectSalaryData[row];
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.expectIndustry) {
        if (self.returnTextBlock != nil) {
            self.returnTextBlock(self.expectIndustry, self.expectIndustryData[row], YHProfileInfomationExpectJob);
        }
    } else if (pickerView == self.jobNature) {
        if (self.returnTextBlock != nil) {
            self.returnTextBlock(self.jobNature, self.jobNatureData[row], YHProfileInfomationJobNature);
        }
    } else if (pickerView == self.expectSalary) {
        if (self.returnTextBlock != nil) {
            self.returnTextBlock(self.expectSalary, self.expectSalaryData[row], YHProfileInfomationExpectSalary);
        }
    }
}

@end
