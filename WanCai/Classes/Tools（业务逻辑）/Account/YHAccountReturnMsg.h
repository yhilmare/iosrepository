//
//  YHAccountReturnMsg.h
//  WanCai
//
//  Created by CheungKnives on 16/6/7.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHAccountReturnMsg : NSObject<MJKeyValue>

@property (nonatomic, copy) NSString *result;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *userId;

@end
