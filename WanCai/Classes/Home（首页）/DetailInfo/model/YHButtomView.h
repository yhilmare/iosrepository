//
//  YHButtomView.h
//  WanCai
//
//  Created by abing on 16/7/16.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHButtomViewDelgate<NSObject>

@required
- (void) didClickButton:(UIButton *)button;

@end

@interface YHButtomView : UIView

@property (nonatomic, strong) UIButton *collectButton;


@property (nonatomic, assign) id<YHButtomViewDelgate> delgate;

@end
