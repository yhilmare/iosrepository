//
//  YHLanguageAbility.h
//  WanCai
//
//  Created by CheungKnives on 16/6/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YHLanguageAbility : NSObject<MJKeyValue>

/**
 *  id
 */
@property (nonatomic, copy) NSString *LanguageId;
/**
 *  简历id
 */
@property (nonatomic, copy) NSString *ResumeId;
/**
 *  外语语种编号
 */
@property (nonatomic, copy) NSString *LanguageType;
/**
 *  掌握程度编号
 */
@property (nonatomic, copy) NSString *LanguageMaster;
/**
 *  读写能力编号
 */
@property (nonatomic, copy) NSString *RWAbility;
/**
 *  听说能力编号
 */
@property (nonatomic, copy) NSString *LSAbility;
/**
 *  创建时间
 */
@property (nonatomic, copy) NSString *CreateDate;
/**
 *  更新时间
 */
@property (nonatomic, copy) NSString *UpdateDate;
/**
 *  外语语种
 */
@property (nonatomic, copy) NSString *Lantype;
/**
 *  掌握程度
 */
@property (nonatomic, copy) NSString *Lanmaster;
/**
 *  读写能力
 */
@property (nonatomic, copy) NSString *Lanrwability;
/**
 *  听说能力
 */
@property (nonatomic, copy) NSString *Lanlsability;

@end
