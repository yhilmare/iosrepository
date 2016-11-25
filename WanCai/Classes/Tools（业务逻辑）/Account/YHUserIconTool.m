//
//  YHUserIconTool.m
//  WanCai
//
//  Created by CheungKnives on 16/8/8.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHUserIconTool.h"
#import "YHSoapTool.h"
#import "YHReturnMsg.h"

@implementation YHUserIconTool

+ (void)uploadUserIcon:(NSString *)userId withPath:(NSString *)path withReturnObject:(void (^)(YHReturnMsg *))success{
    
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"BasicInfoManageInterface.asmx"];
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:@"UploadLogo" AttrDic:@{@"userId":userId, @"path":path}];
    
    [YHSoapTool getDataWithURl:url methodName:@"UploadLogo" soapBody:soapBody success:^(id responseObject) {
        
        YHReturnMsg *returnMsg = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(success){
            success(returnMsg);
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

@end
