//
//  YHIndusToImageTool.m
//  WanCai
//
//  Created by CheungKnives on 16/7/27.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHIndusToImageTool.h"
#import "YHIndusToImage.h"
#import "MJExtension.h"

@implementation YHIndusToImageTool

+ (NSString *)getIconWithIndustry:(NSString *)industry {
    NSArray *arr = [YHIndusToImage getInfoList];
    for (YHIndusToImage *intoi in arr) {
        if ([intoi.IndustryName isEqualToString:industry]) {
            return intoi.iconImage;
        }
    }
    return @"ind_other";
}
@end
