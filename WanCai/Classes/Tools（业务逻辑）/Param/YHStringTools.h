//
//  YHStringTools.h
//  WanCai
//
//  Created by CheungKnives on 16/7/28.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHStringTools : NSObject

/**
 *  删除/替换html中的转译字符br/&amp;等
 *
 *  @param string 待删除的串
 *
 *  @return 删除html转译字符后的串
 */
+ (NSString *)htmlEntityDecode:(NSString *)string;
/**
 *  将HTML字符串转化为NSAttributedString富文本字符串
 *
 *  @param htmlString htmlStr
 *
 *  @return 富文本str
 */
+ (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString;
/**
 *  去掉 HTML 字符串中的标签
 *
 *  @param html htmln内容
 *
 *  @return 去除标签的html string
 */
+ (NSString *)filterHTML:(NSString *)html;
@end
