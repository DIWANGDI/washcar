//
//  JYJMyWalletViewController.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JYJMyWalletViewController.h"
#import "JYJChargeController.h"
#import "DJQController.h"
#import "JYYueDetailController.h"

@interface JYJMyWalletViewController ()
{
    IBOutlet UILabel            *AU_Money;
}
@end

@implementation JYJMyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *userInfo=[[OWTool Instance] getLoginUserInform];
    AU_Money.text=configEmpty(userInfo[@"U_Money"]);
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:UIImageNamed(@"￥_detail") forState:UIControlStateNormal];
    rightBtn.frame=CGRectMake(20, 0, 50, 50);
    rightBtn.imageEdgeInsets=UIEdgeInsetsMake(15, 16, 15, 16);
    [rightBtn wh_addActionHandler:^(UIButton *sender)
     {
         JYYueDetailController *carVc=[[JYYueDetailController alloc] init];
         [self.navigationController pushViewController:carVc animated:YES];
     }];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
}

-(IBAction)BtnChargeAction:(UIButton *)sender
{
    if (sender.tag==100)
    {
        JYJChargeController *chargevc=[[JYJChargeController alloc] init];
        chargevc.totalMoney=AU_Money.text;       
        [self.navigationController pushViewController:chargevc animated:YES];
    }
    else
    {
        DJQController *djqVc=[[DJQController alloc] init];
        djqVc.isFromMemberCenter=YES;
        [self.navigationController pushViewController:djqVc animated:YES];
    }
}

@end
