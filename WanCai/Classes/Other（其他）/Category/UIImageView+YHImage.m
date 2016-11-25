//
//  UIImageView+YHImage.m
//  WanCai
//
//  Created by CheungKnives on 16/8/4.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "UIImageView+YHImage.h"

@implementation UIImageView (YHImage)

// 返回虚线image的方法
+ (UIImage *)drawLineByImageView:(UIImageView *)imageView {
    UIGraphicsBeginImageContext(imageView.frame.size); //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度 1是高度
    CGFloat lengths[] = {5,1};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, [UIColor colorWithWhite:0.408 alpha:1.000].CGColor);
    CGContextSetLineDash(line, 0, lengths, 2); //画虚线
    //    CGContextSetLineDash(line, 0, <#const CGFloat * _Nullable lengths#>, <#size_t count#>)
    CGContextMoveToPoint(line, 0.0, 2.0); //开始画线
    CGContextAddLineToPoint(line, [UIScreen mainScreen].bounds.size.width - 10, 2.0);
    
    CGContextStrokePath(line);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}

@end
