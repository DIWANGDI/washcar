//
//  AppDelegate.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JYJPushBaseViewController.h"

@interface JYJPushBaseViewController ()

@end

@implementation JYJPushBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIButton *bacBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    bacBtn.frame=CGRectMake(10, 22, 40, 40);
//    [bacBtn setImage:UIImageNamed(@"M_arrow-left") forState:UIControlStateNormal];
//    [bacBtn addTarget:self action:@selector(leftItemBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = bacBtn;
    
    weakSelf(ws);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 22, 40, 40);
    [button setImage:[UIImage imageNamed:@"M_arrow-left"] forState:UIControlStateNormal];
    [button wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [ws.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

@end
