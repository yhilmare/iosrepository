//
//  YHAlertView.h
//  WanCai
//
//  Created by yh_swjtu on 16/8/6.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHAlertViewDelgate <NSObject>

@required
- (void) clickFunction:(NSInteger) tag;

@end

@interface YHAlertView : UIView

@property(nonatomic, assign) id<YHAlertViewDelgate>delgate;

- (instancetype) initWithFrame:(CGRect)frame andResumeArray:(NSMutableArray *)array;

@end
