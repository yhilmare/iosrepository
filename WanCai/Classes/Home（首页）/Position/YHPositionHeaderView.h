//
//  YHPositionHeaderView.h
//  WanCai
//
//  Created by abing on 16/7/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YHPositionHeaderViewdelgate <NSObject>

@required
- (void) cancelFunction;

@end

@interface YHPositionHeaderView : UIView

@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, assign) id<YHPositionHeaderViewdelgate> delgate;

@end
