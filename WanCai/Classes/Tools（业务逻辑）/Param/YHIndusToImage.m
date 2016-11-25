//
//  YHIndusToImage.m
//  WanCai
//
//  Created by CheungKnives on 16/7/27.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHIndusToImage.h"
#import "MJExtension.h"

@implementation YHIndusToImage

+ (NSArray *)getInfoList {
    NSArray *tempArr = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"indusToImageName" ofType:@"plist"];
    tempArr = [YHIndusToImage mj_objectArrayWithFile:path];
    
    return tempArr;
}

@end
