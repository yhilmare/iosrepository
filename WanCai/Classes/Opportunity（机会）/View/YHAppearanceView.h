//
//  YHAppearanceView.h
//  WanCai
//
//  Created by yh_swjtu on 16/7/31.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHAppearanceViewDelgate <NSObject>

@required
- (void) didClickTableViewAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface YHAppearanceView : UIView

@property(nonatomic, assign) id <YHAppearanceViewDelgate> delgate;

@end
