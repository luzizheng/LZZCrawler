//
//  UtilsMacro.h
//  UCSYaodu
//
//  Created by Luzz on 2017/3/23.
//  Copyright © 2017年 Luzz. All rights reserved.
//  为简化代码的宏定义(不要和项目业务有关)

#ifndef UtilsMacro_h
#define UtilsMacro_h

#define ucsDispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#ifdef DEBUG
#define DebugLog(s, ...) NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define DebugLog(s, ...)
#endif


// number
#define UCSDecimalNumber(x) [NSDecimalNumber decimalNumberWithString:x]

// 快捷创建富文本
#define UCSAttributedString(text,fontSize,color) [[NSAttributedString alloc] initWithString:text attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName,color,NSForegroundColorAttributeName, nil]]



// 当前屏幕判断
#define KScreenInch_35 [UIScreen mainScreen].bounds.size.height==480?YES:NO
#define KScreenInch_4 [UIScreen mainScreen].bounds.size.height==568?YES:NO
#define KScreenInch_47 [UIScreen mainScreen].bounds.size.height==667?YES:NO
#define KScreenInch_55 [UIScreen mainScreen].bounds.size.height==736?YES:NO


#define KIntegerToString(x) [NSString stringWithFormat:@"%ld",(long)(x)]

#pragma mark- 颜色
//----------------------颜色----------------------------
// 获取颜色--RGBA
#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGBACOLOR(r,g,b,a) RGBA(r, g, b, a)

// 获取颜色--RGB
#define RGB(r,g,b)          RGBA(r,g,b,1.0f)

// 需第三方类库——————FHColor
#define colorFromHex( _hexValue_ ) ( [UIColor colorWithHexString:_hexValue_] )
#define colorFromHexAlpha( _hexValue_, _alpha_ ) ( [UIColor colorWithHexString:_hexValue_ alpha:_alpha_] )
//----------------------颜色----------------------------


#pragma mark- 屏幕
//----------------------屏幕----------------------------
// Pad设备判断--Xib或Storyboard
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//----------------------屏幕----------------------------



#pragma mark- 系统版本
//----------------------系统版本----------------------------
// 系统版本号
#define isIOS4 ([[[UIDevice currentDevice] systemVersion] intValue]==4)
#define isIOS5 ([[[UIDevice currentDevice] systemVersion] intValue]==5)
#define isIOS6 ([[[UIDevice currentDevice] systemVersion] intValue]==6)
#define isIOS7 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice]systemVersion] floatValue] < 8.0)
#define isAfterIOS4 ([[[UIDevice currentDevice] systemVersion] intValue] >= 4)
#define isAfterIOS5 ([[[UIDevice currentDevice] systemVersion] intValue] >= 5)
#define isAfterIOS6 ([[[UIDevice currentDevice] systemVersion] intValue] >= 6)
#define IsAfterIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0)
#define IsAfterIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)

#define iOSCurrentVersion ([[UIDevice currentDevice] systemVersion])

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define AppShortVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//----------------------系统版本----------------------------



#pragma mark- 系统版本
//----------------------字体----------------------------
#define kBoldFont(_size_) [UIFont boldSystemFontOfSize:_size_]
#define kSystemFont(_size_) [UIFont systemFontOfSize:_size_]
//----------------------字体----------------------------



#pragma mark- 屏幕大小
//----------------------屏幕大小----------------------------
//应用尺寸(不包括状态栏,通话时状态栏高度不是20，所以需要知道具体尺寸)
#define kContent_Height   ([UIScreen mainScreen].applicationFrame.size.height)
#define kContent_Width    ([UIScreen mainScreen].applicationFrame.size.width)
#define kContent_Frame    (CGRectMake(0, 0 ,kContent_Width,kContent_Height))
#define kContent_CenterX  kContent_Width/2
#define kContent_CenterY  kContent_Height/2
//----------------------屏幕大小----------------------------
#define kIPhone4 [UIScreen mainScreen].bounds.size.height==480?YES:NO
#define kIPhone5 [UIScreen mainScreen].bounds.size.height==568?YES:NO
#define kIPhone6 [UIScreen mainScreen].bounds.size.height==667?YES:NO
#define kIPhone6_plus [UIScreen mainScreen].bounds.size.height==736?YES:NO
//设备屏幕尺寸
//----------------------备屏幕尺寸----------------------------
#define kScreen_Height   ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width    ([UIScreen mainScreen].bounds.size.width)
#define kScreen_Frame    (CGRectMake(0, 0 ,kScreen_Width,kScreen_Height))
#define kScreen_CenterX  kScreen_Width/2
#define kScreen_CenterY  kScreen_Height/2
#define UCSSize(_size_) kScreen_Width*_size_/375.0
#define kSizeByPXDesignInIphone6(_size_) kScreen_Width*_size_/2.0/375.0 // iphone6设计图里的PX值按比例计算后的实际值
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
//----------------------备屏幕尺寸----------------------------



#pragma mark- Frame
//----------------------Frame----------------------------
//获取 Frame 的 x，y 坐标
#define FRAME_TX(frame)  (frame.origin.x)
#define FRAME_TY(frame)  (frame.origin.y)
//获取 Frame 的宽高
#define FRAME_W(frame)  (frame.size.width)
#define FRAME_H(frame)  (frame.size.height)
//----------------------Frame----------------------------



#pragma mark- UIView Frame
//----------------------UIView Frame----------------------------
//获取 UIView Frame 的 x，y 坐标
#define VIEW_TX(view) (view.frame.origin.x)
#define VIEW_TY(view) (view.frame.origin.y)
//获取 UIView Frame 的宽高
#define VIEW_W(view)  (view.frame.size.width)
#define VIEW_H(view)  (view.frame.size.height)
//----------------------UIView Frame----------------------------

//----------------------圆角----------------------------
#define kCornerView(ucsbtn_,cornerRadius_)  \
ucsbtn_.layer.cornerRadius = cornerRadius_;\
ucsbtn_.clipsToBounds = YES;\
ucsbtn_.layer.masksToBounds = YES;
//----------------------圆角----------------------------

#pragma mark- 屏幕固定高度
//屏幕固定高度
//----------------------屏幕固定高度----------------------------
#define UI_NAVIGATION_BAR_HEIGHT        44
#define UI_TOOL_BAR_HEIGHT              44
#define UI_TAB_BAR_HEIGHT               49
#define UI_STATUS_BAR_HEIGHT            20
//----------------------屏幕固定高度----------------------------



#pragma mark---- 文件路径
//----------------------文件路径----------------------------
// 文件相关路径
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_OF_CacheDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define PATH_OF_LibraryDirectory [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES) objectAtIndex:0]

#define DocumentsSubDirectory(dir) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:dir]

#define LibrarySubDirectory(dir) [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:dir]

#define CacheSubDirectory(dir) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:dir]

#define TempSubDirectory(dir) [NSTemporaryDirectory() stringByAppendingPathComponent:dir]

//----------------------文件路径----------------------------



#pragma mark-自定义输出
//----------------------自定义输出----------------------------
//自定义输出
#ifdef DEBUG

#define MyLog(...) NSLog(__VA_ARGS__)

//重写NSLog,Debug模式下打印日志和当前行数
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfuncbtion:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

//DEBUG  模式下打印日志,当前行 并弹出一个警告
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }

#else
#define MyLog(...)
#define NSLog(FORMAT, ...) nil
#define ULog(...)

#endif

#define LogError(error) NSLog(@"Error: %@", error)

// 输出frame(frame是结构体，没法%@)
#define LOGRECT(f) NSLog(@"Rect: \nx:%f\ny:%f\nwidth:%f\nheight:%f\n",f.origin.x,f.origin.y,f.size.width,f.size.height)
// 输出BOOL值
#define LOGBOOL(b)  NSLog(@"%@",b?@"YES":@"NO");
// 输出对象方法
#define DNSLogMethod    NSLog(@"[%s] %@", class_getName([self class]), NSStringFromSelector(_cmd));
// 点
#define DNSLogPoint(p)  NSLog(@"%f,%f", p.x, p.y);
// Size
#define DNSLogSize(p)   NSLog(@"%f,%f", p.width, p.height);
//----------------------自定义输出----------------------------



//----------------------alert提示----------------------------

#define KAlert(_S_)     [[[UIAlertView alloc] initWithTitle:@"提示" message:_S_ delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]  show]

//#define KAlert(_S_)     [NSObject showTipsAlert:_S_]


//----------------------alert提示----------------------------


#pragma mark-内存
//----------------------内存----------------------------

//使用ARC和不使用ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

#pragma mark - common functions
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }

//释放一个对象
#define SAFE_DELETE(P) if(P) { [P release], P = nil; }

#define SAFE_RELEASE(x) [x release];x=nil
//----------------------内存----------------------------


#pragma mark-图片
//----------------------图片----------------------------
//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]
//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]
//建议使用前两种宏定义,性能高于后者
//----------------------图片----------------------------


#pragma mark-空值
//----------------------空值----------------------------
#define NullStrable(value) (value != nil ? value : @"")
#define NullFormat(value) (value != nil ? value : @"--")
#define Nullable(value) (value != nil ? value : @"null")
#define NullableBool(value) (value != nil ? value : [NSNumber numberWithBool:NO])
#define NullableIntValue(value) (value != nil ? value : [NSNumber numberWithInteger:0])
#define NullableTimestamp(value) (value != nil ? value : [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]])
//----------------------空值----------------------------


#pragma mark-系统环境
//----------------------系统环境----------------------------
//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#define USerDefSet(value,key) \
[[NSUserDefaults standardUserDefaults] setValue:value forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize]

#define USerDefGet(key) [[NSUserDefaults standardUserDefaults] valueForKey:key]
// 获取方法名
#define SelName(_Selector_) NSStringFromSelector(@selector(_Selector_))
//当前storyboard
#define curStory  [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil]
//当前appdelegate
#define APP_DELEGATE [(AppDelegate*)[UIApplication sharedApplication] delegate]
//当前keyWindow
#define kKeyWindow [UIApplication sharedApplication].keyWindow

//关闭键盘
#define kKeyWindow_close [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

//程序的本地化,引用国际化的文件
#define MyLocal(x, ...) NSLocalizedString(x, nil)
//根据tag获取view
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]

//----------------------系统环境----------------------------

//----------------------UIBarButtonItem----------------------------
#define kAddLeftBarButtonItem(_title_,_action_) self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:_title_ style:0 target:self action:_action_];
#define kAddRightBarButtonItem(_title_,_action_) self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:_title_ style:0 target:self action:_action_];
//----------------------UIBarButtonItem----------------------------

#pragma mark-cell
//----------------------Cell----------------------------
//去分割线
#define cellNoSperator cell.separatorInset = (IsAfterIOS8)?UIEdgeInsetsMake(15, 0, 0, kScreen_Width-15):UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width)
//设置选中颜色
#define cellSelectColor(_color_) \
self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame]; \
self.selectedBackgroundView.backgroundColor = _color_; \
//----------------------Cell----------------------------


#pragma mark-GCD
//----------------------GCD----------------------------
//并行线程
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
//串行线程
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)
//----------------------GCD----------------------------



#pragma mark- 系统openUrl行为
//----------------------系统openUrl行为----------------------------
// openURL 打开应用
#define canOpenURL(appScheme) ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appScheme]])
#define openURL(appScheme) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:appScheme]])
// telphone
#define canTel   ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:"]])
#define tel(phoneNumber)       ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]])
#define telprompt(phoneNumber) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",phoneNumber]]])
//----------------------系统openUrl行为----------------------------



#pragma mark -- 单例
//----------------------单例----------------------------
#define SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(classname) \
\
+ (classname*) sharedInstance;

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *sharedInstance = nil; \
\
+ (classname *)sharedInstance \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
sharedInstance = [[super allocWithZone:NULL] init]; \
}); \
return sharedInstance; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
return [self sharedInstance]; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}
//----------------------单例----------------------------



#pragma mark -- 角度弧度
//----------------------角度弧度----------------------------
//由角度获取弧度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
//由弧度获取角度
#define radianToDegrees(radian) (radian*180.0)/(M_PI)
//----------------------角度弧度----------------------------

// ----------------------class name----------------------
#define kClassName(_class_) NSStringFromClass([_class_ class])
//---------------------- class name----------------------


#pragma mark -- 强弱引用 self
//----------------------强弱引用 self----------------------------
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;
//----------------------强弱引用 self----------------------------


#define UCSCornerView(ucsbtn_,cornerRadius_)  \
ucsbtn_.layer.cornerRadius = cornerRadius_;\
ucsbtn_.clipsToBounds = YES;



#endif /* UtilsMacro_h */
