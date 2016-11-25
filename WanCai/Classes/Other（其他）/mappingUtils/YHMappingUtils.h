//
//  YHMappingUtils.h
//  WanCai
//
//  Created by yh_swjtu on 16/8/15.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YHResumeMappingEnumType){
    YHResumeMappingEnumGender = 1,
    YHResumeMappingEnumMarriage,
    YHResumeMappingEnumDegree,
    YHResumeMappingEnumWorkYear,
    YHResumeMappingEnumJobType,//全职，兼职或实习用这个枚举
    YHResumeMappingEnumSalary,
    YHResumeMappingEnumPolitic = 8,//政治身份
    YHResumeMappingEnumLanguageType,//语言种类
    YHResumeMappingEnumLanguageMaster,//语言掌握能力
    YHResumeMappingEnumRecent//不知道是什么，枚举值为11
};

@interface YHMappingUtils : NSObject


/**
 *  语言能力映射函数，第一个参数typeId传入要映射的id值，第二个参数传入需要映射的枚举值 *
 *  @param typeId     需要映射的id值
 *  @param types      需要映射的种类，枚举值
 */
+ (NSString *) mappingWithId:(NSString *)typeId andType:(YHResumeMappingEnumType) types;

/**
 * 反映射函数，即传入语言名称或语言能力掌握程度，得到相对应的id值
 *  @param typeName   需要反映射的名字
 *  @param types      需要映射的种类，枚举值
 */
+ (NSString *) AntiMappingWithName:(NSString *)typeName andType:(YHResumeMappingEnumType) types;


/**
 *  城市代码映射函数，传入城市名称 *
 *  @param cityName     城市名
 */
+ (NSString *)mappingCityCodeWithCityName:(NSString *)cityName;//获得城市的代码


/**
 *  城市代码反映射函数，传入城市代码 *
 *  @param citycode     城市代码
 */
+ (NSString *) antiMappingCityCode:(NSString *)cityCode;//根据地域代码反向得到城市字符串


@end
