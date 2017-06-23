//
//  UtilsMacro.h
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/2.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#define PROGRAMNAME @"ATL"


#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif




#if __IPHONE_6_0 // iOS6 and later

#   define kTextAlignmentCenter    NSTextAlignmentCenter
#   define kTextAlignmentLeft      NSTextAlignmentLeft
#   define kTextAlignmentRight     NSTextAlignmentRight

#   define kTextLineBreakByWordWrapping      NSLineBreakByWordWrapping
#   define kTextLineBreakByCharWrapping      NSLineBreakByCharWrapping
#   define kTextLineBreakByClipping          NSLineBreakByClipping
#   define kTextLineBreakByTruncatingHead    NSLineBreakByTruncatingHead
#   define kTextLineBreakByTruncatingTail    NSLineBreakByTruncatingTail
#   define kTextLineBreakByTruncatingMiddle  NSLineBreakByTruncatingMiddle

#else // older versions

#   define kTextAlignmentCenter    UITextAlignmentCenter
#   define kTextAlignmentLeft      UITextAlignmentLeft
#   define kTextAlignmentRight     UITextAlignmentRight

#   define kTextLineBreakByWordWrapping       UILineBreakModeWordWrap
#   define kTextLineBreakByCharWrapping       UILineBreakModeCharacterWrap
#   define kTextLineBreakByClipping           UILineBreakModeClip
#   define kTextLineBreakByTruncatingHead     UILineBreakModeHeadTruncation
#   define kTextLineBreakByTruncatingTail     UILineBreakModeTailTruncation
#   define kTextLineBreakByTruncatingMiddle   UILineBreakModeMiddleTruncation

#endif

//! 1、XCode中设置控制
// Target > Get Info > Build > GCC_PREPROCESSOR_DEFINITIONS
// Configuration = Release: <empty>
//               = Debug:   DEBUG_MODE=1
//！2、人为控制
//#define DEBUG
#ifdef DEBUG
#define DELOG(...) //NSLog(__VA_ARGS__)
#define DELOGPINK(...) LogPink(__VA_ARGS__)
#define DELOGBLUE(...) LogBlue(__VA_ARGS__)
#define DELOGRED(...) LogRed(__VA_ARGS__)
#else
#define DELOG(...) do { } while (0);
#define DELOGPINK(...) do { } while (0);
#define DELOGBLUE(...) do { } while (0);
#define DELOGRED(...) do { } while (0);
#endif

/*
 #define DELOG( s, ... ) //NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
 #else
 #define DELOG( s, ... )
 #endif
 */

#pragma mark -Redefine


#define IsIPad                  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IsIos7Up                ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define iphone4x_3_5            ([UIScreen mainScreen].bounds.size.height==480.0f)
#define iphone5x_4_0            ([UIScreen mainScreen].bounds.size.height==568.0f)
#define iphone6x_4_7            ([UIScreen mainScreen].bounds.size.height==667.0f)
#define iphone6px_5_5           ([UIScreen mainScreen].bounds.size.height==736.0f)

#define AppVersion              [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]


#define ApplicationDelegate                 ([[UIApplication sharedApplication] delegate])
#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define SharedApplication                   [UIApplication sharedApplication]
#define Bundle                              [NSBundle mainBundle]

#define ShowNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x

#define MainScreen                          [UIScreen mainScreen]
#define ScreenRect                          [[UIScreen mainScreen] bounds]
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height

#define StatusBarHeight                     [UIApplication sharedApplication].statusBarFrame.size.height
#define SelfNavBar                          self.navigationController.navigationBar
#define SelfTabBar                          self.tabBarController.tabBar
#define SelfNavBarHeight                    self.navigationController.navigationBar.bounds.size.height
#define SelfTabBarHeight                    self.tabBarController.tabBar.bounds.size.height

#define Size(w, h)                          CGSizeMake(w, h)
#define Point(x, y)                         CGPointMake(x, y)

#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y

#define RectX(f)                            f.origin.x
#define RectY(f)                            f.origin.y
#define RectWidth(f)                        f.size.width
#define RectHeight(f)                       f.size.height

#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x)                      CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y)                      CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))

#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y)              CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)

#define DATE_COMPONENTS                     NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
#define TIME_COMPONENTS                     NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit

#define IOSVersion                          [[[UIDevice currentDevice] systemVersion] floatValue]
#define IsIOS7Later                         (!(IOSVersion < 7.0))

#define TabBarHeight                        49.0f
#define NaviBarHeight                       44.0f
#define HeightFor4InchScreen                568.0f
#define HeightFor3p5InchScreen              480.0f

#define ViewCtrlTopBarHeight                (IsiOS7Later ? (NaviBarHeight + StatusBarHeight) : NaviBarHeight)
#define IsUseIOS7SystemSwipeGoBack          (IsiOS7Later ? YES : NO)

#define YOURSYSTEM_OR_LATER(yoursystem) [[[UIDevice currentDevice] systemVersion] compare: (yoursystem)] != NSOrderedAscending

#define DEF_WEAKSELF __weak __typeof(self) weakSelf = self;
#define WEAK_SELF(weakSelf)  __weak __typeof(&*self) weakSelf = self;

#define RGB(r, g, b)             [UIColor colorWithRed: (r)/255.0 green: (g)/255.0 blue: (b)/255.0 alpha : 1]

#define RGBA(r, g, b, a)          [UIColor colorWithRed: (r)/255.0 green: (g)/255.0 blue: (b)/255.0 alpha: (a)]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed: ((float)((rgbValue & 0xFF0000) >> 16))/255.0 green: ((float)((rgbValue & 0xFF00) >> 8))/255.0 blue: ((float)(rgbValue & 0xFF))/255.0 alpha: 1.0]


#define IS_IPHONE4 (([[UIScreen mainScreen] bounds].size.height == 480) ? YES : NO)


#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height == 568) ? YES : NO)






#define IS_IPhone6 (667 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)






#define IS_IPhone6plus (736 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)




#define Cgcolor(x)  [UIColor x].CGColor

