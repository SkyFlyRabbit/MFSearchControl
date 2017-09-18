//
//  MFSearchController.h
//  MFSearchControllerExample
//
//  Created by MF on 2017/9/18.
//  Copyright © 2017年 MF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MFSearchControllerSearchType){
    MFSearchControllerSearchTypeImage  = 1,/**< 图片搜索(搜索框右侧图片)*/
    MFSearchControllerSearchTypeText   = 2,/**< 文字搜索(搜索框输入的内容)*/
    MFSearchControllerSearchTypeCancel = 3,/**< 取消搜索*/
};

@class MFSearchResultViewController;

@interface MFSearchController : UISearchController

- (instancetype)initWithSearchResultsController:(MFSearchResultViewController *)searchResultsController
                                     completion:(void(^)(MFSearchController *vc, NSInteger type, NSString *searchText))completion;

- (void)presentInViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)dismissInViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)fixDisplayBugInViewController:(UIViewController *)viewController;

@end

