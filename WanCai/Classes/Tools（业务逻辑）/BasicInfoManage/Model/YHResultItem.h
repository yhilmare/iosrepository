//
//  YHresultItem.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHResultItem : NSObject<MJKeyValue>

/**
 *  记录个数
 */
@property (nonatomic, copy) NSString *total;
/**
 *  省份数组,rows
 */
@property (nonatomic, copy) NSArray *rows;

@end
