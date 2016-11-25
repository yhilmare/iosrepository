//
//  YHCustomCardView.h
//  WanCai
//
//  Created by CheungKnives on 16/8/03.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "CCDraggableCardView.h"
@class YHJobs;

@interface YHCustomCardView : CCDraggableCardView

- (void)installData:(YHJobs *)job;

@end
