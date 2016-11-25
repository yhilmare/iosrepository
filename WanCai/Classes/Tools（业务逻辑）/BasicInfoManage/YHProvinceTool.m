//
//  YHProvenceTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProvinceTool.h"
#import "YHResultItem.h"
#import "YHProvince.h"
#import "MJExtension.h"
#import "YHSoapTool.h"

@implementation YHProvinceTool

+ (void)getProvinceItem:(void (^)(YHResultItem *))block {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"BasicInfoManageInterface.asmx"];
    NSString *methodName = @"GetProvince";
    NSDictionary *dic = nil;
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHProvince class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"获取省份数据失败");
    }];
}

@end
