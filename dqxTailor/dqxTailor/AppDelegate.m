//
//  AppDelegate.m
//  dqxTailor
//
//  Created by HANSHAOWEN on 17/1/6.
//  Copyright © 2017年 HANSHAOWEN. All rights reserved.
//

#import "AppDelegate.h"
#import "DTTabBarController.h"
#import <sqlite3.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //初始化核心全局数据
    [self initData];
    
    //创建主窗口
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    //设置导航栏的样式
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : DNavigationBarTitleTextColor}];
    [[UINavigationBar appearance] setTintColor:DLightGrayTextColor];
    [[UINavigationBar appearance] setBarTintColor:DNavigationBarTitleTextColor];
    
    
    _window.rootViewController = [[DTTabBarController alloc] init];
    
    //Tencent  号广告位  开屏广告
    GDTSplashAd *splash = [[GDTSplashAd alloc] initWithAppkey:@"1105827469" placementId:@"6080210894263517"];
    splash.delegate = self; //设置代理
    //根据iPhone设备不同设置不同背景图
    
    splash.fetchDelay = 5; //开发者可以设置开屏拉取时间,超时则放弃展示
    //[可选]拉取并展示全屏开屏广告
    [splash loadAdAndShowInWindow:self.window];
    self.splash = splash;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initData{
    _gTailorInfo = [[NSMutableDictionary alloc] init];
    
    //检查核心数据库文件是否已经被拷贝到应用到沙盒中
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *doc = [searchPaths objectAtIndex:0];
    NSString *dbFilePath = [doc stringByAppendingPathComponent:@"data.db"];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isExist = [fm fileExistsAtPath:dbFilePath];
    if (!isExist) {
        //沙盒中没有找到数据库就从App资源中拷贝一份
        NSString *backupDbPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"db"];
        NSError *error = [[NSError alloc] init];
        BOOL cp = [fm copyItemAtPath:backupDbPath toPath:dbFilePath error:&error];
        if (cp) {
            NSLog(@"数据库拷贝成功");
        }else{
            NSLog(@"数据库拷贝失败： %@",[error localizedDescription]);
        }
    }
    
    //开始读取数据库内容
    sqlite3 *db;
    if (sqlite3_open([dbFilePath UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    ;
    NSString *sqlQuery = @"SELECT id,equip,zone1,zone2,zone3,zone4,zone5,zone6,zone7,zone8,zone9,turn1,turn2,turn3,turn4,turn5,turn6,turn7,turn8,turn9,turn10 FROM list,pattern WHERE list.pattern==pattern.level";
    sqlite3_stmt * statement;
    
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int t = sqlite3_column_int(statement, 0) / 100;
            char *name = (char*)sqlite3_column_text(statement, 1);
            char *s1 = (char*)sqlite3_column_text(statement, 2);
            char *s2 = (char*)sqlite3_column_text(statement, 3);
            char *s3 = (char*)sqlite3_column_text(statement, 4);
            char *s4 = (char*)sqlite3_column_text(statement, 5);
            char *s5 = (char*)sqlite3_column_text(statement, 6);
            char *s6 = (char*)sqlite3_column_text(statement, 7);
            char *s7 = (char*)sqlite3_column_text(statement, 8);
            char *s8 = (char*)sqlite3_column_text(statement, 9);
            char *s9 = (char*)sqlite3_column_text(statement, 10);
            
            char *t1 = (char*)sqlite3_column_text(statement, 11);
            char *t2 = (char*)sqlite3_column_text(statement, 12);
            char *t3 = (char*)sqlite3_column_text(statement, 13);
            char *t4 = (char*)sqlite3_column_text(statement, 14);
            char *t5 = (char*)sqlite3_column_text(statement, 15);
            char *t6 = (char*)sqlite3_column_text(statement, 16);
            char *t7 = (char*)sqlite3_column_text(statement, 17);
            char *t8 = (char*)sqlite3_column_text(statement, 18);
            char *t9 = (char*)sqlite3_column_text(statement, 19);
            char *t10 = (char*)sqlite3_column_text(statement, 20);
            
            DTGlobalTailorInfo *info = [[DTGlobalTailorInfo alloc] \
                                        initMine:[[NSString alloc]initWithUTF8String:name]\
                                        itemType:t \
                                        zone1:[[NSString alloc]initWithUTF8String:s1] \
                                        zone2:[[NSString alloc]initWithUTF8String:s2] \
                                        zone3:[[NSString alloc]initWithUTF8String:s3] \
                                        zone4:[[NSString alloc]initWithUTF8String:s4] \
                                        zone5:[[NSString alloc]initWithUTF8String:s5] \
                                        zone6:[[NSString alloc]initWithUTF8String:s6] \
                                        zone7:[[NSString alloc]initWithUTF8String:s7] \
                                        zone8:[[NSString alloc]initWithUTF8String:s8] \
                                        zone9:[[NSString alloc]initWithUTF8String:s9] \
                                        pattern1:(t1 == NULL ? @"" : [[NSString alloc]initWithUTF8String:t1]) \
                                        pattern2:(t2 == NULL ? @"" : [[NSString alloc]initWithUTF8String:t2]) \
                                        pattern3:(t3 == NULL ? @"" : [[NSString alloc]initWithUTF8String:t3]) \
                                        pattern4:(t4 == NULL ? @"" : [[NSString alloc]initWithUTF8String:t4]) \
                                        pattern5:(t5 == NULL ? @"" : [[NSString alloc]initWithUTF8String:t5]) \
                                        pattern6:(t6 == NULL ? @"" : [[NSString alloc]initWithUTF8String:t6]) \
                                        pattern7:(t7 == NULL ? @"" : [[NSString alloc]initWithUTF8String:t7]) \
                                        pattern8:(t8 == NULL ? @"" : [[NSString alloc]initWithUTF8String:t8]) \
                                        pattern9:(t9 == NULL ? @"" : [[NSString alloc]initWithUTF8String:t9]) \
                                        pattern10:(t10 == NULL ? @"" : [[NSString alloc]initWithUTF8String:t10])];

            [_gTailorInfo setObject:info forKey:info.itemName];
        }
    }
    sqlite3_close(db);
}
@end
