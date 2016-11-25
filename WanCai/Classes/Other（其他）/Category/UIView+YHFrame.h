//
//  UIView+YHFrame.h
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YHFrame)

// Shortcuts for the coords
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

// shortcuts for frame properties
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

// shortcuts for positions
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@end
