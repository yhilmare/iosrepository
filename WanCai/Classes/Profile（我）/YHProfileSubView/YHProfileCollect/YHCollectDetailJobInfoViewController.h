//
//  YHCollectDetailJobInfoViewController.h
//  WanCai
//
//  Created by yh_swjtu on 16/8/8.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YHJobs;
@interface YHCollectDetailJobInfoViewController : UIViewController

+ (instancetype) detailInfoViewWithJob:(YHJobs *)job;

- (instancetype) initWithJob: (YHJobs *)Job;

@end
