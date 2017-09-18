//
//  MFSearchResultViewController.m
//  MFSearchControllerExample
//
//  Created by MF on 2017/9/18.
//  Copyright © 2017年 MF. All rights reserved.
//

#import "MFSearchResultViewController.h"

static NSString *mf_headerView_identifier = @"mf_header_view";
static NSString *mf_footerView_identifier = @"mf_footer_view";

@interface MFSearchResultViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, readwrite) UITableView *tableView;

@end

@implementation MFSearchResultViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //do nothing
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (void)dealloc
{
    NSLog(@"MFSearchResultViewController dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ========== setter && getter ==========

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.tableHeaderView = [[UIView alloc] init];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:mf_headerView_identifier];
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:mf_footerView_identifier];
    }
    return _tableView;
}

#pragma mark ========== UISearchResultsUpdating ==========

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{    
    if (self.delegate) {
        [self.delegate updateSearchResultWithKeyWords:searchController.searchBar.text];
    }
    [self.tableView reloadData];
}

#pragma mark ========== UITableViewDataSource ==========

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mf_searchTableView:numberOfRowsInSection:)]) {
        return [self.delegate mf_searchTableView:tableView numberOfRowsInSection:section];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(mf_searchTableView:cellForRowAtIndexPath:)]) {
        cell = [self.delegate mf_searchTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mf_searchTableViewTotalSectionCount:)]) {
        return [self.delegate mf_searchTableViewTotalSectionCount:tableView];
    }
    return 1;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mf_searchTableView:titleForHeaderInSection:)]) {
        return [self.delegate mf_searchTableView:tableView titleForHeaderInSection:section];
    }
    return nil;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mf_searchTableView:titleForFooterInSection:)]) {
        return [self.delegate mf_searchTableView:tableView titleForFooterInSection:section];
    }
    return nil;
}

#pragma mark ========== UITableViewDelegate ==========

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mf_searchTableView:heightForRowAtIndexPath:)]) {
        return [self.delegate mf_searchTableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mf_searchTableView:heightForHeaderInSection:)]) {
        return [self.delegate mf_searchTableView:tableView heightForHeaderInSection:section];
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mf_searchTableView:heightForFooterInSection:)]) {
        return [self.delegate mf_searchTableView:tableView heightForFooterInSection:section];
    }
    return 0.01f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:mf_headerView_identifier];
    if (self.delegate && [self.delegate respondsToSelector:@selector(mf_searchTableView:viewForHeaderInSection:)]) {
        headerView = [self.delegate mf_searchTableView:tableView viewForHeaderInSection:section];
    }
    return headerView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:mf_footerView_identifier];
    if (self.delegate && [self.delegate respondsToSelector:@selector(mf_searchTableView:viewForFooterInSection:)]) {
        footerView = [self.delegate mf_searchTableView:tableView viewForFooterInSection:section];
    }
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mf_searchTableView:didSelectRowAtIndexPath:)]) {
        [self.delegate mf_searchTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end
