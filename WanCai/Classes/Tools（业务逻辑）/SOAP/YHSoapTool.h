//
//  YHSoapTool.h
//  WanCai
//
//  Created by CheungKnives on 16/6/7.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSoapTool : NSObject

/**
 *  以soap方式请求数据，返回JSON格式的数据
 *
 *  @param url          由此类中的completeURlWithSecondaryURL获取
 *  @param methodName   将要调用的方法名
 *  @param soapBody     由此类中的getSoapBodyStr方法获取
 *  @param success      success
 *  @param failure      failure
 */
+ (void)getDataWithURl:(NSString *)url
            methodName:(NSString *)methodName
              soapBody:(NSString *)soapBody
               success:(void (^)(id responseObject))success
               failure:(void(^)(NSError *error))failure;

/**
 *  拼接完整的url
 *
 *  @param secondaryURL 前方没有'/'，eg：BasicInfoManageInterface.asmx
 *
 *  @return 完整的url
 */
+ (NSString *)getCompleteURlWithSecondaryURL:(NSString *)secondaryURL;

/**
 *  获取整的soapBody
 *
 *  @param methodName 将要调用的方法.eg：GetProvince
 *  @param dic        调用方法中的形参，以字典的方式传入，若没有形参则传入nil.
 *
 *  @return 完整的soapBody
 */
+ (NSString *)getSoapBodyStrWithMethodName:(NSString *)methodName AttrDic:(NSDictionary *)dic;

@end
