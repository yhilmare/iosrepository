//
//  YHProvince.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHProvince : NSObject<MJKeyValue>

/**
 *  省份名
 */
@property (nonatomic, copy) NSString *CityName;
/**
 *  省份编码
 */
@property (nonatomic, copy) NSString *CityCode;
/**
 *  省份id，根据省份id获取城市列表
 */
@property (nonatomic, copy) NSString *ID;

@end
