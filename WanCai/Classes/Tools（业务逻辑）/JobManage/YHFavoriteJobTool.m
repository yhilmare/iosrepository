//
//  YHFavoriteJobTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHFavoriteJobTool.h"
#import "YHResumeTool.h"
#import "YHSoapTool.h"
#import "MJExtension.h"
#import "YHResultItem.h"

#import "YHMyFavoriteJob.h"

@implementation YHFavoriteJobTool

+ (void)getMyJobFavoriteList:(void (^)(YHResultItem *))block
                  withuserId:(NSString *)userId
                    pagesize:(NSNumber *)pagesize
                   pageindex:(NSNumber *)pageindex
                    keywords:(NSString *)keywords {
    
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"JobManageInterface.asmx"];
    NSString *methodName = @"GetMyJobFavoriteList";
    NSDictionary *dic = @{
                          @"userId" : userId,
                          @"pagesize" : pagesize,
                          @"pageindex" : pageindex,
                          @"keywords" : keywords
                          };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHMyFavoriteJob class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"获取用户职位收藏夹信息失败");
    }];
}

@end
