//
//  YHProfileResumeTrainExpAddTableViewController.h
//  WanCai
//
//  Created by 段昊宇 on 16/8/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHTrainExperience.h"
#import "YHProfileResumeModel.h"

@interface YHProfileResumeTrainExpAddTableViewController : UITableViewController
@property(nonatomic, strong) YHTrainExperience* item;
@property (nonatomic, strong) YHProfileResumeModel *profileResume;
@end
