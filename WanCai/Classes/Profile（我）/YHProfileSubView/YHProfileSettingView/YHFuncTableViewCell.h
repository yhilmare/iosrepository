//
//  YHFuncTableViewCell.h
//  WanCai
//
//  Created by yh_swjtu on 16/8/14.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHFuncTableViewCell : UITableViewCell

+ (instancetype) cellFromTableView:(UITableView *) tableView withIdentifier:(NSString *) identifier;
@property (nonatomic, copy) NSString *iconName1;
@property (nonatomic, copy) NSString *iconName2;

@end
