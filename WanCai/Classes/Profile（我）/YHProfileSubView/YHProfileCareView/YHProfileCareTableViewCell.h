//
//  YHProfileCareTableViewCell.h
//  WanCai
//
//  Created by abing on 16/7/22.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHAttentionToMeCompany;
@interface YHProfileCareTableViewCell : UITableViewCell

@property (nonatomic, copy) YHAttentionToMeCompany *attCom;

+ (instancetype) cellFromTableView:(UITableView *)tableView withIdentifier:(NSString *) identifier;

@end
