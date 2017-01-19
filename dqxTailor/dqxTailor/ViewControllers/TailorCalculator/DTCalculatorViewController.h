//
//  DTCalculatorViewController.h
//  dqxTailor
//
//  Created by HANSHAOWEN on 17/1/6.
//  Copyright © 2017年 HANSHAOWEN. All rights reserved.
//

#ifndef DTCalculatorViewController_h
#define DTCalculatorViewController_h

#import "DTBaseViewController.h"
//tencent
#import "GDTMobInterstitial.h"

@interface DTCalculatorViewController : DTBaseViewController<GDTMobInterstitialDelegate>{
    GDTMobInterstitial *_interstitialObj;
}
- (void) setEquipName:(NSString*)name;

@end

#endif /* DTCalculatorViewController_h */
