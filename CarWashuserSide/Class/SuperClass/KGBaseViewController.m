//
//  KGBaseViewController.m
//  Aerospace
//
//  Created by mac on 16/10/18.
//  Copyright © 2016年 王迪. All rights reserved.
//

#import "KGBaseViewController.h"


@interface KGBaseViewController ()

@end

@implementation KGBaseViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [SVProgressHUD dismiss];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.6]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];

    [self setNav];
}

-(void)setNav{
    self.navBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, winsize.width, 64)];
    self.navBackView.backgroundColor = wh_RGB(23, 149, 161);
    [self.view addSubview:self.navBackView];
    
    self.navLetfItem = [UIButton buttonWithType:UIButtonTypeCustom];
    self.navLetfItem.frame=CGRectMake(10, 22, 40, 40);
    [self.navLetfItem setImage:UIImageNamed(@"M_arrow-left") forState:UIControlStateNormal];
    [self.navLetfItem addTarget:self action:@selector(leftItemBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navBackView addSubview:self.navLetfItem];
    //标题
    self.navTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(winsize.width/2-80, 20, 160, 44)];
    self.navTitleLab.textColor = [UIColor whiteColor];
    self.navTitleLab.lineBreakMode=NSLineBreakByTruncatingMiddle;
    self.navTitleLab.font = [UIFont systemFontOfSize:19];
    self.navTitleLab.textAlignment = NSTextAlignmentCenter;
    [self.navBackView addSubview:self.navTitleLab];
    
    self.navRightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    self.navRightItem.frame = CGRectMake(winsize.width-80, 22, 80, 40);
    [self.navRightItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navRightItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.navRightItem.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.navRightItem addTarget:self action:@selector(rightItemBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBackView addSubview:self.navRightItem];
}
-(void)leftItemBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightItemBtnAction:(UIButton *)sender
{
    
}

@end
