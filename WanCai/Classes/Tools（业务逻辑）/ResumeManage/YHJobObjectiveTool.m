//
//  YHJobObjectiveTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHJobObjectiveTool.h"
#import "YHResumeTool.h"
#import "YHSoapTool.h"
#import "MJExtension.h"
#import "YHResultItem.h"

#import "YHJobObjectiveInfo.h"
#import "YHReturnMsg.h"

@implementation YHJobObjectiveTool

+ (void)getJobObjectiveInfo:(void (^)(YHResultItem *))block withResumeId:(NSString *)resumeId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"GetJobObjectiveInfo";
    NSDictionary *dic = @{ @"resumeId" : resumeId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHJobObjectiveInfo class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"根据简历id获取求职意向基本信息数据失败");
    }];
}

+ (void)updateJobObjective:(void (^)(YHReturnMsg *))block
              withResumeId:(NSString *)resumeId
        expectIndustryType:(NSString *)expectIndustryType
                 expectjob:(NSString *)expectjob
            expectlocation:(NSString *)expectlocation
                 jobnature:(NSString *)jobnature
              expectSalary:(NSString *)expectSalary{
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"ResumeManageInterface.asmx"];
    NSString *methodName = @"GetJobObjectiveInfo";
    NSDictionary *dic = @{ @"resumeId" : resumeId,
                           @"expectIndustryType" : expectIndustryType,
                           @"expectjob" : expectjob,
                           @"expectlocation" : expectlocation,
                           @"jobnature" : jobnature,
                           @"expectSalary" : expectSalary
                           };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *resultItem = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"修改求职意向失败");
    }];
}
@end
