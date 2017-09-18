//
//  ViewController.m
//  MFSearchControllerExample
//
//  Created by MF on 2017/9/18.
//  Copyright © 2017年 MF. All rights reserved.
//

#import "ViewController.h"

#import "MF_StudyViewController.h"
#import "MF_StaticSearchViewController.h"
#import "MF_RealTimeSearchViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searCh;
@property (nonatomic, copy) NSArray<NSDictionary<NSString *, Class> *> *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.dataSource = @[
                        @{@"静态搜索": [MF_StaticSearchViewController class]},
                        @{@"实时搜索": [MF_RealTimeSearchViewController class]},
                        @{@"学习过程": [MF_StudyViewController class]}
                        ];
    
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ========== UITableViewDataSource && UITableViewDelegate ==========

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row < self.dataSource.count) {
        cell.textLabel.text = [[self.dataSource[indexPath.row] allKeys] firstObject];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.dataSource.count) {
        Class class = [[self.dataSource[indexPath.row] allValues] firstObject];
        [self.navigationController pushViewController:[[class alloc] init] animated:YES];
    }
}

@end
