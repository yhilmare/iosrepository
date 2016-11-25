//
//  YHButtonModelFrame.m
//  WanCai
//
//  Created by abing on 16/7/15.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHButtonModelFrame.h"
#import "YHButtonModel.h"

@implementation YHButtonModelFrame

- (CGRect) calculateFrameWidthPercent: (CGFloat) itemWidthPer
                    itemHeightPercent: (CGFloat) itemHeightPer
                         itemxPercent: (CGFloat) itemXPer
                         itemYPercent: (CGFloat) itemYPer{
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 60;
    CGFloat height = 44;
    
    CGFloat itemWidth = width * itemWidthPer;
    CGFloat itemHeight = height * itemHeightPer;
    CGFloat itemX = itemXPer * width;
    CGFloat itemY = height * itemYPer - 0.5 * itemHeight;
    
    return CGRectMake(itemX, itemY, itemWidth, itemHeight);
}


- (void)setModel:(YHButtonModel *)model{
    _model = model;
    CGFloat YPer = 0.9;
    CGFloat marginY = 5;
    if (model.hotcity1.length != 0){
        _hotcity1 = [self calculateFrameWidthPercent:0.32 itemHeightPercent:YPer itemxPercent:0.05 itemYPercent:0.5];
        _rowHeight = 44 + marginY;
    }
    if (model.hotcity2.length != 0){
        _hotcity2 = [self calculateFrameWidthPercent:0.32 itemHeightPercent:YPer itemxPercent:0.42 itemYPercent:0.5];
    }
    if (model.hotcity3.length != 0){
        _hotcity3 = [self calculateFrameWidthPercent:0.32 itemHeightPercent:YPer itemxPercent:0.79 itemYPercent:0.5];
    }
    if (model.hotcity4.length != 0){
        _hotcity4 = [self calculateFrameWidthPercent:0.32 itemHeightPercent:YPer itemxPercent:0.05 itemYPercent:1.5];
        _rowHeight = CGRectGetMaxY(_hotcity4) + marginY;
    }
    if (model.hotcity5.length != 0){
        _hotcity5 = [self calculateFrameWidthPercent:0.32 itemHeightPercent:YPer itemxPercent:0.42 itemYPercent:1.5];
    }
    if (model.hotcity6.length != 0){
        _hotcity6 = [self calculateFrameWidthPercent:0.32 itemHeightPercent:YPer itemxPercent:0.79 itemYPercent:1.5];
    }
    if (model.hotcity7.length != 0){
        _hotcity7 = [self calculateFrameWidthPercent:0.32 itemHeightPercent:YPer itemxPercent:0.05 itemYPercent:2.5];
        _rowHeight = CGRectGetMaxY(_hotcity7) + marginY;

    }
    if (model.hotcity8.length != 0){
        _hotcity8 = [self calculateFrameWidthPercent:0.32 itemHeightPercent:YPer itemxPercent:0.42 itemYPercent:2.5];

    }
    if (model.hotcity9.length != 0){
        _hotcity9 = [self calculateFrameWidthPercent:0.32 itemHeightPercent:YPer itemxPercent:0.79 itemYPercent:2.5];
    }
}

@end
