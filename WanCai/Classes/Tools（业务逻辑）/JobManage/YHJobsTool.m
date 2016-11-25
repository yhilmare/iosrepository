//
//  YHJobsTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHJobsTool.h"
#import "YHResumeTool.h"
#import "YHSoapTool.h"
#import "MJExtension.h"
#import "YHResultItem.h"

#import "YHJobs.h"
#import "YHReturnMsg.h"

@implementation YHJobsTool

+ (void)getJobs:(void (^)(YHResultItem *))block
                            pagesize:(NSString *)pagesize
                           pageindex:(NSString *)pageindex
                          industryId:(NSString *)industryId
                       jobFunctionId:(NSString *)jobFunctionId
                      workLocationId:(NSString *)workLocationId
                            keywords:(NSString *)keywords
                            degreeId:(NSString *)degreeId
                    workexperienceId:(NSString *)workexperienceId
                       salaryRangeId:(NSString *)salaryRangeId
                         jobNatureId:(NSString *)jobNatureId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"JobManageInterface.asmx"];
    NSString *methodName = @"GetJobs";
    NSDictionary *dic = @{
                          @"pageSize" : pagesize,
                          @"pageIndex" : pageindex,
                          @"industryId" : industryId,
                          @"jobFunctionId" : jobFunctionId,
                          @"workLocationId" : workLocationId,
                          @"keywords" : keywords,
                          @"degreeId" : degreeId,
                          @"workexperienceId" : workexperienceId,
                          @"salaryRangeId" : salaryRangeId,
                          @"jobNatureId" : jobNatureId
                          };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHJobs class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        YHWriteToPlist(responseObject, @"jobs");
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"获取职位列表信息失败");
    }];
}

+ (void)getJobInfo:(void (^)(YHResultItem *))block withJobId:(NSString *)jobId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"JobManageInterface.asmx"];
    NSString *methodName = @"GetJobInfoById";
    NSDictionary *dic = @{ @"jobId" : jobId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHJobs class] };
        }];
        YHWriteToPlist(responseObject, @"jobInfo");
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"根据id获取职位列表信息失败");
    }];
}

+ (void)addFavoriteJob:(void (^)(YHReturnMsg *))block withuserId:(NSString *)userId jobIds:(NSString *)jobIds {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"JobManageInterface.asmx"];
    NSString *methodName = @"AddFavoriteJob";
    NSDictionary *dic = @{ @"userId" : userId,
                           @"jobIds" : jobIds
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"收藏职位失败");
    }];
}

+ (void)applyJob:(void (^)(YHReturnMsg *))block withuserId:(NSString *)userId jobIds:(NSString *)jobIds resumeId:(NSString *)resumeId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"JobManageInterface.asmx"];
    NSString *methodName = @"ApplyJob";
    NSDictionary *dic = @{ @"userId" : userId,
                           @"jobIds" : jobIds,
                           @"resumeId" : resumeId
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"申请职位失败");
    }];
}

+ (void)deleteMyJobFavoriteById:(void (^)(YHReturnMsg *))block withuserId:(NSString *)userId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"JobManageInterface.asmx"];
    NSString *methodName = @"DeleteMyJobFavoriteById";
    NSDictionary *dic = @{ @"id" : userId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
    } failure:^(NSError *error) {
        YHLog(@"删除收藏职位失败");
    }];
}

@end
