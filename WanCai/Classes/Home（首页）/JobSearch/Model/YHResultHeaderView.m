//
//  YHResultHeaderView.m
//  WanCai
//
//  Created by yh_swjtu on 16/7/27.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHResultHeaderView.h"

@implementation YHResultHeaderView


- (void)drawRect:(CGRect)rect {
    
    CGFloat marginX = self.frame.size.width / 4.0;
    CGFloat y = 15;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, marginX, y);
    CGContextAddLineToPoint(context, marginX, self.frame.size.height - y);
    
    CGContextMoveToPoint(context, marginX * 2, y);
    CGContextAddLineToPoint(context, marginX * 2, self.frame.size.height - y);
    
    CGContextMoveToPoint(context, marginX * 3, y);
    CGContextAddLineToPoint(context, marginX * 3, self.frame.size.height - y);
    
    CGContextMoveToPoint(context, 0, self.frame.size.height);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);
    
    CGContextSetLineWidth(context, 1);
    [[UIColor colorWithRed:237 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1] setStroke];
    CGContextStrokePath(context);
}


@end
