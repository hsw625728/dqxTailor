//
//  DTDetailMaterialCell.h
//  dqxTailor
//
//  Created by HANSHAOWEN on 17/1/6.
//  Copyright © 2017年 HANSHAOWEN. All rights reserved.
//

#ifndef DTDetailMaterialCell_h
#define DTDetailMaterialCell_h

#import "DTBaseCell.h"

FOUNDATION_EXPORT NSString *const kDTDetailMaterialCellID;

@interface DTDetailMaterialCell : DTBaseCell

+ (CGFloat)cellHeight;

- (void)set:(NSString*)name iconName:(NSString*)icon neceNum:(NSString*)nec;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *neceNumLabel;
@property (strong, nonatomic) IBOutlet UIImageView *iconView;

@end

#endif /* DTDetailMaterialCell_h */
