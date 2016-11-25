//
//  YHSettingTableViewCell.h
//  WanCai
//
//  Created by abing on 16/7/22.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHSettingTableViewCell : UITableViewCell

+ (instancetype) cellFromTableView:(UITableView *) tableView withIdentifier:(NSString *) identifier;

@property (nonatomic, copy) NSString *name;

@end
