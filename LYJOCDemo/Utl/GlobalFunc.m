//
//  GlobalFunc.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/10.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "GlobalFunc.h"
#import "sys/utsname.h"
#import "Reachability.h"

static GlobalFunc *sharedInstance;


@implementation GlobalFunc

+ (GlobalFunc *)sharedInstance{
    //static JRGlobalSingleton *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


+ (UIImage*) createImageWithColor: (UIColor*) color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
+ (UIColor*) colorFromImage: (UIImage*) image{
    return [UIColor colorWithPatternImage:image];
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString*)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    
    [dateFormatter setDateFormat:format];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

//颜色转字符串
+ (NSString *) changeUIColorToRGB:(UIColor *)color{
    
    
    const CGFloat *cs=CGColorGetComponents(color.CGColor);
    
    
    NSString *r = [NSString stringWithFormat:@"%@",[self  ToHex:cs[0]*255]];
    NSString *g = [NSString stringWithFormat:@"%@",[self  ToHex:cs[1]*255]];
    NSString *b = [NSString stringWithFormat:@"%@",[self  ToHex:cs[2]*255]];
    return [NSString stringWithFormat:@"#%@%@%@",r,g,b];
    
    
}

//十进制转十六进制
+ (NSString *)ToHex:(int)tmpid
{
    NSString *endtmp=@"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig=tmpid%16;
    int tmp=tmpid/16;
    switch (ttmpig)
    {
        case 10:
            nLetterValue =@"A";break;
        case 11:
            nLetterValue =@"B";break;
        case 12:
            nLetterValue =@"C";break;
        case 13:
            nLetterValue =@"D";break;
        case 14:
            nLetterValue =@"E";break;
        case 15:
            nLetterValue =@"F";break;
        default:nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
            
    }
    switch (tmp)
    {
        case 10:
            nStrat =@"A";break;
        case 11:
            nStrat =@"B";break;
        case 12:
            nStrat =@"C";break;
        case 13:
            nStrat =@"D";break;
        case 14:
            nStrat =@"E";break;
        case 15:
            nStrat =@"F";break;
        default:nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
            
    }
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    return endtmp;
}





#pragma mark -
#pragma mark 文件的读写
//路径
+ (NSString *)pathWithFile:(NSString *)file
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    NSString *filename = [path stringByAppendingPathComponent:file];
    path = nil;
    
    return filename;
}

//是否存在文件
+ (BOOL)existsFile:(NSString *)file
{
    NSString *filename = [self pathWithFile:file];
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filename];
    filename = nil;
    
    return isExist;
}

//删除文件
+ (BOOL)deleteFile:(NSString *)file
{
    NSString *filename = [self pathWithFile:file];
    BOOL remove = [[NSFileManager defaultManager] removeItemAtPath:filename error:nil];
    filename = nil;
    
    return remove;
}

//把数组写入文件
+ (BOOL)writeArrToFile:(NSArray *)arr fileName:(NSString *)file
{
    BOOL finish = NO;
    @autoreleasepool {
        NSString *filename = [self pathWithFile:file];
        finish = [arr writeToFile:filename  atomically:YES];
        filename = nil;
    }
    
    return finish;
}

//把字典写入文件
+ (BOOL)writeDicToFile:(NSDictionary *)dic fileName:(NSString *)file
{
    BOOL finish = NO;
    @autoreleasepool {
        NSString *filename = [self pathWithFile:file];
        finish = [dic writeToFile:filename  atomically:YES];
        filename = nil;
    }
    
    return finish;
}

//解析文件得到数组
+ (NSArray *)parseArrFromFile:(NSString *)file
{
    NSString *filename = [self pathWithFile:file];
    NSMutableArray *array=[[NSMutableArray alloc] initWithContentsOfFile:filename];
    filename = nil;
    
    return array;
}

//解析文件得到字典
+ (NSDictionary *)parseDicFromFile:(NSString *)file
{
    //	读操作
    NSString *filename = [self pathWithFile:file];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    filename = nil;
    
    return dic;
}

//存储数据
+ (BOOL)writerData:(NSData *)data toFile:(NSString *)file
{
    NSString *filename = [self pathWithFile:file];
    
    //    if ([[NSFileManager defaultManager] fileExistsAtPath:filename]) {
    //        [[NSFileManager defaultManager] removeItemAtPath:filename error:NULL];
    //    }
    
    BOOL isFinished = [[NSFileManager defaultManager] createFileAtPath:filename contents:data attributes:nil];
    filename = nil;
    
    return isFinished;
}

//读取数据
+ (NSData *)readDataWithFile:(NSString *)file
{
    NSString *filename = [self pathWithFile:file];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    filename = nil;
    
    return data;
}

#pragma mark 获取UUID
+ (NSString*) getUUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    
    return result;
}

#pragma mark - 获取指定长度的纯数字随机码
+ (NSString *)getNumbersWithIndex:(NSInteger)index
{
    NSString *str = @"";
    
    for (int i = 0; i < index; ++i) {
        @autoreleasepool {
            NSInteger code = arc4random()%10;
            str = [str stringByAppendingFormat:@"%ld",(long)code];
        }
    }
    
    return str;
}

#pragma mark - 转化NSDate为字符串
+ (NSString *)encodeDate:(NSDate *)date
{
    return [GlobalFunc encodeDate:date withFormatterString:@"yyyy-MM-dd HH:mm:ss"];
}

#pragma mark - 转化NSDate为字符串 （自定义格式）
+ (NSString *)encodeDate:(NSDate *)date withFormatterString:(NSString *)formatter
{
    NSDateFormatter *tmpFormatter = [[NSDateFormatter alloc] init];
    [tmpFormatter setDateFormat:formatter];
    
    return [tmpFormatter stringFromDate:date];
}

+ (NSString *)encodeDate1970:(double)time withFormatterString:(NSString *)formatter
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    return [self encodeDate:date withFormatterString:formatter];
}

+ (NSDate *)dateWithStr:(NSString *)dateStr formatterString:(NSString *)fromatter
{
    NSDateFormatter *tmpFormatter = [[NSDateFormatter alloc] init];
    [tmpFormatter setDateFormat:fromatter];
    
    return [tmpFormatter dateFromString:dateStr];
}

+ (NSString *)weekWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitWeekday;
    //int week=0;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger week = [comps weekday];
    NSLog(@"week int:%d",(int)week);
    
    NSArray *arrWeek = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    if(week > 0 && week <= arrWeek.count){
        return [arrWeek objectAtIndex:week-1];
    }
    else{
        return @"";
    }
    
    //return arrWeek[week];
}

+ (NSString *)weekWithDate1970:(CGFloat)time
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    return [self weekWithDate:date];
}

#pragma mark - 检查是否为字符串
+ (BOOL)checkObject:(NSString *)str
{
    if (str == nil || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"（null）"]) {
        return NO;
    }
    
    return YES;
}

//自定义默认字体
+ (UIFont *)defaultFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}

+ (UIFont *)defaultBoldFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

//16进制字符串 转换为int
+ (UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha
{
    if (hex.length < 7) {
        return nil;
    }
    
    unsigned color = 0;
    NSScanner *hexValueScanner = [NSScanner scannerWithString:[hex substringFromIndex:1]];
    [hexValueScanner scanHexInt:&color];
    
    int blue = color & 0xFF;
    int green = (color >> 8) & 0xFF;
    int red = (color >> 16) & 0xFF;
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

#pragma mark 显示信息
+ (void)showAlertWithMessage:(NSString *)msg
{
    UIAlertView *alertMsg = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alertMsg show];
}

#pragma mark - 检测网络
+ (NSInteger)checkNetWork
{
    NSInteger state = 0;//默认 无网络
    Reachability *r=[Reachability reachabilityForInternetConnection];
    switch ([r currentReachabilityStatus]) {
        case NotReachable: // 没有网络连接 netstate=@"没有网络";
            state = 0;
            //NSLog(@"无网络");
            break;
        case ReachableViaWWAN:{ // 使用3G网络
            state = 1;
            //NSLog(@"3G");
        }
            break;
        case ReachableViaWiFi:{ // 使用WiFi网络
            state = 2;
            //NSLog(@"wifi");
        }
            break;
    }
    
    return state;
}

#pragma mark - 验证价格 double
+ (NSString *)checkPrice:(double)price
{
    if (price == (int)price) {
        return [NSString stringWithFormat:@"%.0f",price];
    }
    
    NSString *price1 = [NSString stringWithFormat:@"%.1f",price];
    NSString *price2 = [NSString stringWithFormat:@"%.2f",price];
    if (price1.doubleValue == price2.doubleValue) {
        return price1;
    }
    
    return price2;
}

+ (NSString *)standerPrice:(double)price
{
    NSString *result = [GlobalFunc standerStrPrice:[GlobalFunc checkPrice:price]];
    
    return result;
}

+ (NSString *)standerStrPrice:(NSString *)price
{
    if (price == nil || ![price isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSString *pref = price;
    NSRange range = [price rangeOfString:@"."];
    if (range.length) {
        pref = [pref substringToIndex:range.location];
    }
    
    NSInteger length = pref.length;
    while (length > 3) {
        length -= 3;
        pref = [pref stringByReplacingCharactersInRange:NSMakeRange(length, 0) withString:@","];
    }
    
    NSString *result = pref;
    if (range.length) {
        result = [pref stringByAppendingString:[price substringFromIndex:range.location]];
    }
    
    return result;
}

+ (NSString *)unstanderStrPrice:(NSString *)price
{
    if (price == nil || ![price isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSString *result = [price stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    return result;
}

+ (NSString *)standerValue:(NSString *)value
{
    if ([value isKindOfClass:[NSString class]] && [value hasSuffix:@"."]) {
        return [value substringToIndex:value.length-1];
    }
    return value;
}

#pragma mark - 检测URL
+ (NSURL *)urlWithStr:(NSString *)str
{
    //NSLog(@"str:%@",str);
    if ([str isKindOfClass:[NSString class]]) {
        return [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return nil;
}



#pragma mark - 比较版本号大小
+ (BOOL)moreThanVersion:(NSString *)version
{
    NSString *currentVersoion = [AppVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *compareVersoion = [version stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSComparisonResult result = [compareVersoion compare:currentVersoion options:NSLiteralSearch];
    
    if (result == NSOrderedDescending) { //大于
        return YES;
    }
    
    return NO;
}


+ (NSString *)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSLog(@"deviceString:%@",platform);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6p";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font size:(CGSize)size
{
    NSAttributedString * attributeString = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:font}];
    CGRect rect =[attributeString boundingRectWithSize:size  options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    attributeString = nil;
    
    return rect.size;
}

//+ (BOOL)checkCameraAuthorization
//{
//    BOOL isAvalible = YES;
//    //ios 7.0以上的系统新增加摄像头权限检测
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        //获取对摄像头的访问权限。
//        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//        switch (authStatus) {
//            case AVAuthorizationStatusRestricted://此应用程序没有被授权访问的照片数据。可能是家长控制权限。
//                NSLog(@"Restricted");
//                break;
//            case AVAuthorizationStatusDenied://用户已经明确否认了这一照片数据的应用程序访问.
//                NSLog(@"Denied");
//                isAvalible = NO;
//                break;
//            case AVAuthorizationStatusAuthorized://用户已授权应用访问照片数据.
//                NSLog(@"Authorized");
//                break;
//            case AVAuthorizationStatusNotDetermined://用户尚未做出了选择这个应用程序的问候
//                isAvalible =[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
//                break;
//            default:
//                break;
//        }
//    }
//    if (!isAvalible) {
//        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"您关闭了搜狐社区的相机权限，无法进行拍照。可以在手机 > 设置 > 隐私 > 相机中开启权限。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [errorAlert show];
//        errorAlert = nil;
//    }
//
//    return isAvalible;
//}

#pragma mark - 倒计时
+ (NSString *)detailTimer:(NSString *)minut byIndex:(NSInteger)index
{
    // 0:天 1:时 2:分 3:秒 4:总小时
    NSInteger day = 0;
    long long hour = 0;
    long long minutes = 0;
    long long secondes = 0;
    if (minut.intValue > 0) {
        day = minut.integerValue/(24*60*60);
        hour = (minut.longLongValue/(60*60))%24;
        minutes = minut.longLongValue/60-(day*24*60)-(hour*60);
        secondes = minut.longLongValue%60;
    }
    
    NSString *returnStr = nil;
    switch (index) {
        case 0: { //天
            if (day < 10) {
                returnStr = [NSString stringWithFormat:@"0%ld",(long)day];
            } else {
                returnStr = [NSString stringWithFormat:@"%ld",(long)day];
            }
        }
            break;
        case 1: { //时
            if (hour < 10) {
                returnStr = [NSString stringWithFormat:@"0%lld",hour];
            } else {
                returnStr = [NSString stringWithFormat:@"%lld",hour];
            }
        }
            break;
        case 2: { //分
            if (minutes < 10) {
                returnStr = [NSString stringWithFormat:@"0%lld",minutes];
            } else {
                returnStr = [NSString stringWithFormat:@"%lld",minutes];
            }
        }
            break;
        case 3: { //秒
            if (secondes < 10) {
                returnStr = [NSString stringWithFormat:@"0%lld",secondes];
            } else {
                returnStr = [NSString stringWithFormat:@"%lld",secondes];
            }
        }
            break;
        case 4: { //总小时
            if (day*24+hour < 10) {
                returnStr = [NSString stringWithFormat:@"0%lld",day*24+hour];
            } else {
                returnStr = [NSString stringWithFormat:@"%lld",day*24+hour];
            }
        }
            break;
        default:
            break;
    }
    
    return returnStr;
}

+ (NSString *)detailSignTimer:(NSString *)minut byIndex:(NSInteger)index
{
    // 0:天 1:时 2:分 3:秒 4:总小时
    NSInteger day = 0;
    long long hour = 0;
    long long minutes = 0;
    long long secondes = 0;
    if (minut.intValue > 0) {
        day = minut.integerValue/(24*60*60);
        hour = (minut.longLongValue/(60*60))%24;
        minutes = minut.longLongValue/60-(day*24*60)-(hour*60);
        secondes = minut.longLongValue%60;
    }
    
    NSString *returnStr = nil;
    switch (index) {
        case 0: { //天
            returnStr = [NSString stringWithFormat:@"%ld",(long)day];
        }
            break;
        case 1: { //时
            returnStr = [NSString stringWithFormat:@"%lld",hour];
        }
            break;
        case 2: { //分
            returnStr = [NSString stringWithFormat:@"%lld",minutes];
        }
            break;
        case 3: { //秒
            returnStr = [NSString stringWithFormat:@"%lld",secondes];
        }
            break;
        case 4: { //总小时
            returnStr = [NSString stringWithFormat:@"%lld",day*24+hour];
        }
            break;
        default:
            break;
    }
    
    return returnStr;
}

+ (NSString *)compareDate:(NSString *)dateStr day:(BOOL)day
{
    //2015-09-28 13:55
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *dateCurrent =[format dateFromString:dateStr];
    
    if (day) {
        NSDate *today = [NSDate date];
        NSDate *tomorrow = [NSDate dateWithTimeIntervalSinceNow:24*60*60];
        
        [format setDateFormat:@"yyyy-MM-dd"];
        NSString *strCurrent = [format stringFromDate:dateCurrent];
        NSString *strToday = [format stringFromDate:today];
        NSString *strTomorrow = [format stringFromDate:tomorrow];
        
        if ([strCurrent isEqualToString:strToday]) {
            return @"今天";
        } else if ([strCurrent isEqualToString:strTomorrow]) {
            return @"明天";
        } else {
            [format setDateFormat:@"M月d日"];
            NSString *result = [format stringFromDate:dateCurrent];
            return result;
        }
    } else {
        [format setDateFormat:@"H:mm"];
        NSString *result = [format stringFromDate:dateCurrent];
        return result;
    }
    
    return nil;
}

+ (UIImage *)pngWithName:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    path = nil;
    
    return img;
}

- (NSString *)bankNameWithCode:(NSString *)code
{
    switch (code.integerValue) {
        case 102: return @"中国工商银行"; break;
        case 103: return @"中国农业银行"; break;
        case 104: return @"中国银行"; break;
        case 105: return @"中国建设银行"; break;
        case 301: return @"交通银行"; break;
        case 302: return @"中信银行"; break;
        case 303: return @"中国光大银行"; break;
        case 304: return @"华夏银行"; break;
        case 305: return @"中国民生银行"; break;
        case 306: return @"广发银行"; break;
        case 307: return @"平安银行"; break;
        case 308: return @"招商银行"; break;
        case 309: return @"兴业银行"; break;
        case 310: return @"浦发银行"; break;
        case 403: return @"中国邮政储蓄银行"; break;
        default:
            break;
    }
    return @"";
}

/*400*/
+ (void)tel400
{
    NSURL *url = [NSURL URLWithString:@"tel:4000-655-677"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        NSLog(@"sorry,do not support call");
    }
}

#pragma -mark 压缩图片


/*
 *宽高按照比例缩放
 */

+ (UIImage *) scaleToSizeAlpha:(UIImage *)img alpha:(float)alpha{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    CGSize targetSize = CGSizeMake(img.size.width*alpha,  img.size.height*alpha);
    UIGraphicsBeginImageContext(targetSize);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

/*
 *宽不变，高等比例变化
 */
+ (UIImage *) scaleToSizeAlpha:(UIImage *)img fixedWith:(float)fixedWith{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    CGSize targetSize = CGSizeMake(fixedWith, fixedWith*(img.size.height/img.size.width));
    UIGraphicsBeginImageContext(targetSize);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

/*
 *宽不变，高等比例变化
 */
+ (UIImage *) scaleToSizeAlpha:(UIImage *)img fixedHeight:(float)fixedHeight{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    CGSize targetSize = CGSizeMake( fixedHeight*(img.size.width/img.size.height),fixedHeight);
    UIGraphicsBeginImageContext(targetSize);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


+(NSString*)getCurrentTime{
    
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm"];
    [dateFormatter setTimeZone:localzone];
    
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    
    return dateString;
}

+(NSString*)getCurrentTimeWithFormatter:(NSString*)formattter{
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formattter];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSLog(@"dateString:%@",dateString);
    
    return dateString;
}



//表情判断
+(NSString *)disableEmoji:(NSString *)text{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}
+(BOOL)stringContainsEmoji:(NSString *)string{
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    returnValue =YES;
                }
            }else {
                // non surrogate
                if (0x2100 <= hs && hs <= 0x27ff) {
                    returnValue =YES;
                }else if (0x2B05 <= hs && hs <= 0x2b07) {
                    returnValue =YES;
                }else if (0x2934 <= hs && hs <= 0x2935) {
                    returnValue =YES;
                }else if (0x3297 <= hs && hs <= 0x3299) {
                    returnValue =YES;
                }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                    returnValue =YES;
                }
            }
        }
    }];
    return returnValue;
}

//根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL{
    NSURL *URL = nil;
    if([imageURL
        isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL= [NSURL URLWithString:imageURL];
    }
    if(URL == nil){
        return  CGSizeZero;// url不正确返回CGSizeZero
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString *pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size = [self getPNGImageSizeWithRequest:request];
    }
    else{
        if([pathExtendsion  isEqual:@"gif"]) {
            size = [self getGIFImageSizeWithRequest:request];
        }
        else{
            size = [self getJPGImageSizeWithRequest:request];
        }
    }
    
    if(CGSizeEqualToSize(CGSizeZero, size)){//  如果获取文件头信息失败,发送异步请求请求原图
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        
        UIImage *image = [UIImage imageWithData:data];
        if(image){
            size = image.size;
        }
    }
    return size;
}

//获取gif图片的大小
+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request{
    
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4){
        
        short  w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0,1)];
        [data getBytes:&w2 range:NSMakeRange(1,1)];
        
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        
        short  h = h1 + (h2 << 8);
        return
        CGSizeMake(w, h);
    }
    return CGSizeZero;
}

//获取jpg图片的大小
+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request{
    
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    
    NSData*  data = [NSURLConnection  sendSynchronousRequest:request returningResponse:nil  error:nil];
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60,0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61,0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f,0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    }
    else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15,0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a,0x1)];
            if(word == 0xdb) {//两个DQT字段
                
                short w1 = 0, w2 = 0;
                
                [data getBytes:&w1 range:NSMakeRange(0xa5,0x1)];
                
                [data getBytes:&w2 range:NSMakeRange(0xa6,0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3,0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4,0x1)];
                short h = (h1 << 8) + h2;
                
                return CGSizeMake(w, h);
            }
            else{//一个DQT字段
                short w1 = 0, w2 = 0;
                
                [data getBytes:&w1 range:NSMakeRange(0x60,0x1)];
                [data  getBytes:&w2 range:NSMakeRange(0x61,0x1)];
                
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                
                [data getBytes:&h1 range:NSMakeRange(0x5e,0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f,0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
                
            }
            
        }
        else{
            return CGSizeZero;
        }
        
    }
    
}
//获取PNG图片的大小

+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request {
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData*  data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if(data.length == 8){
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0,1)];
        
        [data getBytes:&w2 range:NSMakeRange(1,1)];
        
        [data getBytes:&w3 range:NSMakeRange(2,1)];
        
        [data getBytes:&w4 range:NSMakeRange(3,1)];
        
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        
        [data getBytes:&h1 range:NSMakeRange(4,1)];
        
        [data getBytes:&h2 range:NSMakeRange(5,1)];
        
        [data getBytes:&h3 range:NSMakeRange(6,1)];
        
        [data getBytes:&h4 range:NSMakeRange(7,1)];
        
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        
        return CGSizeMake(w, h);
        
    }
    
    return CGSizeZero;
    
}


+ (NSString*)dataTojsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


+(NSString*)getImageFileFolder{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    // create folder for database if needed
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,
                                                         NSUserDomainMask,
                                                         YES)
                     lastObject];
    NSString *imagefolder = [dir stringByAppendingPathComponent:@"imageFileFolder"];
    
    
    NSLog(@"imagefolder = %@",imagefolder);
    if (![fm fileExistsAtPath:imagefolder]) {
        NSLog(@"start to create database folder");
        NSError *error = nil;
        if (![fm createDirectoryAtPath:imagefolder withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"Ooops, cannot create imageCache folder - %@", imagefolder);
            //            return;
        }
    }
    
    return imagefolder;
}




//随机色
+(UIColor *)randomColor {
    //    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    //    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    //    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    //
    //    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    CGFloat red = ( arc4random() % 256 );  //  0.0 to 255
    CGFloat green = ( arc4random() % 256 );  //  0.0 to 255
    CGFloat blue = ( arc4random() % 256 );  //  0.0 to 255
    
    return  RGB(red, green,blue);
}



@end
