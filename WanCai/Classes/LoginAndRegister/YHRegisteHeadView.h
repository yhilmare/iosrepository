//
//  YHRegisteHeadView.h
//  WanCai
//
//  Created by abing on 16/7/8.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHRegisteHeadViewdelgate <NSObject>

@required
- (void) cancelFunction;

@end
@interface YHRegisteHeadView : UIView
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, assign) id<YHRegisteHeadViewdelgate> delgate;

@end
