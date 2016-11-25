//
//  YHDialogueDetailTableViewCell.h
//  WanCai
//
//  Created by yh_swjtu on 16/8/5.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHDialogue;
@interface YHDialogueDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) YHDialogue *dia;

+ (instancetype) cellFromTableView:(UITableView *) tabelview withIdentifier:(NSString *) identifier;

@end
