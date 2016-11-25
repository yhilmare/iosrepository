//
//  YHCompanyTableViewMiddleCell.h
//  WanCai
//
//  Created by abing on 16/7/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHCompanyDesc;
@interface YHCompanyTableViewMiddleCell : UITableViewCell

@property (nonatomic, copy) YHCompanyDesc *desc;

+ (instancetype) cellFromTableView:(UITableView *)tableView
                    withIdentifier:(NSString *)identifier;

@end
