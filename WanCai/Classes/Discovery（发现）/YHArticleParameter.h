//
//  YHArticleParameter.h
//  WanCai
//
//  Created by CheungKnives on 16/7/21.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHArticleParameter : NSObject

@property (nonatomic, copy) NSString *__EVENTARGUMENT;
@property (nonatomic, copy) NSString *__EVENTTARGET;
@property (nonatomic, copy) NSString *__VIEWSTATE;
@property (nonatomic, copy) NSString *__VIEWSTATEGENERATOR;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)articleParameterWithDic:(NSDictionary *)dic;

+ (NSArray *)articleParameterList;

@end
