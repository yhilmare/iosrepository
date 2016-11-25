//
//  YHSoapTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/7.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHSoapTool.h"
#import "AFNetworking.h"
#import "YHStringTools.h"

@implementation YHSoapTool

+ (void)getDataWithURl:(NSString *)url
            methodName:(NSString *)methodName
              soapBody:(NSString *)soapBody
               success:(void (^)(id responseObject))success
               failure:(void(^)(NSError *error))failure {
    
    NSString *soapStr = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                         <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"\
                         xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                         <soap:Header>\
                         </soap:Header>\
                         <soap:Body>%@</soap:Body>\
                         </soap:Envelope>",soapBody];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    // 设置请求超时时间
    manager.requestSerializer.timeoutInterval = 30;
    
    // 返回NSData(设置为JSON返回格式时，有莫名的错误)
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 设置请求头，也可以不设置
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%zd", soapStr.length] forHTTPHeaderField:@"Content-Length"];
    
    // 拦截AFnetworik方法，设置HTTPBody
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapStr;
    }];
    
    
    
    
    [manager POST:url parameters:soapStr success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 把返回的二进制数据转为字符串
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        
//        if ([methodName isEqualToString:@"GetJobs"]) {
//            NSString *str = [result substringFromIndex:278];
//            NSUInteger uInteger =  str.length - 62;
//            NSString *str1 = [str substringToIndex:uInteger];
//            
//            NSMutableString *str2 = [NSMutableString stringWithFormat:@"%@", [YHStringTools htmlEntityDecode:str1]];
//            NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"div[^\u4E00-\u9FA5]{0,}div?" options:NSRegularExpressionCaseInsensitive error:nil];
//            NSArray<NSTextCheckingResult *> *temp = [regular matchesInString:str2 options:0 range:NSMakeRange(0, str2.length)];
//            NSMutableArray<NSString *> *array = [NSMutableArray array];
//            for(NSTextCheckingResult *result in temp){
//                NSString *str3 = [str2 substringWithRange:result.range];
//                [array addObject:str3];
//            }
//            for(NSString *dest in array){
//                NSRange range = [str2 rangeOfString:dest options:NSCaseInsensitiveSearch];
//                [str2 deleteCharactersInRange:range];
//            }
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str2 dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
//            if (success) {
//                success(dic);
//            }
//        }else if([methodName isEqualToString:@"GetComInfoById"]){
            NSString *patternString = [NSString stringWithFormat:@"(?<=%@Result\\>).*(?=</%@Result)", methodName, methodName];
            NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:patternString options:NSRegularExpressionCaseInsensitive error:nil];
            NSTextCheckingResult *res = [[regular matchesInString:result options:0 range:NSMakeRange(0, result.length)] firstObject];
            result = [result substringWithRange:res.range];
            
            NSDictionary *dict = [NSDictionary dictionary];
            NSMutableString *str2 = [NSMutableString stringWithFormat:@"%@", [YHStringTools htmlEntityDecode:result]];
            regular = [[NSRegularExpression alloc] initWithPattern:@"div[^\u4E00-\u9FA5]{0,}div?" options:NSRegularExpressionCaseInsensitive error:nil];
            NSArray<NSTextCheckingResult *> *temp = [regular matchesInString:str2 options:0 range:NSMakeRange(0, str2.length)];
            NSMutableArray<NSString *> *array = [NSMutableArray array];
            for(NSTextCheckingResult *result in temp){
                NSString *str3 = [str2 substringWithRange:result.range];
                [array addObject:str3];
            }
            for(NSString *dest in array){
                NSRange range = [str2 rangeOfString:dest options:NSCaseInsensitiveSearch];
                [str2 deleteCharactersInRange:range];
            }
            dict = [NSJSONSerialization JSONObjectWithData:[str2 dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            // 请求成功并且结果有值把结果传出去
            if (success) {
                success(dict);
            }
//        }else {
//            // 正则表达式取出result
//            NSString *patternString = [NSString stringWithFormat:@"(?<=%@Result\\>).*(?=</%@Result)", methodName, methodName];
//            NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:patternString options:NSRegularExpressionCaseInsensitive error:nil];
//            
//            NSDictionary *dict = [NSDictionary dictionary];
//            for (NSTextCheckingResult *checkingResult in [regular matchesInString:result options:0 range:NSMakeRange(0, result.length)]) {
//                dict = [NSJSONSerialization JSONObjectWithData:[[result substringWithRange:checkingResult.range] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
//            }
//            // 请求成功并且结果有值把结果传出去
//            if (success) {
//                success(dict);
//            }
//         }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
    
    
//    [manager POST:url parameters:soapStr success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        // 把返回的二进制数据转为字符串
//        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        
//        // 正则表达式取出result
//        NSString *patternString = [NSString stringWithFormat:@"(?<=%@Result\\>).*(?=</%@Result)", methodName, methodName];
//        NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:patternString options:NSRegularExpressionCaseInsensitive error:nil];
//        
//        NSDictionary *dict = [NSDictionary dictionary];
//        for (NSTextCheckingResult *checkingResult in [regular matchesInString:result options:0 range:NSMakeRange(0, result.length)]) {
//            dict = [NSJSONSerialization JSONObjectWithData:[[result substringWithRange:checkingResult.range] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
//        }
//        // 请求成功并且结果有值把结果传出去
//        if (success) {
//            success(dict);
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
}


+ (NSString*)getCompleteURlWithSecondaryURL:(NSString *)secondaryURL {
    return [NSString stringWithFormat:@"%@%@", YHServerURL, secondaryURL];
}


+ (NSString *)getSoapBodyStrWithMethodName:(NSString *)methodName AttrDic:(NSDictionary *)dic {
    if (dic.count == 0) {// 为空字典
        return [NSString stringWithFormat:@"<%@ xmlns=\"http://tempuri.org/\"/>",methodName];
    } else {
        NSString *attrString = @"";
        NSString *temStr;
        // 遍历属性dic
        for (NSString *key in dic) {
            temStr = [NSString stringWithFormat:@"<%@>%@</%@>", key, dic[key], key];
            attrString = [attrString stringByAppendingString:temStr];
        }
        return [NSString stringWithFormat:@"<%@ xmlns=\"http://tempuri.org/\">%@</%@>", methodName, attrString, methodName];
    }
}

@end
