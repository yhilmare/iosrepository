//
//  YHTrainExperiencTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHTrainExperiencTool.h"
#import "YHResumeTool.h"
#import "YHSoapTool.h"
#import "MJExtension.h"
#import "YHResultItem.h"

#import "YHTrainExperience.h"
#import "YHReturnMsg.h"

@implementation YHTrainExperiencTool

+ (void)getTrainExperienceList:(void (^)(YHResultItem *))block withResumeId:(NSString *)resumeId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"GetTrainExperienceList";
    NSDictionary *dic = @{ @"resumeId" : resumeId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHTrainExperience class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"获取培训经历列表数据接口失败");
    }];
}

+ (void)getTainInfo:(void (^)(YHResultItem *))block withTrainId:(NSString *)trainId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"GetTainInfo";
    NSDictionary *dic = @{ @"trainId" : trainId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHTrainExperience class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"根据培训经历id获取培训经历的详细内容接口失败");
    }];
}

+ (void)addTrainExperience:(void (^)(YHReturnMsg *))block
              withResumeId:(NSString *)resumeId
                 startdate:(NSString *)startdate
                   enddate:(NSString *)enddate
                  trainOrg:(NSString *)trainOrg
                 className:(NSString *)className
               description:(NSString *)description {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"AddTrainExperience";
    NSDictionary *dic = @{ @"resumeId" : resumeId,
                           @"startdate" : startdate,
                           @"enddate" : enddate,
                           @"trainOrg" : trainOrg,
                           @"className" : className,
                           @"description" : description
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"添加培训经历失败");
    }];
}

+ (void)deletetrainExperience:(void (^)(YHReturnMsg *))block withResumeId:(NSString *)resumeId trainId:(NSString *)trainId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"DeleteTrainExperience";
    NSDictionary *dic = @{ @"resumeId" : resumeId,
                           @"trainId" : trainId
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"删除培训经历失败");
    }];
}

+ (void)updateTrainExperience:(void (^)(YHReturnMsg *))block
                  withTrainId:(NSString *)trainId
                    startdate:(NSString *)startdate
                      enddate:(NSString *)enddate
                     trainOrg:(NSString *)trainOrg
                    className:(NSString *)className
                  description:(NSString *)description {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"UpdateTrainExperience";
    NSDictionary *dic = @{ @"startdate" : startdate,
                           @"enddate" : enddate,
                           @"trainOrg" : trainOrg,
                           @"className" : className,
                           @"description" : description,
                           @"trainId" : trainId
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"修改培训经历失败");
    }];
}
@end
