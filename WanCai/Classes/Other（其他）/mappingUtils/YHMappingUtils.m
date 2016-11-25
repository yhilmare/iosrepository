//
//  YHMappingUtils.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/15.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHMappingUtils.h"

#define MappingFileName @"mappingUtilsFile.plist"
#define cityMappingFileName @"cityMappingFile.plist"

@implementation YHMappingUtils

+ (NSString *) mappingWithId:(NSString *)typeId andType:(YHResumeMappingEnumType) types{
   
    NSString *type = [NSString stringWithFormat:@"%d", (int) types];
    NSString *path = [[NSBundle mainBundle] pathForResource:MappingFileName ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSDictionary *map;
    for(NSDictionary *dic in array){
        NSString *temp = dic[@"typeName"];
        if([temp isEqualToString:type]){
            map = [NSDictionary dictionaryWithDictionary:dic[@"rows"]];
        }
    }
    return map[typeId] == nil?@"no data":map[typeId];
}

+ (NSString *) AntiMappingWithName:(NSString *)typeName andType:(YHResumeMappingEnumType) types{
    
    NSString *type = [NSString stringWithFormat:@"%d", (int) types];
    NSString *path = [[NSBundle mainBundle] pathForResource:MappingFileName ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSDictionary *map;
    for(NSDictionary *dic in array){
        NSString *temp = dic[@"typeName"];
        if([temp isEqualToString:type]){
            map = [NSMutableDictionary dictionary];
            NSDictionary *tempDic = dic[@"rows"];
            for(NSString *key in tempDic){
                NSString *value = tempDic[key];
                [map setValue:key forKey:value];
            }
        }
    }
    return map[typeName] == nil?@"no data":map[typeName];
}

+ (NSString *)mappingCityCodeWithCityName:(NSString *)cityName{//获得城市的代码
    
    NSString *path = [[NSBundle mainBundle] pathForResource:cityMappingFileName ofType:nil];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *code = dic[cityName];
    return code == nil?@"no data":code;
}

+ (NSString *) antiMappingCityCode:(NSString *)cityCode{//根据地域代码反向得到城市字符串
    
    NSString *paths = [[NSBundle mainBundle] pathForResource:cityMappingFileName ofType:nil];
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithContentsOfFile:paths];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for(NSString *key in temp){
        [result setValue:key forKey:temp[key]];
    }
    
    return result[cityCode]==nil?@"no data":result[cityCode];
}

@end
