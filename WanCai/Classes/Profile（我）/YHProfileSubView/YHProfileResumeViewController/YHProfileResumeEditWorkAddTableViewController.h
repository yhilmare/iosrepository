//
//  YHProfileResumeEditWorkAddTableViewController.h
//  WanCai
//
//  Created by 段昊宇 on 16/8/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHProfileResumeModel.h"
#import "YHWorkExperience.h"
#import "YHWorkExperienceTool.h"

@interface YHProfileResumeEditWorkAddTableViewController : UITableViewController

@property (nonatomic, strong) YHProfileResumeModel *profileResume;
@property (strong, nonatomic) YHWorkExperience* item;

@end
