//
//  YHCompanyEnum.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHCompanyEnum : NSObject<MJKeyValue>

/**
 *  性质编号
 */
@property (nonatomic, copy) NSString *EnumId;
/**
 *  性质名称
 */
@property (nonatomic, copy) NSString *EnumName;

@end
