//
//  MF_RealTimeViewController.m
//  MFSearchControllerExample
//
//  Created by MF on 2017/9/18.
//  Copyright © 2017年 MF. All rights reserved.
//

#import "MF_RealTimeSearchViewController.h"

#import "MFSearchController.h"
#import "MFSearchResultViewController.h"

@interface MF_RealTimeSearchViewController ()<UITableViewDataSource, UITableViewDelegate, MFSearchResultViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MFSearchController *searchVC;

@property (nonatomic, strong) NSMutableArray *searchResultArray;



@end

@implementation MF_RealTimeSearchViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.searchResultArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"实时搜索";
    self.view.backgroundColor = [UIColor grayColor];
    self.definesPresentationContext = YES;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
    MFSearchResultViewController *seachResultVC = [[MFSearchResultViewController alloc] init];
    seachResultVC.delegate = self;
    __weak __typeof(&*self)weakSelf = self;
    self.searchVC = [[MFSearchController alloc] initWithSearchResultsController:seachResultVC completion:^(MFSearchController *vc, NSInteger type, NSString *searchText) {
        NSLog(@"type = %ld, text = %@", type, searchText);
        [vc dismissInViewController:weakSelf animated:YES completion:nil];
    }];
    [self.searchVC fixDisplayBugInViewController:self];
    self.tableView.tableHeaderView = self.searchVC.searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ========== UITableViewDataSource && UITableViewDelegate ==========

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试案例%ld", indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

#pragma mark ========== MFSearchResultViewControllerDelegate ==========

- (void)updateSearchResultWithKeyWords:(NSString *)keyWords
{
    [self.searchResultArray removeAllObjects];
    for (int i = 0; i < 115; i++) {
        NSString *str = [NSString stringWithFormat:@"%@ %d", keyWords, i];
        [self.searchResultArray addObject:str];
    }
}


- (UITableViewCell *)mf_searchTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row < self.searchResultArray.count) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.searchResultArray[indexPath.row]];
    }
    return cell;
}

- (NSInteger)mf_searchTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResultArray.count;
}

@end
