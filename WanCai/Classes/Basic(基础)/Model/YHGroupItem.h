//
//  YHGroupItem.h
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHSettingItem.h"

@interface YHGroupItem : YHSettingItem

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, ) NSString *footerTitle;

@end
