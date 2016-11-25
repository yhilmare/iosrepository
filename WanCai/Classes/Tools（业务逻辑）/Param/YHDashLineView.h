//
//  YHDashLineView.h
//  WanCai
//
//  Created by CheungKnives on 16/8/5.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHDashLineView : UIView {
    CGFloat dashLineWidth;//虚线粗细宽度
}
//虚线颜色
@property (strong, nonatomic) UIColor *dashLineColor;

-(void)setLineColor:(UIColor *)lineColor LineWidth:(CGFloat)lineWidth;

@end
