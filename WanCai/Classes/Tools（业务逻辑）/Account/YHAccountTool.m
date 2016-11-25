//
//  YHAccountTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/7.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHAccountTool.h"
#import "YHAccount.h"
#import "YHSoapTool.h"
#import "YHAccountReturnMsg.h"
#import "MJExtension.h"

#define YHAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"account.data"]
#define secondaryURL @"LoginAndRegiste.asmx"
#define LOGIN @"MyLogin"
#define REGISTER @"UserRegister"

@interface YHAccountTool()

@property (nonatomic, strong) NSMutableDictionary *returnMsg;

@end

@implementation YHAccountTool

+ (void)saveAccount:(YHAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:YHAccountFile];
}

+ (YHAccount *)account {
    YHAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:YHAccountFile];
    
    //如果没有，则返回nil
    if (!account) {
        return nil;
    }
    
    return account;
}

+ (void)login:(void (^)(YHAccountReturnMsg *))block WithUName:(NSString *)uName andPwd:(NSString *)pwd {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:secondaryURL];
    NSDictionary *dic = @{
        @"uName" : uName,
        @"pwd" : pwd
    };
    NSString *soapBodyStr = [YHSoapTool getSoapBodyStrWithMethodName:LOGIN AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:LOGIN soapBody:soapBodyStr success:^(id responseObject) {
        // 1.json转模型
        YHAccount *account = [YHAccount mj_objectWithKeyValues:responseObject];
        YHAccountReturnMsg *returnMsg = [YHAccountReturnMsg mj_objectWithKeyValues:responseObject];
        
        // 2.进行归档
        [YHAccountTool saveAccount:account];
       
        // 3.跳转页面
        if(block){
            block(returnMsg);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"登录界面获取信息失败!!");
        YHLog(@"错误信息如下所示%@",error);
    }];
}


+ (void)registerAccount:(void (^)(YHAccountReturnMsg *))block WithUName:(NSString *)uName Pwd:(NSString *)pwd Email:(NSString *)email {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:secondaryURL];
    
    NSDictionary *dic = @{
        @"uName" : uName,
        @"pwd" : pwd,
        @"email" : email
    };
    NSString *soapBodyStr = [YHSoapTool getSoapBodyStrWithMethodName:REGISTER AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url  methodName:REGISTER  soapBody:soapBodyStr success:^(id responseObject) {
        // 注册成功，即返回的msg为true，则跳转页面
        YHAccountReturnMsg *retrunMsg = [YHAccountReturnMsg mj_objectWithKeyValues:responseObject];
        
        if (block) {
            block(retrunMsg);
        }
    } failure:^(NSError *error) {
        YHLog(@"注册页面获取信息失败!!");
        YHLog(@"错误信息如下所示%@",error);
    }];
}

@end
