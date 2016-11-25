//
//  YHArticleList.h
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ONOXMLElement;

@interface YHArticleList : NSObject

@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *postDate;
@property (copy,nonatomic) NSString *postUrl;
@property (copy, nonatomic) NSString *imageUrl;

+(NSArray*)getNewPostsWithData:(NSData *)data;

@end
