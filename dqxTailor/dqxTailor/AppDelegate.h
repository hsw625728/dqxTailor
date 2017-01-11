//
//  AppDelegate.h
//  dqxTailor
//
//  Created by HANSHAOWEN on 17/1/6.
//  Copyright © 2017年 HANSHAOWEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDTSplashAd.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GDTSplashAdDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) GDTSplashAd *splash;
@property (nonatomic, copy) NSMutableDictionary *gTailorInfo;

@end

