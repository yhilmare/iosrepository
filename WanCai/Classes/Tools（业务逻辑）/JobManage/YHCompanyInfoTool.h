//
//  YHCompanyInfoTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;

@interface YHCompanyInfoTool : NSObject


+ (void)getCompanyInfo:(void (^)(YHResultItem *result))block
               withCompanyId:(NSString *)companyId;
@end
