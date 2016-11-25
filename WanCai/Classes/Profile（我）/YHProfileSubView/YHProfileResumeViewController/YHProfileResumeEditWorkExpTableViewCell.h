//
//  YHProfileResumeEditWorkExpTableViewCell.h
//  WanCai
//
//  Created by 段昊宇 on 16/8/7.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHWorkExperience.h"

@interface YHProfileResumeEditWorkExpTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *company;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *pro;

@property (strong, nonatomic) YHWorkExperience* item;
@end
