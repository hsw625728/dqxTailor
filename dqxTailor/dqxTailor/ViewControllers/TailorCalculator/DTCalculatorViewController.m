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
@property (strong, nonatomic) NSMutableArray *cutpoints;
//10个状态循环条
@property (strong, nonatomic) NSMutableArray *states;
@property (nonatomic, assign) NSInteger activeTileIndex;
//5种力道的数值
@property (strong, nonatomic) NSDictionary *stateValues;
@property (strong, nonatomic) UILabel *stateValueLabel;
//当前误差值
@property (strong, nonatomic) UILabel *resultValueLabel;


@end

@implementation DTCalculatorViewController{
    NSString *equipName;
    DTGlobalTailorInfo *info;
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

#define BTN_NUMBER_SETTING(a,b,c,d,e) a = ({\
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
    [btn addTarget:self action:@selector(c:) forControlEvents:UIControlEventTouchUpInside];\
    [self.view addSubview:btn];\
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {\
        make.centerX.equalTo(self.view.mas_centerX).offset(d);\
        make.bottom.equalTo(self.view).offset(e);\
    make.size.sizeOffset(CGSizeMake(3*WIDTH, 1.5*WIDTH));\
    }];\
    btn;\
})

#define STATES_SETTING(a,b,c,d,e) a = ({\
UITextField *te = [[UITextField alloc] init];\
te.borderStyle = UITextBorderStyleNone;\
te.font = FontWithSize(12);\
te.tag = b;\
te.text = c;\
te.textAlignment=UITextAlignmentCenter;\
te.enabled = true;\
te.delegate = self;\
te.background = [UIImage imageNamed:@"Button_normal"];\
[self.view addSubview:te];\
[te mas_makeConstraints:^(MASConstraintMaker *make) {\
make.centerX.equalTo(self.view.mas_centerX).offset(d);\
make.bottom.equalTo(self.view).offset(e);\
make.size.sizeOffset(CGSizeMake(1.25*WIDTH, WIDTH));\
}];\
te;\
})

#define TILE_SETTING(a,b,c,d) a = ({\
    UITextField *text = [[UITextField alloc] init];\
    text.borderStyle = UITextBorderStyleNone;\
    text.tag = b;\
    text.textAlignment=UITextAlignmentCenter;\
    text.enabled = true;\
    text.delegate = self;\
    text.background = [UIImage imageNamed:@"Button_normal"];\
    [self.view addSubview:text];\
    [text mas_makeConstraints:^(MASConstraintMaker *make) {\
        make.centerX.equalTo(self.view.mas_centerX).offset(c);\
        make.bottom.equalTo(self.view).offset(d);\
        make.size.sizeOffset(CGSizeMake(3*WIDTH, 1.5*WIDTH));\
    }];\
    text;\
})

#define TILE_LABEL(a,b) a = ({\
    UILabel *label = [UILabel new];\
    label.font = FontWithSize(12);\
    label.text = @"";\
    label.textAlignment = NSTextAlignmentCenter;\
    label.textColor = DLightBlackTextColor;\
    [(UITextField*)b addSubview:label];\
    [label mas_makeConstraints:^(MASConstraintMaker *make) {\
        make.top.right.equalTo((UITextField*)b).offset(0);\
    }];\
    label;\
})

- (void)initData{
    _activeTileIndex = -1;
    _tiles = [[NSMutableArray alloc] initWithCapacity:9];
    _cutpoints = [[NSMutableArray alloc] initWithCapacity:9];
    _stateValues = [[NSDictionary alloc] initWithObjectsAndKeys:WEAK_VALUES, @"弱",NORMAL_VALUES, @"普通", STRONG_VALUES, @"强", MAX_VALUES, @"最强", nil];
    
    for (int i = 0; i < 9; i++){
        UITextField* tile = [[UITextField alloc] init];
        tile.text = @"";
        [_tiles addObject:tile];
        
        UILabel* label = [[UILabel alloc] init];
        label.text = @"";
        [_cutpoints addObject:label];
    }
    
    _states = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < 10; i++){
        UIButton *btn = [[UIButton alloc] init];
        [_states addObject:btn];
    }
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    info = [appDelegate.gTailorInfo objectForKey:equipName];
}

- (void)setupViews {
    CGFloat contentViewWidth = CGRectGetWidth([UIScreen mainScreen ].applicationFrame);
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];
    const float WIDTH = contentViewWidth/12;
    const float VOFFSET = WIDTH/10;
    
    BTN_NUMBER_SETTING(_btnRecover, @"-", recBtnClick, -3.7*WIDTH, -4);
    BTN_NUMBER_SETTING(_btnNumber0, @"0", numBtnClick, 0, -4);
    BTN_NUMBER_SETTING(_btnDone, @"确  定", doneBtnClick, 3.7*WIDTH, -4);
    BTN_NUMBER_SETTING(_btnNumber1, @"1", numBtnClick, -3.7*WIDTH, -4 - 1.5*WIDTH - VOFFSET);
    BTN_NUMBER_SETTING(_btnNumber2, @"2", numBtnClick, 0, -4 - 1.5*WIDTH - VOFFSET);
    BTN_NUMBER_SETTING(_btnNumber3, @"3", numBtnClick, 3.7*WIDTH, -4 - 1.5*WIDTH - VOFFSET);
    BTN_NUMBER_SETTING(_btnNumber4, @"4", numBtnClick, -3.7*WIDTH, -4 - 3*WIDTH - 2*VOFFSET);
    BTN_NUMBER_SETTING(_btnNumber5, @"5", numBtnClick, 0, -4 - 3*WIDTH - 2*VOFFSET);
    BTN_NUMBER_SETTING(_btnNumber6, @"6", numBtnClick, 3.7*WIDTH, -4 - 3*WIDTH - 2*VOFFSET);
    BTN_NUMBER_SETTING(_btnNumber7, @"7", numBtnClick, -3.7*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET);
    BTN_NUMBER_SETTING(_btnNumber8, @"8", numBtnClick, 0, -4 - 4.5*WIDTH - 3*VOFFSET);
    BTN_NUMBER_SETTING(_btnNumber9, @"9", numBtnClick, 3.7*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET);
    
    //加号减号字号单独设置大一些
    _btnRecover.titleLabel.font = [UIFont systemFontOfSize: 40];
    
#define STATE_Y_POINT (-4 - 4.5*WIDTH - 3*VOFFSET - 6*WIDTH - 8*VOFFSET)
    STATES_SETTING(_states[0], 10, info.patterns[0], -5.4*WIDTH, STATE_Y_POINT);
    STATES_SETTING(_states[1], 11, info.patterns[1], -4.2*WIDTH, STATE_Y_POINT);
    STATES_SETTING(_states[2], 12, info.patterns[2], -3.0*WIDTH, STATE_Y_POINT);
    STATES_SETTING(_states[3], 13, info.patterns[3], -1.8*WIDTH, STATE_Y_POINT);
    STATES_SETTING(_states[4], 14, info.patterns[4], -0.6*WIDTH, STATE_Y_POINT);
    STATES_SETTING(_states[5], 15, info.patterns[5], 0.6*WIDTH, STATE_Y_POINT);
    STATES_SETTING(_states[6], 16, info.patterns[6], 1.8*WIDTH, STATE_Y_POINT);
    STATES_SETTING(_states[7], 17, info.patterns[7], 3.0*WIDTH, STATE_Y_POINT);
    STATES_SETTING(_states[8], 18, info.patterns[8], 4.2*WIDTH, STATE_Y_POINT);
    STATES_SETTING(_states[9], 19, info.patterns[9], 5.4*WIDTH, STATE_Y_POINT);
    
    /*
    TILE_SETTING(_tiles[0], 6, -4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 4.5*WIDTH - 6*VOFFSET);
    TILE_SETTING(_tiles[1], 7, 0, -4 - 4.5*WIDTH - 3*VOFFSET - 4.5*WIDTH - 6*VOFFSET);
    TILE_SETTING(_tiles[2], 8, 4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 4.5*WIDTH - 6*VOFFSET);
    TILE_SETTING(_tiles[3], 3, -4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 3*WIDTH - 4*VOFFSET);
    TILE_SETTING(_tiles[4], 4, 0, -4 - 4.5*WIDTH - 3*VOFFSET - 3*WIDTH - 4*VOFFSET);
    TILE_SETTING(_tiles[5], 5, 4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 3*WIDTH - 4*VOFFSET);
    TILE_SETTING(_tiles[6], 0, -4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 1.5*WIDTH - 2*VOFFSET);
    TILE_SETTING(_tiles[7], 1, 0, -4 - 4.5*WIDTH - 3*VOFFSET - 1.5*WIDTH - 2*VOFFSET);
    TILE_SETTING(_tiles[8], 2, 4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 1.5*WIDTH - 2*VOFFSET);
    */
    TILE_SETTING(_tiles[0], 0, -4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 4.5*WIDTH - 6*VOFFSET);
    TILE_SETTING(_tiles[1], 1, 0, -4 - 4.5*WIDTH - 3*VOFFSET - 4.5*WIDTH - 6*VOFFSET);
    TILE_SETTING(_tiles[2], 2, 4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 4.5*WIDTH - 6*VOFFSET);
    TILE_SETTING(_tiles[3], 3, -4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 3*WIDTH - 4*VOFFSET);
    TILE_SETTING(_tiles[4], 4, 0, -4 - 4.5*WIDTH - 3*VOFFSET - 3*WIDTH - 4*VOFFSET);
    TILE_SETTING(_tiles[5], 5, 4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 3*WIDTH - 4*VOFFSET);
    TILE_SETTING(_tiles[6], 6, -4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 1.5*WIDTH - 2*VOFFSET);
    TILE_SETTING(_tiles[7], 7, 0, -4 - 4.5*WIDTH - 3*VOFFSET - 1.5*WIDTH - 2*VOFFSET);
    TILE_SETTING(_tiles[8], 8, 4*WIDTH, -4 - 4.5*WIDTH - 3*VOFFSET - 1.5*WIDTH - 2*VOFFSET);
    
    TILE_LABEL(_cutpoints[0], _tiles[0]);
    TILE_LABEL(_cutpoints[1], _tiles[1]);
    TILE_LABEL(_cutpoints[2], _tiles[2]);
    TILE_LABEL(_cutpoints[3], _tiles[3]);
    TILE_LABEL(_cutpoints[4], _tiles[4]);
    TILE_LABEL(_cutpoints[5], _tiles[5]);
    TILE_LABEL(_cutpoints[6], _tiles[6]);
    TILE_LABEL(_cutpoints[7], _tiles[7]);
    TILE_LABEL(_cutpoints[8], _tiles[8]);

    _stateValueLabel = ({
        UILabel *label = [UILabel new];
        //label.backgroundColor = [UIColor whiteColor];
        label.font = FontWithSize(12);
        label.textColor = DLightBlackTextColor;
        label.numberOfLines = 5;
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.left.equalTo(self.view).offset(0);
        }];
        
        label;
    });
    
    _resultValueLabel = ({
        UILabel *label = [UILabel new];
        //label.backgroundColor = [UIColor whiteColor];
        label.font = FontWithSize(12);
        label.textColor = DLightBlackTextColor;
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_states[0]).offset(-20);
            make.left.equalTo(_states[0]).offset(0);
        }];
        
        label;
    });
    
    switch (info.type) {
        case 0:
            ((UITextField*)_tiles[1]).text = info.zones[0];
            ((UITextField*)_tiles[3]).text = info.zones[1];
            ((UITextField*)_tiles[4]).text = info.zones[2];
            ((UITextField*)_tiles[5]).text = info.zones[3];
        break;
        case 1:
            ((UITextField*)_tiles[0]).text = info.zones[0];
            ((UITextField*)_tiles[1]).text = info.zones[1];
            ((UITextField*)_tiles[2]).text = info.zones[2];
            ((UITextField*)_tiles[3]).text = info.zones[3];
            ((UITextField*)_tiles[4]).text = info.zones[4];
            ((UITextField*)_tiles[5]).text = info.zones[5];
            ((UITextField*)_tiles[6]).text = info.zones[6];
            ((UITextField*)_tiles[7]).text = info.zones[7];
            ((UITextField*)_tiles[8]).text = info.zones[8];
            break;
        case 2:
            ((UITextField*)_tiles[0]).text = info.zones[0];
            ((UITextField*)_tiles[1]).text = info.zones[1];
            ((UITextField*)_tiles[3]).text = info.zones[2];
            ((UITextField*)_tiles[4]).text = info.zones[3];
            ((UITextField*)_tiles[6]).text = info.zones[4];
            ((UITextField*)_tiles[7]).text = info.zones[5];
            break;
        case 3:
            ((UITextField*)_tiles[0]).text = info.zones[0];
            ((UITextField*)_tiles[1]).text = info.zones[1];
            ((UITextField*)_tiles[2]).text = info.zones[2];
            ((UITextField*)_tiles[3]).text = info.zones[3];
            ((UITextField*)_tiles[4]).text = info.zones[4];
            ((UITextField*)_tiles[5]).text = info.zones[5];
            break;
        case 4:
            ((UITextField*)_tiles[0]).text = info.zones[0];
            ((UITextField*)_tiles[1]).text = info.zones[1];
            ((UITextField*)_tiles[3]).text = info.zones[2];
            ((UITextField*)_tiles[4]).text = info.zones[3];
            break;
        case 5:
            ((UITextField*)_tiles[0]).text = info.zones[0];
            ((UITextField*)_tiles[1]).text = info.zones[1];
            ((UITextField*)_tiles[2]).text = info.zones[2];
            ((UITextField*)_tiles[3]).text = info.zones[3];
            ((UITextField*)_tiles[4]).text = info.zones[4];
            ((UITextField*)_tiles[5]).text = info.zones[5];
            break;
        default:
            break;
    }
    //初始默认选中第一项
    [self textFieldShouldBeginEditing:_states[0]];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag >= 0 && textField.tag <= 9){
        for (UITextField *t in _tiles){
            t.background = [UIImage imageNamed:@"Button_normal"];
        }
        
        if (![textField.text isEqualToString:@""]){
            textField.background = [UIImage imageNamed:@"Button_select"];
            [self enableAllBtn];
            _activeTileIndex = textField.tag;
            //如果设置了数值就要同步设置加减号按钮
            NSString* lstr = ((UILabel*)(_cutpoints[_activeTileIndex])).text;
            if ([lstr rangeOfString:@"+"].location != NSNotFound){
                //有减号
                [_btnRecover setTitle:@"+" forState:(UIControlStateNormal)];
            }else{
                [_btnRecover setTitle:@"-" forState:(UIControlStateNormal)];
            }
        }else{
            [self disableAllBtn];
            _activeTileIndex = -1;
        }
    }
    else if (textField.tag > 9){
        for (UITextField *t in _states){
            t.background = [UIImage imageNamed:@"Button_normal"];
        }
        textField.background = [UIImage imageNamed:@"Button_select"];
        NSString *eqName = textField.text;
        NSString *desc = [_stateValues objectForKey:eqName];
        _stateValueLabel.text = desc;
    }
    return NO;
}

- (void) setEquipName:(NSString*)name;
{
    equipName = name;
}

- (void)numBtnClick:(UIButton *)btn
{
    if (_activeTileIndex != -1){
        NSString *cur = ((UILabel*)(_cutpoints[_activeTileIndex])).text;
        if (cur.length < 4){
            cur = [cur stringByAppendingString:btn.titleLabel.text];
            
            //删除符号
            cur = [cur stringByReplacingOccurrencesOfString:@"-" withString:@""];
            cur = [cur stringByReplacingOccurrencesOfString:@"+" withString:@""];
            
            if([self isAddSelected]){
                //减号
                NSString* temp = [[NSString alloc] init];
                temp = @"-";
                cur = [temp stringByAppendingString:cur];
            }else{
                //加号
                NSString* temp = [[NSString alloc] init];
                temp = @"+";
                cur = [temp stringByAppendingString:cur];
            }
            ((UILabel*)(_cutpoints[_activeTileIndex])).text = cur;
        }
    }
}

- (void)recBtnClick:(UIButton *)btn
{
    
    if (_activeTileIndex != -1){
        NSString *cur = ((UILabel*)(_cutpoints[_activeTileIndex])).text;
        cur = [cur stringByReplacingOccurrencesOfString:@"-" withString:@""];
        cur = [cur stringByReplacingOccurrencesOfString:@"+" withString:@""];
        ((UILabel*)(_cutpoints[_activeTileIndex])).text = cur;
    }
    
    if (![self isAddSelected]){
        //减号变加号
        [btn setTitle:@"-" forState:(UIControlStateNormal)];
        if (_activeTileIndex != -1){
            NSString *cur = ((UILabel*)(_cutpoints[_activeTileIndex])).text;
            if (cur.length < 4){
                NSString* temp = [[NSString alloc] init];
                temp = @"-";
                cur = [temp stringByAppendingString:cur];
                ((UILabel*)(_cutpoints[_activeTileIndex])).text = cur;
            }
        }
    }else{
        //加号变减号
        [btn setTitle:@"+" forState:(UIControlStateNormal)];
        if (_activeTileIndex != -1){
            NSString *cur = ((UILabel*)(_cutpoints[_activeTileIndex])).text;
            if (cur.length < 4){
                NSString* temp = [[NSString alloc] init];
                temp = @"+";
                cur = [temp stringByAppendingString:cur];
                ((UILabel*)(_cutpoints[_activeTileIndex])).text = cur;
            }
        }
    }
}

- (void)doneBtnClick:(UIButton *)btn
{
    int result = 0;
    
    for (int i = 0; i < 9; i++){
        NSString *tileStr = ((UITextField*)(_tiles[i])).text;
        NSString *cutStr = ((UILabel*)(_cutpoints[i])).text;
        if (![tileStr isEqualToString:@""] && ![cutStr isEqualToString:@""]){
            tileStr = [NSString stringWithFormat:@"%i", tileStr.intValue + cutStr.intValue];
            ((UITextField*)(_tiles[i])).text = tileStr;
            ((UILabel*)(_cutpoints[i])).text = @"";
            
        }
        
        //删除符号计算误差
        tileStr = [tileStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        tileStr = [tileStr stringByReplacingOccurrencesOfString:@"+" withString:@""];
        result += tileStr.intValue;
    }
    _resultValueLabel.text = [NSString stringWithFormat:@"当前误差：%i (大成功条件：头<=2 下装<=4 上装<=8)", result];
}

-(void)enableAllBtn{
    _btnNumber0.enabled = YES;
    _btnNumber1.enabled = YES;
    _btnNumber2.enabled = YES;
    _btnNumber3.enabled = YES;
    _btnNumber4.enabled = YES;
    _btnNumber5.enabled = YES;
    _btnNumber6.enabled = YES;
    _btnNumber7.enabled = YES;
    _btnNumber8.enabled = YES;
    _btnNumber9.enabled = YES;
    _btnDone.enabled = YES;
    _btnRecover.enabled = YES;
}

-(void)disableAllBtn{
    _btnNumber0.enabled = NO;
    _btnNumber1.enabled = NO;
    _btnNumber2.enabled = NO;
    _btnNumber3.enabled = NO;
    _btnNumber4.enabled = NO;
    _btnNumber5.enabled = NO;
    _btnNumber6.enabled = NO;
    _btnNumber7.enabled = NO;
    _btnNumber8.enabled = NO;
    _btnNumber9.enabled = NO;
    _btnDone.enabled = NO;
    _btnRecover.enabled = NO;
}

-(BOOL)isAddSelected{
    if (![_btnRecover.titleLabel.text isEqualToString:@"-"]){
        //减号
        return NO;
    }else{
        return YES;
    }
}
@end
