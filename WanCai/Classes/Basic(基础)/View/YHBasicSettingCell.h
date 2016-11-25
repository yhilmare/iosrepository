//
//  YHBasicSettingCell.h
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHSettingItem;

@interface YHBasicSettingCell : UITableViewCell

@property (nonatomic, strong) YHSettingItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setIndexPath:(NSIndexPath *)indexPath rowCount:(NSInteger)rowCount;

@end
