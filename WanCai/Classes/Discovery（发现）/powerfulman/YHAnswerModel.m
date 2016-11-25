//
//  YHAnswerModel.m
//  WanCai
//
//  Created by abing on 16/9/15.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHAnswerModel.h"

@implementation YHAnswerModel

+ (instancetype) modelWithDic:(NSDictionary *) dic{
    return [[self alloc] initWithDictionary:dic];
}
- (instancetype) initWithDictionary:(NSDictionary *) dic{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
