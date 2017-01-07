//
//  DTGlobalTailorInfo.m
//  dqxTailor
//
//  Created by HANSHAOWEN on 17/1/7.
//  Copyright © 2017年 HANSHAOWEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTGlobalTailorInfo.h"

@implementation DTGlobalTailorInfo

-(DTGlobalTailorInfo*)initMine:(NSString*)name itemType:(NSInteger)type zone1:(NSString*)z1 zone2:(NSString*)z2 zone3:(NSString*)z3 zone4:(NSString*)z4 zone5:(NSString*)z5 zone6:(NSString*)z6 zone7:(NSString*)z7 zone8:(NSString*)z8 zone9:(NSString*)z9 pattern1:(NSString*)p1 pattern2:(NSString*)p2 pattern3:(NSString*)p3 pattern4:(NSString*)p4 pattern5:(NSString*)p5 pattern6:(NSString*)p6 pattern7:(NSString*)p7 pattern8:(NSString*)p8 pattern9:(NSString*)p9 pattern10:(NSString*)p10{
    self =[super init];
    self.itemName = name;
    self.type = type;
    self.zones = [[NSArray alloc] initWithObjects:z1, z2, z3, z4, z5, z6, z7, z8, z9, nil];
    self.patterns = [[NSArray alloc] initWithObjects:p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, nil];
    
    return self;
}

@end
