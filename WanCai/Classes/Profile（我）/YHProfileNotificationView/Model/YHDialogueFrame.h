//
//  YHDialogueFrame.h
//  WanCai
//
//  Created by yh_swjtu on 16/8/5.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHDialogue;

@interface YHDialogueFrame : NSObject

@property (nonatomic, copy) YHDialogue *dia;

@property (nonatomic, assign) CGFloat rowHeight;

@end
