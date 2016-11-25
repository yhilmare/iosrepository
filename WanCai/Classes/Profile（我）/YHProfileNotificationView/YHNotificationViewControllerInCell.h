//
//  YHNotificationViewControllerInCell.h
//  WanCai
//
//  Created by yh_swjtu on 16/8/4.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHDialogue;

@protocol YHNotificationViewControllerInCellDelgate <NSObject>

@required
- (void) didSelectedAtIndexPath:(NSIndexPath *)path withTag:(NSInteger) viewTag andDialogueModel:(YHDialogue *) dia;

@end

@interface YHNotificationViewControllerInCell : UIViewController

@property (nonatomic, assign) NSInteger viewTag;

@property (nonatomic, assign) id<YHNotificationViewControllerInCellDelgate> delgate;

@end
