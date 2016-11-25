//
//  YHLogintool.h
//  WanCai
//
//  Created by abing on 16/7/2.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHloginFormMessage;
@interface YHLogintool : NSObject

+ (void) getLoginResult:(YHloginFormMessage *)formMessage;

@end
