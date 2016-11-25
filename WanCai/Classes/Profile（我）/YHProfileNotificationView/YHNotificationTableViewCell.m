//
//  YHNotificationTableViewCell.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/3.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHNotificationTableViewCell.h"
#import "YHNotificationViewControllerInCell.h"

@implementation YHNotificationTableViewCell

- (void) setTableView:(YHNotificationViewControllerInCell* )tableView{
    [_tableView.view removeFromSuperview];
    _tableView = tableView;
    [self.contentView addSubview:_tableView.view];
    _tableView.view.transform = CGAffineTransformMakeRotation(M_PI_2);
}

- (void) layoutSubviews{
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    self.tableView.view.frame = CGRectMake(0, 0, width, height);
}

+ (instancetype) cellFromTableView:(UITableView *) tabelview withIdentifier:(NSString *) identifier{
    
    YHNotificationTableViewCell *cell = [tabelview dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
    }
    return self;
}

@end
