//
//  YHDialogueFrame.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/5.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHDialogueFrame.h"
#import "YHDialogue.h"

@implementation YHDialogueFrame

- (void) setDia:(YHDialogue *)dia{
    
    _dia = dia;
    CGSize size = [_dia.detailMsg boundingRectWithSize:CGSizeMake(220, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    
    if(dia.isShowTime){
        _rowHeight = (((size.height + 36) > 50)?(size.height + 71):85);
    }else{
        _rowHeight = (((size.height + 36) > 50)?(size.height + 46):60);
    }
}

@end
