//
//  YHJobInfoCell.h
//  WanCai
//
//  Created by CheungKnives on 16/7/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHJobs;

@interface YHJobInfoCell : UITableViewCell

@property (nonatomic, strong) YHJobs *job;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
