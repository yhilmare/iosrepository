//
//  YHWorkExperienceTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHWorkExperienceTool.h"
#import "YHResumeTool.h"
#import "YHSoapTool.h"
#import "MJExtension.h"
#import "YHResultItem.h"

#import "YHWorkExperience.h"
#import "YHReturnMsg.h"

@implementation YHWorkExperienceTool

+ (void)getWorkExperienceList:(void (^)(YHResultItem *))block withResumeId:(NSString *)resumeId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"GetWorkExperienceList";
    NSDictionary *dic = @{ @"resumeId" : resumeId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHWorkExperience class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"获取工作经历数据接口失败");
    }];
}

+ (void)getWorkExperienceInfo:(void (^)(YHResultItem *))block withWorkId:(NSString *)workId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"GetWorkExperienceInfo";
    NSDictionary *dic = @{ @"workId" : workId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHWorkExperience class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"根据工作经历Id获取工作经历详细内容数据失败");
    }];
}

+ (void)addWorkExperience:(void (^)(YHReturnMsg *))block
             withResumeId:(NSString *)resumeId
                startdate:(NSString *)startdate
                  enddate:(NSString *)enddate
              companyName:(NSString *)companyName
            companyNature:(NSString *)companyNature
              companySize:(NSString *)companySize
          companyIndustry:(NSString *)companyIndustry
              subFunction:(NSString *)subFunction
            responsiblity:(NSString *)responsiblity {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"AddWorkExperience";
    NSDictionary *dic = @{ @"resumeId" : resumeId,
                           @"startdate" : startdate,
                           @"enddate" : enddate,
                           @"companyName" : companyName,
                           @"companyNature" : companyNature,
                           @"companySize" : companySize,
                           @"companyIndustry" : companyIndustry,
                           @"subFunction" : subFunction,
                           @"responsiblity" : responsiblity
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"添加工作经历失败");
    }];
}

+ (void)deleteWorkExperice:(void (^)(YHReturnMsg *))block withWorkId:(NSString *)workId resumeId:(NSString *)resumeId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"DeleteWorkExpericeById";
    NSDictionary *dic = @{ @"workId" : workId,
                           @"resumeId" : resumeId
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"删除工作经历失败");
    }];
}

+ (void)updateWorkExperience:(void (^)(YHReturnMsg *))block
                  withWorkId:(NSString *)workId
                   startdate:(NSString *)startdate
                     enddate:(NSString *)enddate
                 companyName:(NSString *)companyName
               companyNature:(NSString *)companyNature
                 companySize:(NSString *)companySize
             companyIndustry:(NSString *)companyIndustry
                 subFunction:(NSString *)subFunction
               responsiblity:(NSString *)responsiblity {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"UpdateWorkExperience";
    NSDictionary *dic = @{ @"startdate" : startdate,
                           @"enddate" : enddate,
                           @"companyName" : companyName,
                           @"companyNature" : companyNature,
                           @"companySize" : companySize,
                           @"companyIndustry" : companyIndustry,
                           @"subFunction" : subFunction,
                           @"responsiblity" : responsiblity,
                           @"workId" : workId
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"修改工作经历数据失败");
    }];
}

@end
