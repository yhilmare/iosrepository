//
//  YHProfileResumeCategoryTableViewController.h
//  WanCai
//
//  Created by 段昊宇 on 16/7/29.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHProfileResumeModel.h"

@interface YHProfileResumeCategoryTableViewController : UITableViewController

@property (nonatomic, strong) YHProfileResumeModel *profileResume;
@property (nonatomic, copy) NSString *msg;

@end
