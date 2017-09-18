//
//  MF_StaticSearchViewController.m
//  MFSearchControllerExample
//
//  Created by MF on 2017/9/18.
//  Copyright © 2017年 MF. All rights reserved.
//

#import "MF_StaticSearchViewController.h"

#import "MFSearchController.h"

@interface MF_StaticSearchViewController ()

@end

@implementation MF_StaticSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"静态调用";
    self.view.backgroundColor = [UIColor grayColor];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    CGPoint point = self.view.center;
    button.frame = CGRectMake(point.x - 50, point.y - 25, 100, 50);
    [button addTarget:self action:@selector(beginSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)beginSearch
{
    __weak __typeof(&*self)weakSelf = self;
    MFSearchController *searchVC = [[MFSearchController alloc] initWithSearchResultsController:nil completion:^(MFSearchController *vc, NSInteger type, NSString *searchText) {
        NSLog(@"type = %ld, text = %@", type, searchText);
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.navigationController presentViewController:searchVC animated:YES completion:nil];
}

@end
