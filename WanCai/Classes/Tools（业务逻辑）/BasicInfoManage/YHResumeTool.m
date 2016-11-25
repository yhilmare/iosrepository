//
//  YHResumeTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHResumeTool.h"
#import "YHSoapTool.h"
#import "MJExtension.h"
#import "YHResultItem.h"
#import "YHResume.h"

@implementation YHResumeTool

+ (void)getResumeEnum:(void (^)(YHResultItem *))block withEnumType:(NSString *)stringID{
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"BasicInfoManageInterface.asmx"];
    NSString *methodName = @"GetResumeEnum";
    NSDictionary *dic = @{ @"enumTypeId" : stringID };
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
        YHLog(@"获取简历信息常量数据失败");
    }];
}

@end
