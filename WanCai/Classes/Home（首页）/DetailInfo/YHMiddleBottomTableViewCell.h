//
//  YHMiddleBottomTableViewCell.h
//  WanCai
//
//  Created by abing on 16/7/17.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHJobs;
@interface YHMiddleBottomTableViewCell : UITableViewCell

@property(nonatomic, copy) YHJobs *job;

+ (instancetype) cellFromTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@end
