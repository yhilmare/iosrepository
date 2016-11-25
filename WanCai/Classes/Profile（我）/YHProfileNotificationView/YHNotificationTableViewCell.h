//
//  YHNotificationTableViewCell.h
//  WanCai
//
//  Created by yh_swjtu on 16/8/3.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHNotificationViewControllerInCell;
@interface YHNotificationTableViewCell : UITableViewCell

@property (nonatomic, strong) YHNotificationViewControllerInCell *tableView;

+ (instancetype) cellFromTableView:(UITableView *) tabelview withIdentifier:(NSString *) identifier;

@end
