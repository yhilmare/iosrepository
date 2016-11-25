//
//  YHCompanyEnumTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;

@interface YHCompanyEnumTool : NSObject

+ (void)getCompanyEnum:(void (^)(YHResultItem *result))block withEnumTypeId:(NSString *)enumTypeId;

@end
