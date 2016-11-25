//
//  YHProfileResumeLanAbiSecondTableViewController.h
//  WanCai
//
//  Created by 段昊宇 on 16/8/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YHTrainExperience.h"

#import "YHProfileResumeModel.h"
@interface YHProfileResumeLanAbiSecondTableViewController : UITableViewController

@property(nonatomic, strong) YHTrainExperience* item;

@property (nonatomic, strong) YHProfileResumeModel *profileResume;
@end
