//
//  YHResumeTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHResumeTool.h"
#import "YHResumeTool.h"
#import "YHSoapTool.h"
#import "MJExtension.h"
#import "YHResultItem.h"

#import "YHResume.h"
#import "YHResumeBasicInfo.h"
#import "YHReturnMsg.h"

#import "YHProfileResumeModel.h"

@implementation YHResumeTool

+ (void)getResumeList:(void (^)(YHResultItem *))block withuserId:(NSString *)userId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"GetResumeList";
    NSDictionary *dic = @{ @"userId" : userId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHResume class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"获取用户简历数据失败");
    }];
}

+ (void)getResumeBasicInfo:(void (^)(YHResultItem *))block withResumeId:(NSString *)resumeId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"GetResumeBasicInfoById";
    NSDictionary *dic = @{ @"resumeId" : resumeId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHResumeBasicInfo class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"根据简历Id获取简历基本信息详细内容失败");
    }];
}

+ (void)createResume:(void (^)(YHReturnMsg *))block
          withuserId:(NSString *)userId
          resumeName:(NSString *)resumeName
            userName:(NSString *)userName
              gender:(NSString *)gender
            marriage:(NSString *)marriage
            birthday:(NSString *)birthday
              degree:(NSString *)degree
            workyear:(NSString *)workyear
              mobile:(NSString *)mobile
               email:(NSString *)email
            location:(NSString *)location
    policticalstatus:(NSString *)policticalstatus
       seleveluation:(NSString *)seleveluation
  expectIndustryType:(NSString *)expectIndustryType
           expectJob:(NSString *)expectJob
      expectLocation:(NSString *)expectLocation
           jobNature:(NSString *)jobNature
        expectSalary:(NSString *)expectSalary {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"CreateResume";
    NSDictionary *dic = @{ @"userId" : userId,
                           @"resumeName" : resumeName,
                           @"userName" : userName,
                           @"gender" : gender,
                           @"marriage" : marriage,
                           @"birthday" : birthday,
                           @"degree" : degree,
                           @"workyear" : workyear,
                           @"mobile" : mobile,
                           @"email" : email,
                           @"location" : location,
                           @"policticalstatus" : policticalstatus,
                           @"seleveluation" : seleveluation,
                           @"expectIndustryType" : expectIndustryType,
                           @"expectJob" : expectJob,
                           @"expectLocation" : expectLocation,
                           @"jobNature" : jobNature,
                           @"expectSalary" : expectSalary
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"创建简历失败");
    }];
}

#pragma mark - 通过Resume创建简历
+ (void)createResumeByModel: (YHProfileResumeModel *)dic calback: (void(^)(YHReturnMsg *))block {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"CreateResume";
    NSDictionary *param = @{
                            @"userId" :         dic.userId,
                            @"resumeName" :     dic.resumeName,
                            @"userName" :       dic.userName,
                            @"gender" :         dic.genderCoder,
                            @"marriage" :       dic.marriageCoder,
                            @"birthday" :       @"1995-09-11",
                            @"degree" :         dic.degreeCoder,
                            @"workyear" :       dic.workyearCoder,
                            @"mobile" :         dic.mobile,
                            @"email" :          dic.email,
                            @"location" :       dic.locationCoder,
                            @"policticalstatus": dic.policicalstatusCoder,
                            @"seleveluation" :  dic.seleveluation,
                            @"expectIndustryType" : dic.expectIndustryType,
                            @"expectJob" :      dic.expertJob,
                            @"expectLocation" : dic.expectLocationCoder,
                            @"jobNature" :      dic.jobNatureCoder,
                            @"expectSalary" : dic.expectSalaryCoder,
                            };
    
    
    NSString *sopaBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:param];
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:sopaBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        YHLog(@"创建简历失败");
    }];
    
}


+ (void)deleteResume:(void (^)(YHReturnMsg *))block withResumeId:(NSString *)resumeId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"DeleteResumeById";
    NSDictionary *dic = @{ @"resumeId" : resumeId};
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"删除简历失败");
    }];
}

+ (void)updateResumeBasicInfo:(void (^)(YHReturnMsg *))block
                 withResumeId:(NSString *)resumeId
                   resumeName:(NSString *)resumeName
                     userName:(NSString *)userName
                       gender:(NSString *)gender
                     marriage:(NSString *)marriage
                     birthday:(NSString *)birthday
                       degree:(NSString *)degree
                     location:(NSString *)location
                     workyear:(NSString *)workyear
                       mobile:(NSString *)mobile
                        email:(NSString *)email
              politicalStatus:(NSString *)politicalStatus
                selfEvalation:(NSString *)selfEvalation {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"UpdateResumeBasicInfo";
    NSDictionary *dic = @{ @"resumeId" : resumeId,
                           @"resumeName" : resumeName,
                           @"userName" : userName,
                           @"gender" : gender,
                           @"marriage" : marriage,
                           @"birthday" : birthday,
                           @"degree" : degree,
                           @"location" : location,
                           @"workyear" : workyear,
                           @"mobile" : mobile,
                           @"email" : email,
                           @"politicalStatus" : politicalStatus,
                           @"selfEvalation" : selfEvalation
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"修改简历失败");
    }];
}

+ (void)updateResumePrivacy:(void (^)(YHReturnMsg *))block withResumeId:(NSString *)resumeId privacy:(NSString *)privacy {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"UpdateResumePrivacy";
    NSDictionary *dic = @{ @"resumeId" : resumeId,
                           @"privacy" : privacy
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"设置简历的公开程度失败");
    }];
}

@end
