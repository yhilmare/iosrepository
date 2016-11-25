//
//  YHLogintool.m
//  WanCai
//
//  Created by abing on 16/7/2.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHLogintool.h"
#import "YHSoapTool.h"
#import "YHloginFormMessage.h"

@implementation YHLogintool

+ (void) getLoginResult:(YHloginFormMessage *)formMessage{
    
    NSString *methodName = @"MyLogin";
    
    NSDictionary *attrDic = @{@"uName":formMessage.userName, @"pwd":formMessage.password};
    
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:attrDic];
    
    NSString *fullURL = [YHSoapTool getCompleteURlWithSecondaryURL:@"LoginAndRegiste.asmx"];
    
    [YHSoapTool getDataWithURl:fullURL methodName:methodName soapBody:soapBody success:^(id responseObject){
        NSDictionary *dic = responseObject;
        NSNumber *userId = dic[@"userId"];
        if([userId isEqualToNumber:[NSNumber numberWithInt:0]] == NO){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:userId forKey:@"userId"];
            [defaults synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginMessage" object:nil userInfo:@{@"Condition":@"success",@"userId":userId}];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginMessage" object:nil userInfo:@{@"Condition":@"fail",@"userId":userId}];
        }
    }failure:^(NSError *error){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginMessage" object:nil userInfo:@{@"Condition":@"error",@"userId":[NSNumber numberWithInt:-1]}];
        NSLog(@"error");
    }];
}

@end
