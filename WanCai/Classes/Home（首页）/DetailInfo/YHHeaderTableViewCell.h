//
//  YHHeaderTableViewCell.h
//  WanCai
//
//  Created by abing on 16/7/16.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHHeaderTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *iconName;

@property (nonatomic, copy) NSString *jobName;

@property (nonatomic, copy) NSString *companyName;

+ (instancetype) cellWithIdentifier:(NSString *)identifier tableView:(UITableView *) tableView;

@end
