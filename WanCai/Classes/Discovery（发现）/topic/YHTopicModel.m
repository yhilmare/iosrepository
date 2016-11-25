//
//  YHTopicModel.m
//  WanCai
//
//  Created by abing on 16/9/14.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHTopicModel.h"

@implementation YHTopicModel

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
