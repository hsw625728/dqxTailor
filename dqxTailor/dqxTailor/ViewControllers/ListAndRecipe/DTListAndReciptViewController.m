//
//  DTListAndReciptViewController.m
//  dqxTailor
//
//  Created by HANSHAOWEN on 17/1/6.
//  Copyright © 2017年 HANSHAOWEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTListAndReciptViewController.h"
#import "UIImage+Common.h"
#import "DTTableCell.h"
#import "DTTableHeaderView.h"
#import "View+MASAdditions.h"
#import "DTReciptMaterialViewController.h"

@interface DTListAndReciptViewController() <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation DTListAndReciptViewController{
    NSArray *sectionTitles;
    NSArray *rowTitles;
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
    
    //self.navigationItem.title = @"";
    
    //[self addNavigationBarLeftSearchItem];
    [self setupViews];
    
    //导航栏设置
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self initDatas];
    [self setupViews];
    self.navigationItem.title = _viewTitleStr;
}
#pragma mark - Private Method

- (void)initDatas {
    _viewTitleStr = @"套装配方列表";
    sectionTitles = RECIPT_SECTION5_1;
    rowTitles = RECIPT_SECTION5_1_SUB;
    rowImageNames = RECIPT_SECTION5_1_SUB_IMAGE;
}

- (void)setupViews {
    
    _tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.backgroundColor = DViewControllerBGColor;
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[DTTableCell class] forCellReuseIdentifier:kDTTableCellID];
        [tableView registerClass:[DTTableHeaderView class] forHeaderFooterViewReuseIdentifier:kDTTableHeaderViewID];
        tableView.rowHeight = [DTTableCell cellHeight];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        tableView;
    });
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //[(ParallaxHeaderView *)_tableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rows = rowTitles[section];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DTTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kDTTableCellID forIndexPath:indexPath];
    [cell configureCellWithTitle:rowTitles[indexPath.section][indexPath.row] imageName:rowImageNames[indexPath.section][indexPath.row] atIndexPath:indexPath];
    
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
    
    DTReciptMaterialViewController *materialController = [[DTReciptMaterialViewController alloc] init];
    [materialController setItemName:rowTitles[indexPath.section][indexPath.row]];
    [self.navigationController pushViewController:materialController animated:YES];
    
    
    NSMutableArray *history;
    NSString *docPath =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docPath stringByAppendingPathComponent:@"RecipeHistory"];
    
    history = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (ISNULL(history))
        history = [[NSMutableArray alloc] init];
    
    [history addObject:rowTitles[indexPath.section][indexPath.row]];
    if (history.count > 60)
        [history removeObjectAtIndex:0];
    
    [NSKeyedArchiver archiveRootObject:history toFile:path];
}

@end
