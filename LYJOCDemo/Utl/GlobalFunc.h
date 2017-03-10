//
//  GlobalFunc.h
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/10.
//  Copyright © 2017年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface GlobalFunc : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

+ (GlobalFunc *)sharedInstance;




+ (UIImage*) createImageWithColor: (UIColor*) color;
+ (UIColor*) colorFromImage: (UIImage*) image;
+ (NSString *) changeUIColorToRGB:(UIColor *)color;
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString*)format;

//路径
+ (NSString *)pathWithFile:(NSString *)file;
+ (BOOL)existsFile:(NSString *)file; //是否存在文件
+ (BOOL)deleteFile:(NSString *)file; //删除文件
+ (BOOL)writeArrToFile:(NSArray *)arr fileName:(NSString *)file; //把数组写入文件
+ (BOOL)writeDicToFile:(NSDictionary *)dic fileName:(NSString *)file; //把字典写入文件
+ (NSArray *)parseArrFromFile:(NSString *)file; //解析文件得到数组
+ (NSDictionary *)parseDicFromFile:(NSString *)file; //解析文件得到字典
+ (BOOL)writerData:(NSData *)data toFile:(NSString *)file;//存储数据
+ (NSData *)readDataWithFile:(NSString *)file; //读取数据

#pragma mark 获取UUID
+ (NSString*) getUUID;

#pragma mark - 获取指定长度的纯数字随机码
+ (NSString *)getNumbersWithIndex:(NSInteger)index;

#pragma mark - 转化NSDate为字符串
+ (NSString *)encodeDate:(NSDate *)date;

#pragma mark - 转化NSDate为字符串 （自定义格式）
+ (NSString *)encodeDate:(NSDate *)date withFormatterString:(NSString *)fromatter;
+ (NSString *)encodeDate1970:(double)time withFormatterString:(NSString *)formatter;
+ (NSDate *)dateWithStr:(NSString *)dateStr formatterString:(NSString *)fromatter;
+ (NSString *)weekWithDate:(NSDate *)date;
+ (NSString *)weekWithDate1970:(CGFloat)time;

#pragma mark - 检查是否为字符串
+ (BOOL)checkObject:(NSString *)str;

//自定义默认字体
+ (UIFont *)defaultFontWithSize:(CGFloat)size;
+ (UIFont *)defaultBoldFontWithSize:(CGFloat)size;

//16进制字符串 转换为int
+ (UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;

#pragma mark 显示信息
+ (void)showAlertWithMessage:(NSString *)msg;

#pragma mark - 检测网络
+ (NSInteger)checkNetWork;

#pragma mark - 验证价格 double
+ (NSString *)checkPrice:(double)price;
+ (NSString *)standerPrice:(double)price;
+ (NSString *)standerStrPrice:(NSString *)price;
+ (NSString *)unstanderStrPrice:(NSString *)price;
+ (NSString *)standerValue:(NSString *)value;

#pragma mark - 检测URL
+ (NSURL *)urlWithStr:(NSString *)str;

#pragma mark - 检测是否开启推送
+ (BOOL)enabledRemoteNotification;

#pragma mark - 比较版本号大小
+ (BOOL)moreThanVersion:(NSString *)version;

#pragma mark - 展示一般的警告
+ (void)showAlertHUD:(NSString *)message;
+ (void)showAlertHUD:(NSString *)message timeOut:(NSInteger)timeOut;
+ (NSString *)deviceVersion;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font size:(CGSize)size;

#pragma mark - 倒计时
+ (NSString *)detailTimer:(NSString *)minut byIndex:(NSInteger)index;
+ (NSString *)detailSignTimer:(NSString *)minut byIndex:(NSInteger)index;
+ (NSString *)compareDate:(NSString *)dateStr day:(BOOL)day;

+ (UIImage *)pngWithName:(NSString *)name;

//#pragma mark - 友盟统计
+ (void)beginLogPageView:(NSString *)pageName;
+ (void)endLogPageView:(NSString *)pageName;
+ (void)event:(NSString *)eventId;
+ (void)event:(NSString *)eventId label:(NSString *)label;
-(void)saveConfiguration;
+ (void)profileSignInWithPUID:(NSString *)puid;//账号统计
+ (void)profileSignInWithPUID:(NSString *)puid provider:(NSString *)provider;//账号统计，可以统计第三方登录
+(void)profileSignOff;//账号退出时调用，关闭账号统计

/*400*/
+ (void)tel400;

+ (UIImage *) scaleToSizeAlpha:(UIImage *)img alpha:(float)alpha;
+ (UIImage *) scaleToSizeAlpha:(UIImage *)img fixedWith:(float)fixedWith;
+ (UIImage *) scaleToSizeAlpha:(UIImage *)img fixedHeight:(float)fixedHeight;

+(NSString*) getCurrentTime;
+(NSString*)getCurrentTimeWithFormatter:(NSString*)formattter;



#pragma mark - 过滤表情
+(NSString *)disableEmoji:(NSString *)text;
+(BOOL)stringContainsEmoji:(NSString *)string;

//根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL;

/*
 * data 转string
 */
+ (NSString*)dataTojsonString:(id)object;

#pragma  - cache file folder ------

+(NSString*)getImageFileFolder;

//随机色
+(UIColor *)randomColor;

@end
