//
//  YHLanguageAbilityTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHLanguageAbilityTool.h"
#import "YHResumeTool.h"
#import "YHSoapTool.h"
#import "MJExtension.h"
#import "YHResultItem.h"

#import "YHLanguageAbility.h"
#import "YHLanguageAbilityInfo.h"
#import "YHReturnMsg.h"

@implementation YHLanguageAbilityTool

+ (void)getLanguageAbilityList:(void (^)(YHResultItem *))block withResumeId:(NSString *)resumeId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"GetLanguageAbilityList";
    NSDictionary *dic = @{ @"resumeId" : resumeId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHLanguageAbility class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"获取语言能力数据列表接口失败");
    }];
}

+ (void)getLanguageAbilityInfo:(void (^)(YHResultItem *))block withLanguageId:(NSString *)languageId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"GetLanguageAbilityInfo";
    NSDictionary *dic = @{ @"languageId" : languageId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHLanguageAbilityInfo class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"根据语言能力id获取详细内容接口失败");
    }];
}

+ (void)addLanguageAbility:(void (^)(YHReturnMsg *))block
              withResumeId:(NSString *)resumeId
              languageType:(NSString *)languageType
            languageMaster:(NSString *)languageMaster
                 rwability:(NSString *)rwability
                 lsability:(NSString *)lsability {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"AddLanguageAbility";
    NSDictionary *dic = @{ @"resumeId" : resumeId,
                           @"languageType" : languageType,
                           @"languageMaster" : languageMaster,
                           @"rwability" : rwability,
                           @"lsability" : lsability
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"添加语言能力失败");
    }];
}

+ (void)deletLanguageAbility:(void (^)(YHReturnMsg *))block withLanguageId:(NSString *)languageId resumeId:(NSString *)resumeId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"DeletLanguageAbility";
    NSDictionary *dic = @{ @"languageId" : languageId,
                           @"resumeId" : resumeId
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"删除语言能力失败");
    }];
}

@end
