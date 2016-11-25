//
//  YHADInfo.h
//  WanCai
//
//  Created by CheungKnives on 16/7/26.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHADInfo : NSObject

@property (nonatomic, copy) NSString *adImage;
@property (nonatomic, copy) NSString *adDesc;

+ (NSArray *)getADInfoList;

@end
