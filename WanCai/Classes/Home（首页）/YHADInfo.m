//
//  YHADInfo.m
//  WanCai
//
//  Created by CheungKnives on 16/7/26.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHADInfo.h"
#import "MJExtension.h"

@interface YHADInfo()

@end
@implementation YHADInfo

+ (NSArray *)getADInfoList {
    NSArray *tempArr = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ADInformation" ofType:@"plist"];
    tempArr = [YHADInfo mj_objectArrayWithFile:path];
    
    return tempArr;
}

@end
