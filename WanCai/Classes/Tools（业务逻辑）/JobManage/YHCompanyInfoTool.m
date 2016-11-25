//
//  YHCompanyInfoTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHCompanyInfoTool.h"
#import "YHResumeTool.h"
#import "YHSoapTool.h"
#import "MJExtension.h"
#import "YHResultItem.h"

#import "YHCompanyInfo.h"

@implementation YHCompanyInfoTool

+ (void)getCompanyInfo:(void (^)(YHResultItem *))block withCompanyId:(NSString *)companyId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"JobManageInterface.asmx"];
    NSString *methodName = @"GetComInfoById";
    NSDictionary *dic = @{ @"companyId" : companyId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHCompanyInfo class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"获取公司信息失败");
    }];
}
@end
