//
//  DTCalculatorViewController.m
//  dqxTailor
//
//  Created by HANSHAOWEN on 17/1/6.
//  Copyright © 2017年 HANSHAOWEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTCalculatorViewController.h"
#import "UIImage+Common.h"
#import "View+MASAdditions.h"
#import "DTTableHeaderView.h"

@interface DTCalculatorViewController ()

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIButton *btnNumber0;
@property (strong, nonatomic) UIButton *btnNumber1;
@property (strong, nonatomic) UIButton *btnNumber2;
@property (strong, nonatomic) UIButton *btnNumber3;
@property (strong, nonatomic) UIButton *btnNumber4;
@property (strong, nonatomic) UIButton *btnNumber5;
@property (strong, nonatomic) UIButton *btnNumber6;
@property (strong, nonatomic) UIButton *btnNumber7;
@property (strong, nonatomic) UIButton *btnNumber8;
@property (strong, nonatomic) UIButton *btnNumber9;
@property (strong, nonatomic) UIButton *btnDone;
@property (strong, nonatomic) UIButton *btnRecover;

@property (strong, nonatomic) UITextField *tile1;
@property (strong, nonatomic) UITextField *tile2;
@property (strong, nonatomic) UITextField *tile3;
@property (strong, nonatomic) UITextField *tile4;
@property (strong, nonatomic) UITextField *tile5;
@property (strong, nonatomic) UITextField *tile6;
@property (strong, nonatomic) UITextField *tile7;
@property (strong, nonatomic) UITextField *tile8;
@property (strong, nonatomic) UITextField *tile9;

@end

@implementation DTCalculatorViewController{
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

//#define BTN_TILE_SETTING(

- (void)setupViews {
    CGFloat contentViewWidth = CGRectGetWidth([UIScreen mainScreen ].applicationFrame);
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    const float WIDTH = contentViewWidth/12;
    const float VOFFSET = WIDTH/10;
    
    _btnRecover = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:@"+" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(recBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(-4*WIDTH);
            make.bottom.equalTo(self.view).offset(-4);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, WIDTH));
        }];
        btn;
    });
    
    _btnNumber0 = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:@"0" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view).offset(-4);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, WIDTH));
        }];
        btn;
    });
    
    _btnDone = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(doneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(4*WIDTH);
            make.bottom.equalTo(self.view).offset(-4);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, WIDTH));
        }];
        btn;
    });
    
    _btnNumber1 = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(-4*WIDTH);
            make.bottom.equalTo(self.view).offset(-4 - WIDTH - VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, WIDTH));
        }];
        btn;
    });
    
    _btnNumber2 = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:@"2" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view).offset(-4 - WIDTH - VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, WIDTH));
        }];
        btn;
    });
    
    _btnNumber3 = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:@"3" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(4*WIDTH);
            make.bottom.equalTo(self.view).offset(-4 - WIDTH - VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, WIDTH));
        }];
        btn;
    });
    
    _btnNumber4 = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:@"4" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(-4*WIDTH);
            make.bottom.equalTo(self.view).offset(-4 - 2*WIDTH - 2*VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, WIDTH));
        }];
        btn;
    });
    
    _btnNumber5 = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:@"5" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view).offset(-4 - 2*WIDTH - 2*VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, WIDTH));
        }];
        btn;
    });
    
    _btnNumber6 = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:@"6" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(4*WIDTH);
            make.bottom.equalTo(self.view).offset(-4 - 2*WIDTH - 2*VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, WIDTH));
        }];
        btn;
    });
    
    _btnNumber7 = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:@"7" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(-4*WIDTH);
            make.bottom.equalTo(self.view).offset(-4 - 3*WIDTH - 3*VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, WIDTH));
        }];
        btn;
    });
    
    _btnNumber8 = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:@"8" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view).offset(-4 - 3*WIDTH - 3*VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, WIDTH));
        }];
        btn;
    });
    
    _btnNumber9 = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:@"9" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(4*WIDTH);
            make.bottom.equalTo(self.view).offset(-4 - 3*WIDTH - 3*VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, WIDTH));
        }];
        btn;
    });
    
    
    _tile1 = ({
        UITextField *text = [[UITextField alloc] init];
        text.borderStyle = UITextBorderStyleRoundedRect;
        text.enabled = false;
        [self.view addSubview:text];
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(-4*WIDTH);
            make.bottom.equalTo(self.view).offset(-4 - 3*WIDTH - 3*VOFFSET - 1.5*WIDTH - 2*VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, 1.5*WIDTH));
        }];
        text;
    });
    
    _tile2 = ({
        UITextField *text = [[UITextField alloc] init];
        text.borderStyle = UITextBorderStyleRoundedRect;
        text.enabled = false;
        [self.view addSubview:text];
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view).offset(-4 - 3*WIDTH - 3*VOFFSET - 1.5*WIDTH - 2*VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, 1.5*WIDTH));
        }];
        text;
    });
    
    _tile3 = ({
        UITextField *text = [[UITextField alloc] init];
        text.borderStyle = UITextBorderStyleRoundedRect;
        text.enabled = false;
        [self.view addSubview:text];
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(4*WIDTH);
            make.bottom.equalTo(self.view).offset(-4 - 3*WIDTH - 3*VOFFSET - 1.5*WIDTH - 2*VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, 1.5*WIDTH));
        }];
        text;
    });
    
    _tile4 = ({
        UITextField *text = [[UITextField alloc] init];
        text.borderStyle = UITextBorderStyleRoundedRect;
        text.enabled = false;
        [self.view addSubview:text];
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(-4*WIDTH);
            make.bottom.equalTo(self.view).offset(-4 - 3*WIDTH - 3*VOFFSET - 3*WIDTH - 4*VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, 1.5*WIDTH));
        }];
        text;
    });
    
    _tile5 = ({
        UITextField *text = [[UITextField alloc] init];
        text.borderStyle = UITextBorderStyleRoundedRect;
        text.enabled = false;
        [self.view addSubview:text];
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view).offset(-4 - 3*WIDTH - 3*VOFFSET - 3*WIDTH - 4*VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, 1.5*WIDTH));
        }];
        text;
    });
    
    _tile6 = ({
        UITextField *text = [[UITextField alloc] init];
        text.borderStyle = UITextBorderStyleRoundedRect;
        text.enabled = false;
        [self.view addSubview:text];
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(4*WIDTH);
            make.bottom.equalTo(self.view).offset(-4 - 3*WIDTH - 3*VOFFSET - 3*WIDTH - 4*VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, 1.5*WIDTH));
        }];
        text;
    });
    
    _tile7 = ({
        UITextField *text = [[UITextField alloc] init];
        text.borderStyle = UITextBorderStyleRoundedRect;
        text.enabled = false;
        [self.view addSubview:text];
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(-4*WIDTH);
            make.bottom.equalTo(self.view).offset(-4 - 3*WIDTH - 3*VOFFSET - 4.5*WIDTH - 6*VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, 1.5*WIDTH));
        }];
        text;
    });
    
    _tile8 = ({
        UITextField *text = [[UITextField alloc] init];
        text.borderStyle = UITextBorderStyleRoundedRect;
        text.enabled = false;
        [self.view addSubview:text];
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view).offset(-4 - 3*WIDTH - 3*VOFFSET - 4.5*WIDTH - 6*VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, 1.5*WIDTH));
        }];
        text;
    });
    
    _tile9 = ({
        UITextField *text = [[UITextField alloc] init];
        text.borderStyle = UITextBorderStyleRoundedRect;
        text.enabled = false;
        [self.view addSubview:text];
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(4*WIDTH);
            make.bottom.equalTo(self.view).offset(-4 - 3*WIDTH - 3*VOFFSET - 4.5*WIDTH - 6*VOFFSET);
            make.size.sizeOffset(CGSizeMake(3*WIDTH, 1.5*WIDTH));
        }];
        text;
    });
    
}
-(void)setHelpImageName:(NSString*)name
{
    imageName = name;
}

- (void)numBtnClick:(UIButton *)btn
{
    
}

- (void)recBtnClick:(UIButton *)btn
{
    
}

- (void)doneBtnClick:(UIButton *)btn
{
    
}




@end
