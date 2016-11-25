//
//  YHUserBasicInfoTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHUserBasicInfoTool.h"
#import "YHResumeTool.h"
#import "YHSoapTool.h"
#import "MJExtension.h"
#import "YHResultItem.h"
#import "YHReturnMsg.h"
#import "MBProgressHUD.h"
#import "YHUserBasicInfo.h"

@implementation YHUserBasicInfoTool

+ (void)getUserBasicInfo:(void (^)(YHResultItem *))block withuserId:(NSString *)userId {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"BasicInfoManageInterface.asmx"];
    NSString *methodName = @"GetUserBasicInfoByUserId";
    NSDictionary *dic = @{ @"userId" : userId };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHUserBasicInfo class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"获取用户基本信息失败");
    }];
}

+ (void)updatePassword:(void (^)(YHReturnMsg *))block withUserName:(NSString *)userName oldPwd:(NSString *)oldpwd newPwd:(NSString *)newpwd {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"BasicInfoManageInterface.asmx"];
    NSString *methodName = @"UpdatePassword";
    NSDictionary *dic = @{
                          @"userName" : userName,
                          @"oldpwd" : oldpwd,
                          @"newpwd" : newpwd
                          };
    
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *returnMsg = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(returnMsg);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"修改密码失败");
    }];
}

+ (void)updateUserBasicInfo:(void (^)(YHReturnMsg *))block
                 withuserId:(NSString *)userId
                   userName:(NSString *)userName
                     gender:(NSString *)gender
                   marriage:(NSString *)marriage
                   birthday:(NSString *)birthday
                     degree:(NSString *)degree
                   workyear:(NSString *)workyear
                     mobile:(NSString *)mobile
                      email:(NSString *)email
                   location:(NSString *)location {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"BasicInfoManageInterface.asmx"];
    NSString *methodName = @"UpdateUserBasicInfo";
    NSDictionary *dic = @{
                          @"userId" : userId,
                          @"userName" : userName,
                          @"gender" : gender,
                          @"marriage" : marriage,
                          @"birthday" : birthday,
                          @"degree" : degree,
                          @"workyear" : workyear,
                          @"mobile" : mobile,
                          @"email" : email,
                          @"location" : location
                          };
    
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *returnMsg = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        if(block){
            block(returnMsg);
        }
    } failure:^(NSError *error) {
        YHLog(@"修改用户基本信息失败");
        YHReturnMsg *returnMsg = [[YHReturnMsg alloc] init];
        returnMsg.msg = @"ServerError";
        if(block){
            block(returnMsg);
        }
    }];
}

+ (void)uploadLogo:(void (^)(YHReturnMsg *))block withuserId:(NSString *)userId path:(NSString *)path {
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"BasicInfoManageInterface.asmx"];
    NSString *methodName = @"UpdateUserBasicInfo";
    NSDictionary *dic = @{
                          @"userId" : userId,
                          @"path" : path
                          };
    
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        YHReturnMsg *returnMsg = [YHReturnMsg mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(returnMsg);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"修改用户基本信息失败");
    }];
}

@end
