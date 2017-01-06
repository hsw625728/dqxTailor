//
//  DTAppSettingCell.h
//  dqxTailor
//
//  Created by HANSHAOWEN on 17/1/6.
//  Copyright © 2017年 HANSHAOWEN. All rights reserved.
//

#ifndef DTAppSettingCell_h
#define DTAppSettingCell_h

#import "DTBaseCell.h"

FOUNDATION_EXPORT NSString *const kDTAppSettingCellID;

@interface DTAppSettingCell : DTBaseCell

+ (CGFloat)cellHeight;

- (void)configureCellWithTitle:(NSString *)title imageName:(NSString *)imageName atIndexPath:(NSIndexPath *)indexPath;
@end

#endif /* DTAppSettingCell_h */
