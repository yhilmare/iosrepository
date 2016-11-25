//
//  YHRegisteFormMessage.m
//  WanCai
//
//  Created by abing on 16/7/2.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHRegisteFormMessage.h"

@implementation YHRegisteFormMessage



-(instancetype) initWithDictionary:(NSDictionary *)dic{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype) formMessageWithDictionary:(NSDictionary *)dic{
    return [[self alloc] initWithDictionary:dic];
}


- (BOOL) checkRegisteForm{
    
    if(self.userName.length == 0 || self.email.length == 0 || self.passwordTest.length == 0 || self.passwordTest.length == 0){
        return NO;
    }
    else if(self.password.length != self.passwordTest.length){
        return NO;
    }
    else if(![self.password isEqualToString:self.passwordTest]){
        return NO;
    }
    else{
        return YES;
    }
}

@end
