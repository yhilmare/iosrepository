//
//  YHMyFavoriteJob.h
//  WanCai
//
//  Created by CheungKnives on 16/6/10.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHMyFavoriteJob : NSObject<NSObject>

/**
 *  职位收藏夹id
 */
@property (nonatomic, copy) NSString *FavoriteId;
/**
 *  用户id
 */
@property (nonatomic, copy) NSString *userId;
/**
 *  企业id
 */
@property (nonatomic, copy) NSString *CompanyId;
/**
 *  职位名称
 */
@property (nonatomic, copy) NSString *CompanyName;
/**
 *  职位id
 */
@property (nonatomic, copy) NSString *JobId;
/**
 *  职位名称
 */
@property (nonatomic, copy) NSString *JobName;
/**
 *  现居住城市编码
 */
@property (nonatomic, copy) NSString *WorkLocation;
/**
 *  现居住城市名称
 */
@property (nonatomic, copy) NSString *CityName;
/**
 *  职位发布日期
 */
@property (nonatomic, copy) NSString *PublishDate;
/**
 *  记录创建日期
 */
@property (nonatomic, copy) NSString *CreateDate;

@end
