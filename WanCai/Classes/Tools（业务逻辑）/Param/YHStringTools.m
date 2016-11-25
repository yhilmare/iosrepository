//
//  YHStringTools.m
//  WanCai
//
//  Created by CheungKnives on 16/7/28.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHStringTools.h"

@implementation YHStringTools

+ (NSString *)htmlEntityDecode:(NSString *)string {
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"nbsp;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"br/" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"lt;" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"gt;" withString:@""];
    return string;
}

+ (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString {
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}

+ (NSString *)filterHTML:(NSString *)html {
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}
@end
