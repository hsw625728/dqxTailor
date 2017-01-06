//
//  DTTableHeaderView.h
//  dqxTailor
//
//  Created by HANSHAOWEN on 17/1/6.
//  Copyright © 2017年 HANSHAOWEN. All rights reserved.
//

#ifndef DTTableHeaderView_h
#define DTTableHeaderView_h

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const kDTTableHeaderViewID;

@interface DTTableHeaderView : UITableViewHeaderFooterView

+ (CGFloat)viewHeight;

@property (strong, nonatomic) UILabel *titleLabel;

@end

#endif /* DTTableHeaderView_h */
