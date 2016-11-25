//
//  YHCareFromViewBottomView.h
//  WanCai
//
//  Created by abing on 16/7/22.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHCareFromViewBottomViewDelgate<NSObject>

@required
- (void) didClickButton:(UIButton *)button;

@end


@interface YHCareFromViewBottomView : UIView

@property (nonatomic, assign) id<YHCareFromViewBottomViewDelgate> delgate;

@end
