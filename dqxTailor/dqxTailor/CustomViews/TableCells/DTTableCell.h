//
//  DTTableCell.h
//  dqxTailor
//
//  Created by HANSHAOWEN on 17/1/6.
//  Copyright © 2017年 HANSHAOWEN. All rights reserved.
//

#ifndef DTTableCell_h
#define DTTableCell_h

#import "DTBaseCell.h"

FOUNDATION_EXPORT NSString *const kDTTableCellID;

@interface DTTableCell : DTBaseCell

+ (CGFloat)cellHeight;

- (void)configureCellWithTitle:(NSString *)title imageName:(NSString *)imageName atIndexPath:(NSIndexPath *)indexPath;

@end

#endif /* DTTableCell_h */
