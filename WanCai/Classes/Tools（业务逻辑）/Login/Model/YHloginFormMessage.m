//
//  YHloginFormMessage.m
//  WanCai
//
//  Created by abing on 16/7/2.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHloginFormMessage.h"

@implementation YHloginFormMessage

- (instancetype) initWithDictionary:(NSDictionary *)dic{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype) formMessageWithDictionary:(NSDictionary *)dic{
    return [[self alloc] initWithDictionary:dic];
}

@end
