//
//  YHAppearanceCellTableViewCell.h
//  WanCai
//
//  Created by yh_swjtu on 16/8/2.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHAppearanceCellTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *iconName;

+ (instancetype) cellFromTableview:(UITableView *) tabelview withIdentifier:(NSString *) identifier;
@end
