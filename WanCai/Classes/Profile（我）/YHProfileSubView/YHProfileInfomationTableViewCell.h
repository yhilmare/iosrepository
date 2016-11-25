//
//  YHProfileInfomationTableViewCell.h
//  WanCai
//
//  Created by abing on 16/7/9.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHProfileInfomationTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextField *detailInfo;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) NSString *labelMsg;

+ (instancetype) getTableViewCell:(UITableView *)tableView reusableIdentifier:(NSString *) identifier arrayPointer:(NSMutableArray *) array;

@end
