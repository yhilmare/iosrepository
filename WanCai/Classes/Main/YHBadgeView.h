//
//  YHBadgeView.h
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHBadgeView : UIButton

/**
 *  小球显示数目
 */
@property (nonatomic, copy) NSString *badgeValue;
/**
 *  最大拖动范围,默认为100
 */
@property (nonatomic,assign) NSInteger maxDistance;

@end
