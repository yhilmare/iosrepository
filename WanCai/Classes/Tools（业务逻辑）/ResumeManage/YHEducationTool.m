//
//  YHEducationTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHEducationTool.h"
#import "YHResumeTool.h"
#import "YHSoapTool.h"
#import "MJExtension.h"
#import "YHResultItem.h"

#import "YHEducation.h"
#import "YHEducationInfo.h"
#import "YHReturnMsg.h"

@implementation YHEducationTool

+ (void)getEducationList:(void (^)(YHResultItem *))block withResumeId:(NSString *)resumeId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"GetEducationList";
    NSDictionary *dic = @{ @"resumeId" : resumeId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHEducation class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"根据简历id获取教育经历数据列表失败");
    }];
}

+ (void)getEducationInfo:(void (^)(YHResultItem *))block withEduId:(NSString *)eduId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"GetEducationInfoByEduId";
    NSDictionary *dic = @{ @"eduId" : eduId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHEducationInfo class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"根据教育经历id获取教育经历详细内容数据失败");
    }];
}

+ (void)addEducation:(void (^)(YHReturnMsg *))block
        withResumeId:(NSString *)resumeId
           startDate:(NSString *)startDate
             endDate:(NSString *)endDate
          schoolName:(NSString *)schoolName
               major:(NSString *)major
              degree:(NSString *)degree {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"AddEducation";
    NSDictionary *dic = @{ @"resumeId" : resumeId,
                           @"startDate" : startDate,
                           @"endDate" : endDate,
                           @"schoolName" : schoolName,
                           @"major" : major,
                           @"degree" : degree
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"添加教育经历失败");
    }];
}

+ (void)deleteEducation:(void (^)(YHReturnMsg *))block withEduId:(NSString *)eduId resumeId:(NSString *)resumeId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"DeleteEducationById";
    NSDictionary *dic = @{ @"eduId" : eduId,
                           @"resumeId" : resumeId
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"删除教育经历失败");
    }];
}

+ (void)updateEduInfoByEduId:(void (^)(YHReturnMsg *))block
                   withEduId:(NSString *)eduId
                   startdate:(NSString *)startdate
                  schoolName:(NSString *)schoolName
                       major:(NSString *)major
                      degree:(NSString *)degree {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"UpdateEduInfoByEduId";
    NSDictionary *dic = @{ @"eduId" : eduId,
                           @"startdate" : startdate,
                           @"schoolName" : schoolName,
                           @"degree" : degree
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"根据教育经历Id修改教育经历数据失败");
    }];
}


@end
