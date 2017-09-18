//
//  MF_StudyViewController.m
//  MFSearchControllerExample
//
//  Created by MF on 2017/9/18.
//  Copyright © 2017年 MF. All rights reserved.
//

#import "MF_StudyViewController.h"

@interface MF_StudyViewController ()

@end

@implementation MF_StudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstButton setTitle:@"系统搜索" forState:UIControlStateNormal];
    firstButton.backgroundColor = [UIColor redColor];
    firstButton.frame = CGRectMake(20, 150, self.view.bounds.size.width - 40, 50);
    [firstButton addTarget:self action:@selector(systemSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstButton];

    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [secondButton setTitle:@"验证搜索" forState:UIControlStateNormal];
    secondButton.backgroundColor = [UIColor greenColor];
    secondButton.frame = CGRectMake(20, 250, self.view.bounds.size.width - 40, 50);
    [secondButton addTarget:self action:@selector(customSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ========== button method ==========

- (void)systemSearch
{
    MF_StudyTestViewController *searchVC = [[MF_StudyTestViewController alloc] initWithSearchResultsController:nil];
    [self presentViewController:searchVC animated:YES completion:nil];
}

- (void)customSearch
{
    MF_StudyTestViewController *searchVC = [[MF_StudyTestViewController alloc] initWithSearchResultsController:nil];
    searchVC.view = [[MF_StudyTestView alloc] initWithFrame:searchVC.view.bounds];
    [self presentViewController:searchVC animated:YES completion:nil];
}

@end

@implementation MF_StudyTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"self.view = %@", self.view);
    NSLog(@"self = %@", self);
    NSLog(@"self.view.next = %@", self.view.nextResponder);
    NSLog(@"self.view.next.next = %@", self.view.nextResponder.nextResponder);
    NSLog(@"self.view.next.next.next = %@", self.view.nextResponder.nextResponder.nextResponder);
    NSLog(@"self.view.next.next.next.next = %@", self.view.nextResponder.nextResponder.nextResponder.nextResponder);
    NSLog(@"self.view.next.next.next.next.next = %@", self.view.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder);
    NSLog(@"self.view.next.next.next.next.next.next = %@", self.view.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder);
    NSLog(@"self.view.next.next.next.next.next.next.next = %@", self.view.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder);
}

@end

@implementation UIView (Touch)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"view = %@", self);
    NSLog(@"view.next = %@", self.nextResponder);
    [super touchesBegan:touches withEvent:event];
}

@end

@implementation MF_StudyTestView

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"mf_view = %@", self);
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        return nil;
    }
    return hitView;
}

@end
