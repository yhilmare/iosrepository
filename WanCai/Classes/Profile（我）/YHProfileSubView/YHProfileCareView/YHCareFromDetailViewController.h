//
//  YHCareFromDetailViewController.h
//  WanCai
//
//  Created by abing on 16/7/22.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHJobs;
@interface YHCareFromDetailViewController : UIViewController

@property (nonatomic, copy) NSString *resumeId;

+ (instancetype) detailInfoViewWithJob:(YHJobs *)job andResumeId:(NSString *)resumeId;

- (instancetype)initWithJob:(YHJobs *)Job andResumeId:(NSString *) resumeId;

@end
