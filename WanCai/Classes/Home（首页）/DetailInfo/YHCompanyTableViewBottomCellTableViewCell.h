//
//  YHCompanyTableViewBottomCellTableViewCell.h
//  WanCai
//
//  Created by abing on 16/7/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHCompanyInfo;
@interface YHCompanyTableViewBottomCellTableViewCell : UITableViewCell

@property (nonatomic, copy) YHCompanyInfo *comInfo;

+ (instancetype) cellFromTableView:(UITableView *)tableView
                    withIdentifier:(NSString *)identifier;

@end
