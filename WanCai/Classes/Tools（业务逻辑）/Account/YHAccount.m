//
//  YHAccount.m
//  WanCai
//
//  Created by CheungKnives on 16/6/7.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHAccount.h"
#define YHResult @"result"
#define YHMsg @"msg"
#define YHuserId @"userId"
#define YHUserName @"UserName"

@implementation YHAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    YHAccount *account = [[self alloc] init];
    
    account.result = dict[YHResult];
    account.msg = dict[YHMsg];
    account.userId = dict[YHuserId];
    account.UserName = dict[YHUserName];
    
    return account;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_result forKey:YHResult];
    [aCoder encodeObject:_msg forKey:YHMsg];
    [aCoder encodeObject:_userId forKey:YHuserId];
    [aCoder encodeObject:_UserName forKey:YHUserName];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        _result = [aDecoder decodeObjectForKey:YHResult];
        _msg = [aDecoder decodeObjectForKey:YHMsg];
        _userId = [aDecoder decodeObjectForKey:YHuserId];
        _UserName = [aDecoder decodeObjectForKey:YHUserName];
    }
    return self;
}

@end
