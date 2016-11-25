//
//  YHTableViewHeaderView.h
//  WanCai
//
//  Created by abing on 16/7/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHTableViewHeaderViewDelgate <NSObject>

@required
- (void) didClickSearchButton:(UITextField *)textFiled;

@end

@interface YHTableViewHeaderView : UIView

@property(nonatomic, assign)id<YHTableViewHeaderViewDelgate> delgate;
@property (nonatomic, strong) UILabel *textLabel;

@end
