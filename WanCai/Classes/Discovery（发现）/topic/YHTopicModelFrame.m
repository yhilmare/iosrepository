//
//  YHTopicModelFrame.m
//  WanCai
//
//  Created by abing on 16/9/14.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHTopicModelFrame.h"
#import "YHTopicModel.h"

@implementation YHTopicModelFrame

- (void) setModel:(YHTopicModel *)model{
    _model = model;
    
    CGSize size = [_model.detailMsg boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 60) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    self.rowHeight = 110 + size.height;
}

@end
