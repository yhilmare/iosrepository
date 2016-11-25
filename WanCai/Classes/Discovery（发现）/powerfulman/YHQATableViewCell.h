//
//  YHQATableViewCell.h
//  WanCai
//
//  Created by abing on 16/9/15.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHAnswerModel;

@interface YHQATableViewCell : UITableViewCell

@property (nonatomic, copy) YHAnswerModel *model;

+ (instancetype) cellFromTableView:(UITableView *) tableView withReuseIdentifier:(NSString *) identifier;

@end
