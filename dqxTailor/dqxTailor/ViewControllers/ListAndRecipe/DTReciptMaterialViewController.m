//
//  DTDetailMaterialViewController.m
//  dqxTailor
//
//  Created by HANSHAOWEN on 17/1/6.
//  Copyright © 2017年 HANSHAOWEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTReciptMaterialViewController.h"
#import "DTTableHeaderView.h"
#import "DTDetailMaterialCell.h"
#import "UIImage+Common.h"
#import "View+MASAdditions.h"
#import "DTCalculatorViewController.h"
//Tencent
#import "GDTMobBannerView.h" //导入GDTMobBannerView.h头文件

@interface DTReciptMaterialViewController() <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *btnCal;
//Tencent
@property (strong, nonatomic) GDTMobBannerView *bannerView;//声明一个GDTMobBannerView的实例

@end

@implementation DTReciptMaterialViewController{
    NSArray *sectionTitles;
    NSArray *names;
    NSArray *nums;
    NSArray *rowImageNames;
}

#pragma mark - Lifecycle

- (void)dealloc {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search"]];
     self.navigationItem.titleView = titleView;
     
     [self addNavigationBarLeftSearchItem];
     [self addNavigationBarRightMeItem];
     [self setupViews];
     */
    
    //设置导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
    [self initDatas];
    
    [self setupViews];
    
    //Tencent 2 号广告位
    _bannerView = [[GDTMobBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - GDTMOB_AD_SUGGEST_SIZE_320x50.height, self.view.frame.size.width, GDTMOB_AD_SUGGEST_SIZE_320x50.height) appkey:@"1105884327" placementId:@"8000714867407856"];
    _bannerView.delegate = self; // 设置Delegate
    _bannerView.currentViewController = self; //设置当前的ViewController
    _bannerView.interval = 30; //【可选】设置广告轮播时间;范围为30~120秒,0表示不轮 播
    _bannerView.isGpsOn = NO; //【可选】开启GPS定位;默认关闭
    _bannerView.showCloseBtn = NO; //【可选】展示关闭按钮;默认显示
    _bannerView.isAnimationOn = YES; //【可选】开启banner轮播和展现时的动画效果; 默认开启
    [self.view addSubview:_bannerView]; //添加到当前的view中
    [_bannerView loadAdAndShow];
    [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.view.frame.size.width));
        make.height.equalTo(@50);
        make.bottom.left.equalTo(self.view);
    }];
}
#pragma mark - Private Method

- (void)initDatas {
    /*
     sectionTitles = @[@"史莱姆大剑"];
     names = @[@[@"铜矿石", @"铁矿石", @"秘银矿石", @"瑟银矿石"]];
     nums = @[@[@"11", @"22", @"33", @"9999"]];
     rowImageNames = @[@[@"11", @"22", @"33", @"9999"]];
     */
    //计算材料的数量
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:RECIPT_DETAIL, nil];
    NSString *detail = [dic objectForKey:[[NSString alloc] initWithString:_itemName]];
    NSArray *itemsAndNum = [detail componentsSeparatedByString:@","];
    int itemNum = 0;
    for (NSString* str in itemsAndNum)
    {
        if (![str isEqualToString:@"0"])
        {
            itemNum++;
        }
        else
        {
            break;
        }
    }
    
    //设置武器名称
    sectionTitles = @[_itemName];
    
    //设置每一种材料的名称和数量和图标
    switch (itemNum)
    {
        case 2:
            names = @[@[itemsAndNum[0]]];
            nums = @[@[itemsAndNum[1]]];
            rowImageNames = @[@[[NSString stringWithFormat:@"Icon-%@.png", itemsAndNum[0]]]];
            break;
        case 4:
            names = @[@[itemsAndNum[0], itemsAndNum[2]]];
            nums = @[@[itemsAndNum[1], itemsAndNum[3]]];
            rowImageNames = @[@[[NSString stringWithFormat:@"Icon-%@.png", itemsAndNum[0]], [NSString stringWithFormat:@"Icon-%@.png", itemsAndNum[2]]]];
            break;
        case 6:
            names = @[@[itemsAndNum[0], itemsAndNum[2], itemsAndNum[4]]];
            nums = @[@[itemsAndNum[1], itemsAndNum[3], itemsAndNum[5]]];
            rowImageNames = @[@[[NSString stringWithFormat:@"Icon-%@.png", itemsAndNum[0]], [NSString stringWithFormat:@"Icon-%@.png", itemsAndNum[2]], [NSString stringWithFormat:@"Icon-%@.png", itemsAndNum[4]]]];
            break;
        case 8:
            names = @[@[itemsAndNum[0], itemsAndNum[2], itemsAndNum[4], itemsAndNum[6]]];
            nums = @[@[itemsAndNum[1], itemsAndNum[3], itemsAndNum[5], itemsAndNum[7]]];
            rowImageNames = @[@[[NSString stringWithFormat:@"Icon-%@.png", itemsAndNum[0]], [NSString stringWithFormat:@"Icon-%@.png", itemsAndNum[2]], [NSString stringWithFormat:@"Icon-%@.png", itemsAndNum[4]], [NSString stringWithFormat:@"Icon-%@.png", itemsAndNum[6]]]];
            break;
        case 10:
            names = @[@[itemsAndNum[0], itemsAndNum[2], itemsAndNum[4], itemsAndNum[6], itemsAndNum[8]]];
            nums = @[@[itemsAndNum[1], itemsAndNum[3], itemsAndNum[5], itemsAndNum[7], itemsAndNum[9]]];
            rowImageNames = @[@[[NSString stringWithFormat:@"Icon-%@.png", itemsAndNum[0]], [NSString stringWithFormat:@"Icon-%@.png", itemsAndNum[2]], [NSString stringWithFormat:@"Icon-%@.png", itemsAndNum[4]], [NSString stringWithFormat:@"Icon-%@.png", itemsAndNum[6]], [NSString stringWithFormat:@"Icon-%@.png", itemsAndNum[8]]]];
            break;
        default:
            break;
    }
}

- (void)setupViews {
    //_headerView = [[MLBUserHomeHeaderView alloc] initWithUserType:MLBUserTypeMe];
    //[_headerView configureHeaderViewForTestMe];
    
    _tableView.dataSource = self;
    _tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.backgroundColor = DViewControllerBGColor;
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[DTDetailMaterialCell class] forCellReuseIdentifier:kDTDetailMaterialCellID];
        [tableView registerClass:[DTTableHeaderView class] forHeaderFooterViewReuseIdentifier:kDTTableHeaderViewID];
        tableView.rowHeight = [DTDetailMaterialCell cellHeight];
        
        
        /*
         UIImageView *headerImageView = [[UIImageView alloc] initWithImage:[UIImage mlb_imageWithName:@"personalBackgroundImage" cached:NO]];
         headerImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 206);
         headerImageView.contentMode = UIViewContentModeScaleAspectFill;
         ParallaxHeaderView *parallaxHeaderView = [ParallaxHeaderView parallaxHeaderViewWithSubView:headerImageView];
         
         UIImageView *shadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"movie_shadow"]];
         [parallaxHeaderView addSubview:shadowView];
         [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.height.equalTo(@50);
         make.left.bottom.right.equalTo(parallaxHeaderView);
         }];
         
         [parallaxHeaderView addSubview:_headerView];
         [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.height.equalTo(@([_headerView viewHeight]));
         make.left.bottom.right.equalTo(parallaxHeaderView);
         }];
         
         tableView.tableHeaderView = parallaxHeaderView;
         */
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        tableView;
    });
    
    _btnCal = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.titleLabel.font = [UIFont systemFontOfSize: 20];
        [btn setTitle:@"裁缝计算器" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"nbtn_normal"] forState:(UIControlStateNormal)];
        [btn setBackgroundImage:[UIImage imageNamed:@"nbtn_hover"] forState:(UIControlStateSelected)];
        [btn setBackgroundImage:[UIImage imageNamed:@"nbtn_active"] forState:(UIControlStateFocused)];
        [btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor]forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor]forState:UIControlStateFocused];
        [btn setTitleColor:[UIColor grayColor]forState:UIControlStateDisabled];
        [btn addTarget:self action:@selector(calBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(0);
            make.bottom.equalTo(self.view).offset(-150);
            make.size.sizeOffset(CGSizeMake(200, 50));
        }];
        btn;
    });
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //[(ParallaxHeaderView *)_tableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
}

#pragma mark - UITableViewDataSource
//Table的section数目
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//制定section中的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rows = names[section];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DTDetailMaterialCell *cell = [tableView dequeueReusableCellWithIdentifier:kDTDetailMaterialCellID forIndexPath:indexPath];
    [cell set:names[indexPath.section][indexPath.row] iconName:rowImageNames[indexPath.section][indexPath.row] neceNum:nums[indexPath.section][indexPath.row]];
    
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [DTTableHeaderView viewHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DTTableHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kDTTableHeaderViewID];
    view.titleLabel.text = sectionTitles[section];
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    return;
}

- (void)calBtnClick:(UIButton *)btn
{
    DTCalculatorViewController *materialController = [[DTCalculatorViewController alloc] init];
    [materialController setEquipName:_itemName];
    [self.navigationController pushViewController:materialController animated:YES];
}
@end
