//
//  YHJobApplyTool.m
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHJobApplyTool.h"
#import "YHResumeTool.h"
#import "YHSoapTool.h"
#import "MJExtension.h"
#import "YHResultItem.h"

#import "YHMyJobApply.h"

@implementation YHJobApplyTool

+ (void)getMyJobApplyList:(void (^)(YHResultItem *))block
               withuserId:(NSString *)userId
                 pagesize:(NSString *)pagesize
                pageindex:(NSString *)pageindex{
    NSString *url = [YHSoapTool getCompleteURlWithSecondaryURL:@"JobManageInterface.asmx"];
    NSString *methodName = @"GetMyJobApplyList";
    NSDictionary *dic = @{
                          @"userId" : userId,
                          @"pagesize" : pagesize,
                          @"pageindex" : pageindex
                          };
    NSString *soapBody = [YHSoapTool getSoapBodyStrWithMethodName:methodName AttrDic:dic];
    
    [YHSoapTool getDataWithURl:url methodName:methodName soapBody:soapBody success:^(id responseObject) {
        [YHResultItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"rows" : [YHMyJobApply class] };
        }];
        
        YHResultItem *resultItem = [YHResultItem mj_objectWithKeyValues:responseObject];
        
        if(block){
            block(resultItem);
        }
        
    } failure:^(NSError *error) {
        YHLog(@"获取职位申请列表信息失败");
    }];

}
@end
