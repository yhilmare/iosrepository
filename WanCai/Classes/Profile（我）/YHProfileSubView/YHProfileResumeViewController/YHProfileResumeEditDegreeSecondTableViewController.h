//
//  YHProfileResumeEditDegreeSecondTableViewController.h
//  WanCai
//
//  Created by 段昊宇 on 16/8/4.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHProfileResumeModel.h"
#import "YHResumeTool.h"
#import "YHEducationTool.h"
#import "YHEducation.h"
#import "YHResultItem.h"
#import "YHReturnMsg.h"
#import "YHProfileResumeEditDegreeTableViewCell.h"


@interface YHProfileResumeEditDegreeSecondTableViewController : UITableViewController

@property (nonatomic, strong) YHProfileResumeModel *profileResume;
@property (nonatomic, strong) YHEducation *item;
@end
