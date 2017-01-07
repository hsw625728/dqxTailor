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

@property (strong, nonatomic) NSMutableArray *tiles;
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
    [self initData];
    [self setupViews];
}

#pragma mark - Private Method

#define BTN_NUMBER_SETTING(a,b,c,d) a = ({\
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];\
    btn.titleLabel.font = [UIFont systemFontOfSize: 20];\
    [btn setTitle:b forState:UIControlStateNormal];\
    [btn setBackgroundImage:[UIImage imageNamed:@"nbtn_normal"] forState:(UIControlStateNormal)];\
    [btn setBackgroundImage:[UIImage imageNamed:@"nbtn_hover"] forState:(UIControlStateSelected)];\
    [btn setBackgroundImage:[UIImage imageNamed:@"nbtn_active"] forState:(UIControlStateFocused)];\
    [btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];\
    [btn setTitleColor:[UIColor blackColor]forState:UIControlStateSelected];\
    [btn setTitleColor:[UIColor blackColor]forState:UIControlStateFocused];\
    [btn setTitleColor:[UIColor grayColor]forState:UIControlStateDisabled];\
    [btn addTarget:self action:@selector(recBtnClick:) forControlEvents:UIControlEventTouchUpInside];\
    [self.view addSubview:btn];\
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {\
        make.centerX.equalTo(self.view.mas_centerX).offset(c);\
        make.bottom.equalTo(self.view).offset(d);\
    make.size.sizeOffset(CGSizeMake(3*WIDTH, 1.5*WIDTH));\
    }];\
    btn;\
})

#define TILE_SETTING(a,b,c,d) a = ({\
    UITextField *text = [[UITextField alloc] init];\
    text.borderStyle = UITextBorderStyleNone;\
    text.tag = b;\
    text.enabled = true;\
    text.delegate = self;\
    text.background = [UIImage imageNamed:@"tiles_normal"];\
    [self.view addSubview:text];\
    [text mas_makeConstraints:^(MASConstraintMaker *make) {\
        make.centerX.equalTo(self.view.mas_centerX).offset(c);\
        make.bottom.equalTo(self.view).offset(d);\
        make.size.sizeOffset(CGSizeMake(3*WIDTH, 1.5*WIDTH));\
    }];\
    text;\
})

- (void)setupViews {
    CGFloat contentViewWidth = CGRectGetWidth([UIScreen mainScreen ].applicationFrame);
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    const float WIDTH = contentViewWidth/12;
    const float VOFFSET = WIDTH/10;
    
    BTN_NUMBER_SETTING(_btnRecover, @"+", -3.7*WIDTH, -4);
    BTN_NUMBER_SETTING(_btnNumber0, @"0", 0, -4);
    BTN_NUMBER_SETTING(_btnDone, @"确  定", 3.7*WIDTH, -4);
    BTN_NUMBER_SETTING(_btnNumber1, @"1", -3.7*WIDTH, -4 - 1.5*WIDTH - VOFFSET);
    BTN_NUMBER_SETTING(_btnNumber2, @"2", 0, -4 - 1.5*WIDTH - VOFFSET);
    BTN_NUMBER_SETTING(_btnNumber3, @"3", 3.7*WIDTH, -4 - 1.5*WIDTH - VOFFSET);
    BTN_NUMBER_SETTING(_btnNumber4, @"4", -3.7*WIDTH, -4 - 3*WIDTH - 2*VOFFSET);
    BTN_NUMBER_SETTING(_btnNumber5, @"5", 0, -4 - 3*WIDTH - 2*VOFFSET);
    BTN_NUMBER_SETTING(_btnNumber6, @"6", 3.7*WIDTH, -4 - 3*WIDTH - 2*VOFFSET);
    BTN_NUMBER_SETTING(_btnNumber7, @"7", -3.7*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET);
    BTN_NUMBER_SETTING(_btnNumber8, @"8", 0, -4 - 4.5*WIDTH - 3*VOFFSET);
    BTN_NUMBER_SETTING(_btnNumber9, @"9", 3.7*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET);
    
    TILE_SETTING(_tiles[0], 0, -4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 1.5*WIDTH - 2*VOFFSET);
    TILE_SETTING(_tiles[1], 1, 0, -4 - 4.5*WIDTH - 3*VOFFSET - 1.5*WIDTH - 2*VOFFSET);
    TILE_SETTING(_tiles[2], 2, 4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 1.5*WIDTH - 2*VOFFSET);
    TILE_SETTING(_tiles[3], 3, -4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 3*WIDTH - 4*VOFFSET);
    TILE_SETTING(_tiles[4], 4, 0, -4 - 4.5*WIDTH - 3*VOFFSET - 3*WIDTH - 4*VOFFSET);
    TILE_SETTING(_tiles[5], 5, 4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 3*WIDTH - 4*VOFFSET);
    TILE_SETTING(_tiles[6], 6, -4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 4.5*WIDTH - 6*VOFFSET);
    TILE_SETTING(_tiles[7], 7, 0, -4 - 4.5*WIDTH - 3*VOFFSET - 4.5*WIDTH - 6*VOFFSET);
    TILE_SETTING(_tiles[8], 8, 4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 4.5*WIDTH - 6*VOFFSET);
    
}

- (void)initData{
    _tiles = [[NSMutableArray alloc] initWithCapacity:9];
    for (int i = 0; i < 9; i++){
        UITextField* tile = [[UITextField alloc] init];
        [_tiles addObject:tile];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    for (UITextField *t in _tiles){
        t.background = [UIImage imageNamed:@"tiles_normal"];
    }
    textField.background = [UIImage imageNamed:@"tiles_focus"];
    return NO;
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
