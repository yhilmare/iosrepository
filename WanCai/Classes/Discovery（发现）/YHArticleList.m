//
//  YHArticleList.m
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHArticleList.h"
#import "Ono.h"


static NSString *const kUrlStr=@"http://www.cithr.com.cn/ui/Study.aspx";
static NSString *const ImageBasicUrlStr = @"http://www.cithr.com.cn";
static NSString *const ArticalBasicUrlStr = @"www.cithr.com.cn/ui/";

@implementation YHArticleList

+(NSArray *)getNewPostsWithData:(NSData *)data {
    NSMutableArray *array=[NSMutableArray array];
    
    NSError *error;
    ONOXMLDocument *doc=[ONOXMLDocument HTMLDocumentWithData:data error:&error];
    ONOXMLElement *postsParentElement= [doc firstChildWithXPath:@".//*[@id='ph1_DataList1']"];
    [postsParentElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL * _Nonnull stop) {
        int i = 1;
        for (; i <= 4; i++) {
            YHArticleList *post=[YHArticleList postWithHtmlStr:element integer:i];
            if(post){
                [array addObject:post];
            }
        }
    }];
    return array;
}

+(instancetype)postWithHtmlStr:(ONOXMLElement*)element integer:(int)integer {
    
    YHArticleList *p=[YHArticleList new];
    ONOXMLElement *titleElement= [element firstChildWithXPath:[NSString stringWithFormat:@"td[%i]/li/a[2]",integer]];
    p.postUrl= [titleElement valueForAttribute:@"href"];
    p.title= [titleElement stringValue];
    ONOXMLElement *dateElement= [element firstChildWithXPath:[NSString stringWithFormat:@"td[%i]/li/div/div[1]", integer]];
    p.postDate= [dateElement stringValue];
    ONOXMLElement *imageElement = [element firstChildWithXPath:[NSString stringWithFormat:@"td[%i]/li/a[1]/img", integer]];
    p.imageUrl = [imageElement valueForAttribute:@"src"];
    return p;
}

-(void)setPostUrl:(NSString *)postUrl {
    _postUrl=[ArticalBasicUrlStr stringByAppendingString:postUrl];
    
}

- (void)setImageUrl:(NSString *)imageUrl {
    NSString *tempStr = [imageUrl substringFromIndex:2];
    _imageUrl = [ImageBasicUrlStr stringByAppendingString:tempStr];
}
@end
