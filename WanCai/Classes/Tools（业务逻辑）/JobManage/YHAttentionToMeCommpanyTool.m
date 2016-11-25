//
//  YHAttentionToMeCommpanyTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHAttentionToMeCommpanyTool.h"
#import "YHResumeTool.h"
#import "YHSoapTool.h"
#import "MJExtension.h"
#import "YHResultItem.h"

#import "YHAttentionToMeCompany.h"

@implementation YHAttentionToMeCommpanyTool

+ (void)getAttentionToMeCommpanyList:(void (^)(YHResultItem *))block
                          withuserId:(NSString *)userId
                            pagesize:(NSNumber *)pagesize
                           pageindex:(NSNumber *)pageindex{
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"JobManageInterface.asmx"];
    NSString *methodName = @"GetAttentionToMeCommpanyList";
    NSDictionary *dic = @{
                          @"userId" : userId,
                          @"pagesize" : pagesize,
                          @"pageindex" : pageindex
                          };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHAttentionToMeCompany class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"获取看过我的公司列表信息失败");
    }];
    
}

@end
