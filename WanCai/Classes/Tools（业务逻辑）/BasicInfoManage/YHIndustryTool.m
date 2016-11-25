//
//  YHIndustryTool.m
//  WanCai
//
//  Created by CheungKnives on 16/7/8.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHIndustryTool.h"
#import "MJExtension.h"
#import "YHSoapTool.h"
#import "YHResultItem.h"

#import "YHIndustry.h"


@implementation YHIndustryTool

+ (void)getIndustry:(void (^)(YHResultItem *))block {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"BasicInfoManageInterface.asmx"];
    NSString *methodName = @"GetIndustry";
    NSDictionary *dic = nil;
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHIndustry class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"获取行业（企业所属行业）数据失败");
    }];
}

+ (void)getJobFunction:(void (^)(YHResultItem *))block {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"BasicInfoManageInterface.asmx"];
    NSString *methodName = @"GetJobFunction";
    NSDictionary *dic = nil;
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHIndustry class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"得到职位职能类别数据失败");
    }];
}

+ (void)getJobFunction:(void (^)(YHResultItem *))block withParentId:(NSString *)parentFuncId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"BasicInfoManageInterface.asmx"];
    NSString *methodName = @"GetJobFunctionByParentId";
    NSDictionary *dic = @{ @"parentFuncId" : parentFuncId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHIndustry class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"根据职能类别ID获取该类别下的职位职能数据失败");
    }];
}

@end
