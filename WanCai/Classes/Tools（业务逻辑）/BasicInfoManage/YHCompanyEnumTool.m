//
//  YHCompanyEnumTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHCompanyEnumTool.h"
#import "YHResumeTool.h"
#import "YHSoapTool.h"
#import "MJExtension.h"
#import "YHResultItem.h"

#import "YHCompanyEnum.h"

@implementation YHCompanyEnumTool

+ (void)getCompanyEnum:(void (^)(YHResultItem *))block withEnumTypeId:(NSString *)enumTypeId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"BasicInfoManageInterface.asmx"];
    NSString *methodName = @"GetCompanyEnum";
    NSDictionary *dic = @{ @"enumTypeId" : enumTypeId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHCompanyEnum class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"获取用户基本信息失败");
    }];
}

@end
