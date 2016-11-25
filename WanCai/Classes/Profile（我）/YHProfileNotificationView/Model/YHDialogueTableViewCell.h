//
//  YHDialogueTableViewCell.h
//  WanCai
//
//  Created by yh_swjtu on 16/8/4.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHDialogue;
@interface YHDialogueTableViewCell : UITableViewCell

@property (nonatomic, copy) YHDialogue *dialogue;

+ (instancetype) cellFromTableView:(UITableView *) tabelview withIdentifier:(NSString *) identifier;

@end
