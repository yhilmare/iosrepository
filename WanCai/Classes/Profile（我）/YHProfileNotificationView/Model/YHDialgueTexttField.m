//
//  YHDialgueTexttField.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/5.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHDialgueTexttField.h"

@implementation YHDialgueTexttField

- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect editingRect = [super editingRectForBounds:bounds];
    editingRect.origin.x +=5;
    return editingRect;
}
//  重写文字显示时的X值
- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect textRect = [super editingRectForBounds:bounds];
    textRect.origin.x += 5;
    return textRect;
}


@end
