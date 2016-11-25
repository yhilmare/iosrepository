//
//  YHCity.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHCity : NSObject<MJKeyValue>

/**
 *  城市名称
 */
@property (nonatomic, copy) NSString *CityName;
/**
 *  城市编码
 */
@property (nonatomic, copy) NSString *CityCode;
/**
 *  所属省份ID
 */
@property (nonatomic, copy) NSString *ParentID;

@end
