//
//  YHRegisteTool.m
//  WanCai
//
//  Created by abing on 16/7/2.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHRegisteTool.h"
#import "YHSoapTool.h"
#import "YHRegisteFormMessage.h"

@implementation YHRegisteTool

+ (void) getRegisteResult:(YHRegisteFormMessage *)formMessage{
    
    NSDictionary *attrDic = @{@"uName":formMessage.userName, @"pwd":formMessage.password, @"email":formMessage.email};
    
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:@"UserRegister" AttrDic:attrDic];
    
    NSString *fullURL = [YHSoapTool getCompleteURlWithSecondaryURL:@"LoginAndRegiste.asmx"];
    
    [YHSoapTool getDataWithURl:fullURL methodName:@"UserRegister" soapBody:soapBody success:^(id responseObject){
        NSDictionary *dic = responseObject;
        NSString *userId = dic[@"userId"];
        if(userId){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"registeMessage" object:nil userInfo:@{@"Condition":@"success", @"userId":userId}];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"registeMessage" object:nil userInfo:@{@"Condition":@"fail", @"userId":@"0"}];
        }
        
    }failure:^(NSError *error){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"registeMessage" object:nil userInfo:@{@"Condition":@"error", @"userId":@"-1"}];
        NSLog(@"error");
        
    }];
}

@end
