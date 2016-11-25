//
//  YHUserInfo.m
//  WanCai
//
//  Created by abing on 16/7/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHUserInfo.h"

@implementation YHUserInfo

- (instancetype) initWithDictionary:(NSDictionary *)dic{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype) yhUserInfoWithDictionary:(NSDictionary *)dic{
    return [[self alloc] initWithDictionary:dic];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.marriage = [aDecoder decodeObjectForKey:@"marriage"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
        self.degree = [aDecoder decodeObjectForKey:@"degree"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
        self.workYear = [aDecoder decodeObjectForKey:@"workYear"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.marriage forKey:@"marriage"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
    [aCoder encodeObject:self.degree forKey:@"degree"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeObject:self.workYear forKey:@"workYear"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.email forKey:@"email"];
}

@end
