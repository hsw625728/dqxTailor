//
//  DTGlobalTailorInfo.h
//  dqxTailor
//
//  Created by HANSHAOWEN on 17/1/7.
//  Copyright © 2017年 HANSHAOWEN. All rights reserved.
//

#ifndef DTGlobalTailorInfo_h
#define DTGlobalTailorInfo_h

@interface DTGlobalTailorInfo : NSObject

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSArray *zones;
@property (nonatomic, copy) NSArray *patterns;

-(DTGlobalTailorInfo*)initMine:(NSString*)name itemType:(NSInteger)type zone1:(NSString*)z1 zone2:(NSString*)z2 zone3:(NSString*)z3 zone4:(NSString*)z4 zone5:(NSString*)z5 zone6:(NSString*)z6 zone7:(NSString*)z7 zone8:(NSString*)z8 zone9:(NSString*)z9 pattern1:(NSString*)p1 pattern2:(NSString*)p2 pattern3:(NSString*)p3 pattern4:(NSString*)p4 pattern5:(NSString*)p5 pattern6:(NSString*)p6 pattern7:(NSString*)p7 pattern8:(NSString*)p8 pattern9:(NSString*)p9 pattern10:(NSString*)p10;

@end

#endif /* DTGlobalTailorInfo_h */
