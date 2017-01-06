//
//  DTAppHelpViewController.m
//  dqxTailor
//
//  Created by HANSHAOWEN on 17/1/6.
//  Copyright © 2017年 HANSHAOWEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "View+MASAdditions.h"
#import "UIImage+Common.h"
#import "DTAppHelpViewController.h"


@interface DTAppHelpViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation DTAppHelpViewController{
    NSString *imageName;
}

#pragma mark - Lifecycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = DAppHelp;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self setupViews];
}

#pragma mark - Private Method


- (void)setupViews {
    CGFloat contentViewWidth = CGRectGetWidth([UIScreen mainScreen ].applicationFrame);
    
    
    _imageView = ({
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]] ;
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeMake(contentViewWidth, contentViewWidth*1.56));
            make.left.equalTo(self.view).offset(0);
        }];
        
        view;
    });
}
-(void)setHelpImageName:(NSString*)name
{
    imageName = name;
}
@end
