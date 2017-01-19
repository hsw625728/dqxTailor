//
//  DTTailorCalculatorViewController.m
//  dqxTailor
//
//  Created by HANSHAOWEN on 17/1/6.
//  Copyright © 2017年 HANSHAOWEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTTailorCalculatorViewController.h"
#import "DTTableCell.h"
#import "DTTableHeaderView.h"
#import "UIImage+Common.h"
//#import "DRRecipeSearchItem.h"
#import "View+MASAdditions.h"
#import "DTCalculatorViewController.h"
//Tencent
#import "GDTMobBannerView.h" //导入GDTMobBannerView.h头文件

@interface DTTailorCalculatorViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UIImageView *hintView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
//Tencent
@property (strong, nonatomic) GDTMobBannerView *bannerView;//声明一个GDTMobBannerView的实例

@end

@implementation DTTailorCalculatorViewController{
    NSMutableArray *dataSource;
    NSArray *rowTitles;
    NSArray *rowImageNames;
}

#pragma mark - Lifecycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initDatas];
    [self setupViews];
    
    //Tencent 4 号广告位
    _bannerView = [[GDTMobBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - GDTMOB_AD_SUGGEST_SIZE_320x50.height, self.view.frame.size.width, GDTMOB_AD_SUGGEST_SIZE_320x50.height) appkey:@"1105884327" placementId:@"9090715827707877"];
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_searchBar becomeFirstResponder];
}

#pragma mark - Private Method

- (void)initDatas {
    dataSource = [NSMutableArray arrayWithCapacity:4];
    
    rowTitles = RECIPT_SECTION5_1_SUB;
    rowImageNames = RECIPT_SECTION5_1_SUB_IMAGE;
}

- (void)setupViews {
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(searching)];
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.placeholder = @"输入关键字(例如：贤者)";
    _searchBar.tintColor = DRLightGrayTextColor;
    _searchBar.returnKeyType = UIReturnKeySearch;
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.delegate = self;
    self.navigationItem.titleView = _searchBar;
    
    _tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[DTTableCell class] forCellReuseIdentifier:kDTTableCellID];
        tableView.tableFooterView = [UIView new];
        //tableView.emptyDataSetSource = self;
        [self.view addSubview:tableView];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.left.bottom.right.equalTo(self.view);
        }];
        
        tableView;
    });
    _tableView.hidden = YES;
    
    _hintView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_all"]];
        imageView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.sizeOffset(CGSizeMake(165, 110));
            make.top.equalTo(self.view).offset(114);
            make.centerX.equalTo(self.view);
        }];
        
        imageView;
    });
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.hidesWhenStopped = YES;
    [self.view addSubview:_activityIndicatorView];
    [_activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

#pragma mark - Public Method



#pragma mark - Action

- (void)cancel {
    [_searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Network Request

- (void)searching {
    [_activityIndicatorView startAnimating];
    [dataSource removeAllObjects];
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:RECIPT_DETAIL, nil];
    for (NSString *key in dic)
    {
        if ([key containsString:_searchBar.text])
        {
            [dataSource addObject:key];
        }
    }
    
    //_segmentedControl.hidden = NO;
    _tableView.hidden = NO;
    _hintView.hidden = YES;
    
    [_tableView reloadData];
    [_activityIndicatorView stopAnimating];
    
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_searchBar resignFirstResponder];
    [self searching];
}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"search_null_image"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DTTableCell *cell1 = [tableView dequeueReusableCellWithIdentifier:kDTTableCellID forIndexPath:indexPath];
    [cell1 configureCellWithTitle:dataSource[indexPath.row] imageName:[NSString stringWithFormat:@"Icon-%@", dataSource[indexPath.row]] atIndexPath:indexPath];
    
    return cell1;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [DTTableCell cellHeight];
    //return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DTCalculatorViewController *materialController = [[DTCalculatorViewController alloc] init];
    [materialController setEquipName:dataSource[indexPath.row]];
    [self.navigationController pushViewController:materialController animated:YES];
}

@end
