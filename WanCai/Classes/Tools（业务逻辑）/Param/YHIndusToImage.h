//
//  YHIndusToImage.h
//  WanCai
//
//  Created by CheungKnives on 16/7/27.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHIndusToImage : NSObject

@property (nonatomic, copy) NSString *IndustryName;
@property (nonatomic, copy) NSString *iconImage;

+ (NSArray *)getInfoList;

@end
