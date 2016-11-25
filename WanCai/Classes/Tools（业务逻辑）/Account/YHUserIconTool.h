//
//  YHUserIconTool.h
//  WanCai
//
//  Created by CheungKnives on 16/8/8.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHReturnMsg;

@interface YHUserIconTool : NSObject

+ (void)uploadUserIcon:(NSString *)userId withPath:(NSString *)path withReturnObject:(void (^)(YHReturnMsg *))success;

@end
