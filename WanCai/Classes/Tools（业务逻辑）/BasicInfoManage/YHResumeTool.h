//
//  YHResumeTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHResultItem;

@interface YHResumeTool : NSObject

/**
 *  获取简历信息敞亮数据接口,根据类别得到枚举内容
 *
 *  @param  void (^)(YHResultItem *))block 供数据返回
 *
 */
+ (void)getResumeEnum:(void (^)(YHResultItem *result))block withEnumType:(NSString *)stringID;

@end
