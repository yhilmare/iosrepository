//
//  YHBottomTableViewCell.h
//  WanCai
//
//  Created by abing on 16/7/17.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHCompanyMsg;
@interface YHBottomTableViewCell : UITableViewCell

@property (nonatomic, strong) YHCompanyMsg *msg;

+ (instancetype) cellFromTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@end
