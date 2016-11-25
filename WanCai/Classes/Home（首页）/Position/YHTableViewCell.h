//
//  YHTableViewCell.h
//  WanCai
//
//  Created by abing on 16/7/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHTableViewCellDelgate <NSObject>

@required

- (void) didClickButton: (UIButton *)button;

@end

@class YHButtonModelFrame;
@interface YHTableViewCell : UITableViewCell

@property (nonatomic, copy) YHButtonModelFrame *modelFrame;

@property (nonatomic, assign) id<YHTableViewCellDelgate> delgate;


+ (instancetype) getTableViewCellWithIdentifier:(NSString *) identifier
                                      tableView: (UITableView *) tableView
                                      inSection:(NSIndexPath *)index;

@end
