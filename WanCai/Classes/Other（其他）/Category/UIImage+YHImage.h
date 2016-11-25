//
//  UIImage+YHImage.h
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YHImage)

/**
 *  加载最原始的图片，没有渲染
 *
 *  @param imageName imageName
 *
 *  @return <#return value description#>
 */
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

/**
 *  拉伸显示图片
 *
 *  @param imageName <#imageName description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)imageWithStretchableName:(NSString *)imageName;

/**
 *  根据颜色返回图片
 *
 *  @param color color
 *
 *  @return image
 */
+(UIImage*) imageWithColor:(UIColor*)color;



@end
