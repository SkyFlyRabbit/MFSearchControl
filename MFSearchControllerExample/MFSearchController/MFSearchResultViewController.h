//
//  MFSearchResultViewController.h
//  MFSearchControllerExample
//
//  Created by MF on 2017/9/18.
//  Copyright © 2017年 MF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MFSearchResultViewControllerDelegate <NSObject>

@required

- (void)updateSearchResultWithKeyWords:(NSString *)keyWords;

- (UITableViewCell *)mf_searchTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)mf_searchTableViewTotalSectionCount:(UITableView *)tableView;
- (NSInteger)mf_searchTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSString *)mf_searchTableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (NSString *)mf_searchTableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;

- (CGFloat)mf_searchTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)mf_searchTableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)mf_searchTableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
- (UIView *)mf_searchTableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (UIView *)mf_searchTableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
- (void)mf_searchTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MFSearchResultViewController : UIViewController<UISearchResultsUpdating>

@property (nonatomic, strong, readonly) UITableView *tableView;

@property (nonatomic, weak) id<MFSearchResultViewControllerDelegate>delegate;

@end
