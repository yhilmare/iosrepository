//
//  Common.h
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

// screen size parameter
#define YHStatusHeight 20
#define YHNavBarHeight 44
#define YHTabBarHeight 49
#define YHScreenWidth [UIScreen mainScreen].bounds.size.width
#define YHScreenHeight [UIScreen mainScreen].bounds.size.height

// ios version
#define iOS7 ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
#define iOS8 ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
#define iOS9 ([UIDevice currentDevice].systemVersion.floatValue >= 9.0)
#define inch4 ([UIScreen mainScreen].bounds.size.height == 568)
#define IOS7_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

// window
#define YHWindow [[UIApplication sharedApplication] keyWindow]

// setting
#define YHKeyWindow [UIApplication sharedApplication].keyWindow
#define YHNavgationBarTitleFont [UIFont boldSystemFontOfSize:20]
#define YHNavgationBarTitleColor [UIColor whiteColor]
#define YHUserDefaults [NSUserDefaults standardUserDefaults]

// color
#define YHColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define YHBlue [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]
#define YHGray [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1] //235
#define YHWhite [UIColor whiteColor]

// StatusCell
#define YHCellMargin 10                                     //单元边缘
#define YHNameFont [UIFont systemFontOfSize:15]             //名字字体大小
#define YHTimeFont [UIFont systemFontOfSize:12]             //时间字体大小
#define YHTextFont [UIFont systemFontOfSize:18]             //字体大小

// NavBarChangePoint
#define NAVBAR_CHANGE_POINT 40

// 弱引用
#define YHWeakSelf __weak typeof(self) weakSelf = self;

// 将数据写到桌面的plist
#define YHWriteToPlist(data, filename) [data writeToFile:[NSString stringWithFormat:@"/Users/Knives/Desktop/%@.plist", filename] atomically:YES];

//判断当前设备是否是IOS7
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//头部高
#define NVARBAR_HIGHT           50

// 底部高
#define TARBAR_HIGHT            46
#define TARBAR_HIGHT_PLUS        77

// url
#define YHServerURL @"http://58.215.179.167/"

// print
#ifdef DEBUG // 调试

#define YHLog(...) NSLog(__VA_ARGS__)

#else // 发布

#define YHLog(...)

#endif