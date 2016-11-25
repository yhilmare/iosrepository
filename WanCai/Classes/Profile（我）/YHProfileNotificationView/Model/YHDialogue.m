//
//  YHDialogue.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/4.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHDialogue.h"

@implementation YHDialogue

+ (instancetype) getObjectWithDictionary:(NSDictionary *) dic{
    
    YHDialogue *dialogue = [[self alloc] init];
    [dialogue setValuesForKeysWithDictionary:dic];
    return dialogue;
}


@end
