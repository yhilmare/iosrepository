//
//  YHArticleParameter.m
//  WanCai
//
//  Created by CheungKnives on 16/7/21.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHArticleParameter.h"

@implementation YHArticleParameter

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.__EVENTARGUMENT = dic[@"__EVENTARGUMENT"];
        self.__EVENTTARGET = dic[@"__EVENTTARGET"];
        self.__VIEWSTATE = dic[@"__VIEWSTATE"];
        self.__VIEWSTATEGENERATOR = dic[@"__VIEWSTATEGENERATOR"];
    }
    return self;
}
+ (instancetype)articleParameterWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

+ (NSArray *)articleParameterList {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"DisArticleParameter" ofType:@"plist"];
    NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (NSDictionary *dic in dicArray) {
        YHArticleParameter *articlePara = [YHArticleParameter articleParameterWithDic:dic];
        
        [tmpArray addObject:articlePara];
    }
    return tmpArray;
}

@end
