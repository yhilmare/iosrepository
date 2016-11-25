//
//  YHSearchTextField.m
//  WanCai
//
//  Created by abing on 16/7/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHSearchTextField.h"

@implementation YHSearchTextField

- (CGRect) placeholderRectForBounds:(CGRect)bounds{
    
    NSString *placeholder = @"请输入要查询的城市/地区";
    CGSize size = [placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    CGFloat x = (bounds.size.width - size.width) / 2.0;
    CGRect insect = CGRectMake(x, bounds.origin.y, size.width, size.height);
    return insect;
}

- (CGRect) textRectForBounds:(CGRect)bounds{
    
    CGRect insect = CGRectMake(bounds.origin.x + 35, bounds.origin.y, bounds.size.width, bounds.size.height);
    return insect;
}

- (CGRect) editingRectForBounds:(CGRect)bounds{
    CGRect insect = CGRectMake(bounds.origin.x + 35, bounds.origin.y, bounds.size.width, bounds.size.height);
    return insect;
}

- (CGRect) leftViewRectForBounds:(CGRect)bounds{
    
    CGFloat height = 30;
    CGFloat iconHeight = 15;
    CGFloat iconWidth = 17;
    CGFloat y = (height - iconHeight) / 2.0;
    CGRect insect = CGRectMake(15, y, iconHeight, iconWidth);
    return insect;
    
}

@end
