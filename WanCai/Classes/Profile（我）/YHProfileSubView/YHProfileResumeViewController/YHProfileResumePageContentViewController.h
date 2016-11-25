//
//  YHProfileResumePageContentViewController.h
//  WanCai
//
//  Created by 段昊宇 on 16/7/25.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHProfileResumeModel;
@interface YHProfileResumePageContentViewController : UIViewController


@property (assign) NSInteger index;

@property (nonatomic, copy) NSString *resumenName;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *expectJob;

@property (nonatomic, strong) NSMutableArray<NSString *> *msgArr;
@property (nonatomic, copy) NSString *selfEvaluation;
@property (nonatomic, copy) NSString *expectSalary;

@property (weak, nonatomic) IBOutlet UIView *chartView;
@property (nonatomic, strong) YHProfileResumeModel *profileResume;


@end
