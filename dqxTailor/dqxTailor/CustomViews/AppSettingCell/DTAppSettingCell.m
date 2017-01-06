//
//  DTAppSettingCell.m
//  dqxTailor
//
//  Created by HANSHAOWEN on 17/1/6.
//  Copyright © 2017年 HANSHAOWEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "View+MASAdditions.h"
#import "DTAppSettingCell.h"

NSString *const kDTAppSettingCellID = @"kDTAppSettingCellID";

@interface DTAppSettingCell ()

@property (strong, nonatomic) UIImageView *leftImageView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation DTAppSettingCell

+ (CGFloat)cellHeight {
    return 44;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    _leftImageView.image = nil;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    if (_leftImageView) {
        return;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _leftImageView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@44);
            make.top.left.equalTo(self.contentView);
        }];
        
        imageView;
    });
    
    _titleLabel = ({
        UILabel *label = [UILabel new];
        label.font = FontWithSize(14);
        label.textColor = [UIColor colorWithWhite:72 / 255.0 alpha:1];// #484848
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(_leftImageView.mas_right).offset(8);
        }];
        
        label;
    });
    /*设定界面的右侧小箭头，暂时不用
     UIImageView *forwardView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forward_info"]];
     [self.contentView addSubview:forwardView];
     [forwardView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.size.sizeOffset(CGSizeMake(6, 10));
     make.centerY.equalTo(self.contentView);
     make.left.greaterThanOrEqualTo(_titleLabel.mas_right).offset(8);
     make.right.equalTo(self.contentView).offset(-14);
     }];*/
}

#pragma mark - Public Method

- (void)configureCellWithTitle:(NSString *)title imageName:(NSString *)imageName atIndexPath:(NSIndexPath *)indexPath {
    _titleLabel.text = title;
    if (IsStringNotEmpty(imageName)) {
        _leftImageView.image = [UIImage imageNamed:imageName];
    }
}

@end
