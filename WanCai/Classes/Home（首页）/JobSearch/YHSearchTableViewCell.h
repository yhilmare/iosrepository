//
//  YHSearchTableViewCell.h
//  WanCai
//
//  Created by abing on 16/7/20.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHJobs;
@interface YHSearchTableViewCell : UITableViewCell

@property (nonatomic, copy) YHJobs *job;

@property (nonatomic, copy) NSString *iconName;

+ (instancetype) cellFromTableView:(UITableView *)tableView
                    withIdentifier:(NSString *)identifier;

@end
