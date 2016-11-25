//
//  YHDetailInfoOfJobViewController.h
//  WanCai
//
//  Created by abing on 16/7/16.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHJobs;
@interface YHDetailInfoOfJobViewController : UIViewController

+ (instancetype) detailInfoViewWithJob:(YHJobs *)job;

- (instancetype) initWithJob: (YHJobs *)Job;

@end
