//
//  YHCompanyDesc.m
//  WanCai
//
//  Created by abing on 16/7/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHCompanyDesc.h"

@implementation YHCompanyDesc

- (CGSize) calculateStringSize:(CGSize )size
                       withStr:(NSString *) msg
                      withFont:(UIFont *)font{
    return [msg boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor blackColor]} context:nil].size;
}


- (void) setCompanyDesc:(NSString *)companyDesc{
    
    _companyDesc = companyDesc;
    
    CGFloat marginY = 10;
    CGFloat offset = 15;//文字距离手机边框的宽度
    CGFloat x = offset;
    CGFloat y = 10;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - offset * 2;
    CGSize size = [self calculateStringSize:CGSizeMake(maxWidth, MAXFLOAT) withStr:_companyDesc withFont:[UIFont systemFontOfSize:15]];
    _descFrame = CGRectMake(x, y, size.width, size.height);
    
    _rowHeight = CGRectGetMaxY(_descFrame) + marginY + 20;
}

@end
