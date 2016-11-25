//
//  YHMenuView.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/4.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHMenuView.h"

@implementation YHMenuView


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context, 0, self.frame.size.height);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);
    
    [[UIColor colorWithRed:237 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1] setStroke];
    
    CGContextStrokePath(context);
}

@end
