//
//  YHRegisteFormMessage.h
//  WanCai
//
//  Created by abing on 16/7/2.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHRegisteFormMessage : NSObject

@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *password;
@property(nonatomic, copy) NSString *passwordTest;
@property(nonatomic, copy) NSString *email;

- (BOOL) checkRegisteForm;

- (instancetype) initWithDictionary:(NSDictionary *)dic;

+ (instancetype) formMessageWithDictionary:(NSDictionary *)dic;

@end
