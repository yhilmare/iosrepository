//
//  YHRegisteTableViewCell.h
//  WanCai
//
//  Created by abing on 16/7/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHRegisteTableViewCell : UITableViewCell

@property(nonatomic, copy) NSString *iconName;

@property(nonatomic, copy) NSString *textFieldName;

@property (nonatomic, strong) UITextField *textField;

+ (instancetype) cellFromTableView:(UITableView *)tableView
                    withIdentifier:(NSString *)identifier;

@end
