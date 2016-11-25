//
//  YHCompanyMsg.h
//  WanCai
//
//  Created by abing on 16/7/17.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHCompanyMsg : NSObject

@property (nonatomic, copy) NSString *companyRequired;

@property (nonatomic, copy) NSString *CompanyIndustryName;

@property (nonatomic, copy) NSString *companyDescribtion;

@property (nonatomic, copy) NSString *companyContactPerson;

@property (nonatomic, copy) NSString *companyAddress;

@property (nonatomic, copy) NSString *companyContact;

@property (nonatomic, assign) CGRect requiredRect;

@property (nonatomic, assign)CGRect describtionRect;

@property (nonatomic, assign) CGRect contactPersonRect;

@property (nonatomic, assign) CGRect addressRect;

@property (nonatomic, assign) CGRect contactRect;

@property (nonatomic, assign) CGFloat rowHeight;

@end
