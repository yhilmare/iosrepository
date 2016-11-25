//
//  YHHomeButton.m
//  WanCai
//
//  Created by abing on 16/7/23.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHHomeButton.h"

@implementation YHHomeButton

- (void) layoutSubviews{
    
    //[super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat itemWidthAndHeight = ((width >= height)?height:width) * 0.75 + 3;
    CGFloat x = (width - itemWidthAndHeight) / 2.0;
    self.imageView.layer.cornerRadius = itemWidthAndHeight / 2.0;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.frame = CGRectMake(x, 0, itemWidthAndHeight, itemWidthAndHeight);
    
    CGFloat y = CGRectGetMaxY(self.imageView.frame) + 6;
    CGFloat itemHeight = height - y;
    self.titleLabel.frame = CGRectMake(x, y, itemWidthAndHeight, itemHeight);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
}

@end
