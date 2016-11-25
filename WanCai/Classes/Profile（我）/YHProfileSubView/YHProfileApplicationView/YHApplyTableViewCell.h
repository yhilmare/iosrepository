//
//  YHApplicationTableViewCell.h
//  WanCai
//
//  Created by CheungKnives on 16/8/1.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHMyJobApply;

@interface YHApplyTableViewCell : UITableViewCell

@property (nonatomic, copy) YHMyJobApply *myJobApply;

@property (nonatomic, copy) NSString *iconName;

+ (instancetype) cellFromTableView:(UITableView *)tableView
                    withIdentifier:(NSString *)identifier;

@end
