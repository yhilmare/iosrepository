//
//  YHTopicTableViewCell.h
//  WanCai
//
//  Created by abing on 16/9/14.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHTopicModel;
@interface YHTopicTableViewCell : UITableViewCell

@property (nonatomic, copy) YHTopicModel *model;

+ (instancetype) cellFromTableView:(UITableView *) tableView withReuseIdentifier:(NSString *) identifier;

@end
