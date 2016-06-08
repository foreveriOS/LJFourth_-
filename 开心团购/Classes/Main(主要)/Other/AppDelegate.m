//
//  AppDelegate.m
//  开心团购
//
//  Created by huiwen on 15/10/14.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "AppDelegate.h"
#import "MTMainViewController.h"
#import "MTNetworkSingletion.h"

#import <CoreLocation/CoreLocation.h>
#import "UIImageView+WebCache.h"
//#import "UMSocial.h"
//#import "UMSocialWechatHandler.h"
//#import "MobClick.h"

#define AdvImagePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"loarding.png"]]
@interface AppDelegate ()<CLLocationManagerDelegate>
{
    //定位
    CLLocationManager *_locationManager;//用于获取位置
    CLLocation *_checkLocation;//用于保存位置信息
}

@property(nonatomic, strong) UIImageView *advImage;
@property(nonatomic, strong) MTMainViewController *rootTabBarCtr;

@end

@implementation AppDelegate

- (UIImageView *)advImage
{
    if(_advImage == nil){
    
        _advImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    }
    return _advImage;

}

//设定位置
- (void)setupLocationManager{
    _latitude = LATITUDE_DEFAULT;
    _longitude = LONGITUDE_DEFAULT;
    _locationManager = [[CLLocationManager alloc] init];
    
    if([CLLocationManager locationServicesEnabled]){
        MTLog(@"开始定位");
        _locationManager.delegate = self;
        //distanceFilter是距离过滤器，为了减少定位装置的查询次数，用户移动了200.0米的距离才通知委托程序，单位是米
        _locationManager.distanceFilter = 200.0;
        //kCLLocationAccuracyBest:设备使用电池的时候的最高精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        //iOS8以上要授权，并且在plist文件中添加NSLocationWhenInUseUsageDescription，NSLoationAlwaysUsageDescription，值可以为空
        if(IOS_VERSION >= 8.0){
            [_locationManager requestWhenInUseAuthorization];
            [_locationManager requestAlwaysAuthorization];
        }
        [_locationManager startUpdatingLocation];
    }else{
        MTLog(@"定位失败，请确认是否开启定位功能");
    
    }
}
//获取启动广告图片，采用后台推送执行请求
- (void)getLoadingImage{
    //分辨率
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    MTLog(@"%.0f   %.0f",screen_width*scale_screen,screen_height*scale_screen);
    int scaleW = (int)screen_width*scale_screen;
    int scaleH = (int)screen_height*scale_screen;
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.meituan.com/config/v1/loading/check.json?app_name=group&app_version=5.7&ci=1&city_id=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-15-15-51824&platform=iphone&resolution=%d%@%d&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGhomepage&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7",scaleW,@"%2A",scaleH];
    
    [[MTNetworkSingletion shareManager] getAdvLoadingImage:nil url:urlStr success:^(id responseBody) {
        MTLog(@"获取广告图片成功");
        NSMutableArray *dataArray = [responseBody objectForKey:@"data"];
        MTLog(@"dataArray:%@",dataArray);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if(dataArray.count>0){
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dataArray[0] objectForKey:@"imageUrl"]]];
                UIImage *image = [UIImage imageWithData:data];
                    NSString *filePath = AdvImagePath;//启动图片存储路径
                
                MTLog(@"filePath:%@",filePath);
                //压缩后写入文件
                [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
                
            }
        });
    } failure:^(NSError *error) {
        
        MTLog(@"获取启动广告图片失败：%@",[error.userInfo objectForKey:@"NSLocalizedDescription"]);
        
    }];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [self setupLocationManager];
    [self initRootVC];
    
//    [self initUM];
    
    [self initAdvView];
    
    return YES;
}

- (void)initRootVC
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.rootTabBarCtr = [[MTMainViewController alloc] init];
    self.window.rootViewController = self.rootTabBarCtr;
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)initAdvView
{
    NSString *filePath = AdvImagePath;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isExit = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
    if(isExit){
        MTLog(@"存在启动图片");

        [self.advImage setImage:[UIImage imageWithContentsOfFile:filePath]];
        //在窗口上添加图片
        [self.window addSubview:_advImage];
        //3s后启动图片移除
        [self performSelector:@selector(removeAdvImage) withObject:nil afterDelay:3];
     
    }else{
        MTLog(@" 启动图片不存在");
     }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //加载启动广告并保存到本地沙盒，因为保存图片大，而且每次都要保存，所以开一个额外线程
        [self getLoadingImage];
    });

}
- (void)removeAdvImage
{

    [UIView animateWithDuration:0.3f animations:^{
        _advImage.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        _advImage.alpha = 0.f;
    } completion:^(BOOL finished) {
        [_advImage removeFromSuperview];
    }];

}
//- (void)initUM{
//    //友盟统计
//    [MobClick startWithAppkey:UMAPPKEY reportPolicy:BATCH   channelId:@"GitHub"];
//    
//    
//    //友盟初始化
//    [UMSocialData setAppKey:UMAPPKEY];
//    [UMSocialWechatHandler setWXAppId:@"wx3b1ec5fee404cc3d" appSecret:@"e97199313f931035a765ee433e335dbb" url:@"http://www.fityun.cn/"];
//    
//    //友盟初始化，对未安装QQ，微信的平台进行隐藏
//    //    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
//    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToWechatSession,UMShareToWechatTimeline]];
//    
//
//
//}

//接收到内存警告的时候
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    //删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.google.____" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"____" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"____.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    MTLog(@"didUpdateLocations");
    //此处locations储存了持续更新位置的坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值后让locationManager stopUpdatingLocation
    CLLocation *cl = [locations lastObject];
    _latitude = cl.coordinate.latitude;
    _longitude = cl.coordinate.longitude;
    
    MTLog(@"纬度－－%f",_latitude);
    MTLog(@"经度－－%f",_longitude);

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    MTLog(@"定位失败，error ＝ %@",error);
}

//禁止横屏幕
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

////友盟微信分享
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    return [UMSocialSnsService handleOpenURL:url];
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return [UMSocialSnsService handleOpenURL:url];
//
//}


@end
