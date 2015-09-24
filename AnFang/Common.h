//
//  Common.h
//  AnBao
//
//  Created by mac   on 15/8/25.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#ifndef AnBao_Common_h
#define AnBao_Common_h

#define isIos7      ([[[UIDevice currentDevice] systemVersion] floatValue])
#define StatusbarSize ((isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)

#define WIDTH                    ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT                   ([UIScreen mainScreen].bounds.size.height)
//#define WIDTH self.view.frame.size.width
//#define HEIGHT self.view.frame.size.height
#define RELOADIMAGE @"reloadImage"

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

#define __async_opt__  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define __async_main__ dispatch_async(dispatch_get_main_queue()

#endif
