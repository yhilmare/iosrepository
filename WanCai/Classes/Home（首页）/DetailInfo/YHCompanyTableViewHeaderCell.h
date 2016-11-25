//
//  YHCompanyTableViewHeaderCell.h
//  WanCai
//
//  Created by abing on 16/7/18.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHCompanyInfo;
@interface YHCompanyTableViewHeaderCell : UITableViewCell

@property (nonatomic, copy) NSString *iconName;

@property (nonatomic, copy) YHCompanyInfo *comInfo;

+ (instancetype) cellFromTableView:(UITableView *)tableView
                    withIdentifier:(NSString *)identifier;

@end
