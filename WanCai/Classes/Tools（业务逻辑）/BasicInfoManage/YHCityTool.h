//
//  YHCityTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;

@interface YHCityTool : NSObject

/**
 *  得到城市列表,结果保存于YHResultItem的rows中
 *
 *  @param parentID    所属省份的id
 */
+ (void)getCityList:(void (^)(YHResultItem *result))block withParentID:(NSString *)parentID;

@end
