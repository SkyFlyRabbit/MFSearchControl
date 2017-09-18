//
//  MFSearchController.m
//  MFSearchControllerExample
//
//  Created by MF on 2017/9/18.
//  Copyright © 2017年 MF. All rights reserved.
//

#import "MFSearchController.h"

#import "MFSearchResultViewController.h"

#define MF_SM_RGB(r, g, b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define MF_SM_ScreenWidth     ([UIScreen mainScreen].bounds.size.width)
#define MF_SM_ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define MF_SearchControlBundel_Image(imageName) image_from_bundle(imageName)

@interface MFSearchController ()<UISearchBarDelegate>

@property (nonatomic, copy) void(^searchBlock)(MFSearchController *vc, NSInteger type, NSString *searchText);

@property (nonatomic, strong) UIButton *cancelButton;//扩充取消按钮响应区域
@property (nonatomic, strong) UIButton *packUpKeyboardButton;//点击页面,收起键盘

@end

@implementation MFSearchController

- (instancetype)initWithSearchResultsController:(MFSearchResultViewController *)searchResultsController
                                     completion:(void(^)(MFSearchController *vc, NSInteger type, NSString *searchText))completion
{
    self = [self initWithSearchResultsController:searchResultsController];
    if (self) {
        if (searchResultsController) {
            self.searchResultsUpdater = searchResultsController;
        }
        self.searchBlock = completion;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = MF_SM_RGB(255, 255, 255);
    
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"搜索";
    [self.searchBar setBarTintColor:MF_SM_RGB(145, 147, 148)];
    self.searchBar.showsBookmarkButton = YES;
    self.searchBar.showsCancelButton = YES;
    [self.searchBar setImage:MF_SearchControlBundel_Image(@"mf_search_control_right") forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
    [self.searchBar setImage:MF_SearchControlBundel_Image(@"mf_search_control_left") forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    //修改searchBar的背景色
    for(id cc in [self.searchBar subviews]){
        for (id view in [cc subviews]) {
            if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [view removeFromSuperview];
            }
            
            if ([view isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                ((UITextField *)view).backgroundColor = MF_SM_RGB(246, 246, 249);
                [(UITextField *)view setClearButtonMode:UITextFieldViewModeWhileEditing];
            }
            
            if ([view isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
                UIButton *cancelBtn = (UIButton *)view;
                [cancelBtn setTitleColor:MF_SM_RGB(0, 122, 255) forState:UIControlStateNormal];
                [cancelBtn setTitleColor:MF_SM_RGB(0, 122, 255) forState:UIControlStateDisabled];
            }
        }
    }
}

- (void)dealloc
{
    NSLog(@"MFSearchController dealloc");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (![self.searchBar.superview.subviews containsObject:self.cancelButton]) {
        [self.searchBar.superview addSubview:self.cancelButton];
    }
    if (![self.view.subviews containsObject:self.packUpKeyboardButton]) {
        [self.view addSubview:self.packUpKeyboardButton];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark ========== setter && getter ==========

- (UIButton *)cancelButton
{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = [UIColor clearColor];
        
        CGFloat origionX = 0;
        for(id cc in [self.searchBar subviews]){
            for (id view in [cc subviews]) {
                if ([view isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                    origionX = CGRectGetMaxX(((UITextField *)view).frame);
                }
            }
        }
        CGRect superFrame = self.searchBar.superview.frame;
        _cancelButton.frame = CGRectMake(origionX, 0, superFrame.size.width - origionX, superFrame.size.height);
        [_cancelButton addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)packUpKeyboardButton
{
    if (_packUpKeyboardButton == nil) {
        _packUpKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _packUpKeyboardButton.backgroundColor = [UIColor clearColor];
        CGRect superFrame = self.searchBar.superview.frame;
        _packUpKeyboardButton.frame = CGRectMake(0, superFrame.size.height, MF_SM_ScreenWidth, MF_SM_ScreenHeight - superFrame.size.height);
        [_packUpKeyboardButton addTarget:self action:@selector(packUpKeyboard) forControlEvents:UIControlEventTouchUpInside];
    }
    return _packUpKeyboardButton;
}

#pragma mark ========== button method ==========

- (void)cancelSearch
{
    [self callBackWithSearchType:MFSearchControllerSearchTypeCancel text:@""];
}

- (void)packUpKeyboard
{
    [self.searchBar resignFirstResponder];
}

#pragma mark ========== UISearchBarDelegate ==========

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self callBackWithSearchType:MFSearchControllerSearchTypeText text:self.searchBar.text];
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    [self callBackWithSearchType:MFSearchControllerSearchTypeImage text:@""];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar 
{
    [self callBackWithSearchType:MFSearchControllerSearchTypeCancel text:@""];
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"4");
}// called when search results button pressed

#pragma mark ========== private ==========

- (void)callBackWithSearchType:(MFSearchControllerSearchType)searchType text:(NSString *)text
{
    if (self.searchBlock) {
        self.searchBlock(self, searchType, text);
    }
}

UIImage* image_from_bundle(NSString *imageName)
{
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"MFSearchController")];
    NSString *path = [bundle  pathForResource:@"MFSearchControl" ofType:@"bundle"];
    NSBundle *targetBundle = [NSBundle bundleWithPath:path];
    NSString *imagePath = [[targetBundle resourcePath] stringByAppendingPathComponent:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

#pragma mark ========== public ==========

- (void)presentInViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion
{
    viewController.definesPresentationContext=YES;
    [viewController presentViewController:self animated:animated completion:completion];
}

- (void)dismissInViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion
{
    [viewController dismissViewControllerAnimated:animated completion:completion];
}

- (void)fixDisplayBugInViewController:(UIViewController *)viewController
{
    viewController.definesPresentationContext = YES;
}

@end

