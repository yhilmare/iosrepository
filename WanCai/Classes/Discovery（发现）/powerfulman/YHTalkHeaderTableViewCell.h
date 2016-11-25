//
//  YHTalkHeaderTableViewCell.h
//  WanCai
//
//  Created by abing on 16/9/15.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHTalkHeaderTableViewCell : UITableViewCell

+ (instancetype) cellFromTableView:(UITableView *) tableView withReuseIdentifier:(NSString *) identifier andArray:(NSArray *) tempArray;

@property (nonatomic, strong) NSArray *array;

@end
