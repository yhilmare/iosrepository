//
//  YHCompanyMsg.m
//  WanCai
//
//  Created by abing on 16/7/17.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHCompanyMsg.h"

@implementation YHCompanyMsg

- (void) setCompanyRequired:(NSString *)companyRequired{
    _companyRequired = companyRequired.length == 0?@"企业暂时没有供职位要求":companyRequired;
    CGSize size = [self calculateSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 35, MAXFLOAT) withString:_companyRequired withFont:[UIFont systemFontOfSize:15] withColor:[UIColor blackColor]];
    _requiredRect = CGRectMake(17, 40, size.width, size.height);
}

- (void) setCompanyDescribtion:(NSString *)companyDescribtion{
    _companyDescribtion = companyDescribtion.length == 0?@"企业暂时没有供职位描述":companyDescribtion;
    CGSize size = [self calculateSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 35, MAXFLOAT) withString:_companyDescribtion withFont:[UIFont systemFontOfSize:15] withColor:[UIColor blackColor]];
    _describtionRect = CGRectMake(17, CGRectGetMaxY(_requiredRect) + 50, size.width, size.height);
 }
 
 - (void) setCompanyAddress:(NSString *)companyAddress{
     _companyAddress = companyAddress;
 
     CGSize size = [self calculateSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 35, MAXFLOAT) withString:_companyAddress withFont:[UIFont systemFontOfSize:15] withColor:[UIColor blackColor]];
     _addressRect = CGRectMake(17, CGRectGetMaxY(_describtionRect) + 50, size.width, size.height);
 }
 
 - (void) setCompanyContactPerson:(NSString *)companyContactPerson{
     _companyContactPerson = companyContactPerson;
     CGSize size = [self calculateSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 35, MAXFLOAT) withString:_companyContactPerson withFont:[UIFont systemFontOfSize:15] withColor:[UIColor blackColor]];
     _contactPersonRect = CGRectMake(17, CGRectGetMaxY(_addressRect) + 50, size.width, size.height);
 }
 
 - (void) setCompanyContact:(NSString *)companyContact{
     _companyContact = companyContact;
     CGSize size = [self calculateSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 35, MAXFLOAT) withString:_companyContact withFont:[UIFont systemFontOfSize:15] withColor:[UIColor blackColor]];
     _contactRect = CGRectMake(17, CGRectGetMaxY(_contactPersonRect) + 50, size.width, size.height);
     _rowHeight = CGRectGetMaxY(_contactRect) + 30;
 }
 
 - (CGSize) calculateSize:(CGSize)maxSize
               withString:(NSString *) string
                 withFont:(UIFont *)font
                withColor:(UIColor *)color{
 return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color} context:nil].size;
 }


@end
