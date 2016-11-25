//
//  YHProvenceTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;

@interface YHProvinceTool : NSObject

/**
 *  返回省份数据
 *
 *  @param  void (^)(YHresultItem *))block 供数据返回
 *
 */
+ (void)getProvinceItem:(void (^)(YHResultItem *result))block;

@end
