//
//  YHMiddleHeaderTableViewCell.h
//  WanCai
//
//  Created by abing on 16/7/17.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YHJobs;
@interface YHMiddleHeaderTableViewCell : UITableViewCell

@property(nonatomic, copy)YHJobs *job;

+ (instancetype) cellWithIdentifier:(NSString *)identifier withTableView:(UITableView *)tableView;

@end
