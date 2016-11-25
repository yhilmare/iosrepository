//
//  YHDiscoveryTableViewCell.h
//  WanCai
//
//  Created by abing on 16/9/14.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHDiscoveryTableViewCell : UITableViewCell

@property (nonatomic, strong) UIViewController *viewController;

+ (instancetype) cellWithTableView:(UITableView *) tableView withIdentifier:(NSString *) identifier;

@end
