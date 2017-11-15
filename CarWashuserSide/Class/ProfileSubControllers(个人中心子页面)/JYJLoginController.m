//
//  JYJLoginController.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JYJLoginController.h"
#import "JYJRegisterController.h"
#import "JYForgetPassController.h"

@interface JYJLoginController ()
{
    IBOutlet UITextField       *phoneText;
    IBOutlet UITextField       *passText;
    BOOL                           isPasswordToLogin;
}
@end

@implementation JYJLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"登录";
    isPasswordToLogin=NO;
    [self.view wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        DismissKeyboard;
    }];
}

-(IBAction)BtnAction:(UIButton *)sender
{
    NSInteger tag=sender.tag;
     if (tag==400)
    {
        JYJRegisterController *resignVc=[[JYJRegisterController alloc] init];
        [self.navigationController pushViewController:resignVc animated:YES];
    }
    else if (tag==500)
    {
        JYForgetPassController *forgetVc=[[JYForgetPassController alloc] init];
        [self.navigationController pushViewController:forgetVc animated:YES];
    }
    else if (tag==600)
    {
        [self loginMethod];
    }
}

-(void)loginMethod
{

    NSMutableDictionary *parms=[@{
                                  @"U_Tel":phoneText.text,
                                  @"U_Pwd":passText.text
                                  }mutableCopy];
    [SVProgressHUD showWithStatus:@"登录中..."];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:kNetWorkActionLogin withUserInfo:parms success:^(NSDictionary *message,NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else
         {
             [[OWTool Instance] saveLoginUserInform:message];
             [OWTool Instance].isLogin=YES;
             //获取平台信息
             [self getPingtaiMethod];
             //获取我的爱车
             [self getAicarList];
         }
     } failure:^(NSError *error) {
         
     } visibleHUD:NO];
}

-(void)getPingtaiMethod
{
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkgetPingtaiInform withUserInfo:nil success:^(NSDictionary *message,NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else
         {
             [SVProgressHUD dismiss];
             [[OWTool Instance] savePingtaiInform:message];
             [self.navigationController popViewControllerAnimated:YES];
         }
     } failure:^(NSError *error)
     {
         
     } visibleHUD:NO];
}

-(void)getAicarList
{
    NSMutableDictionary *parms=[@{
                                  @"C_UTel":configEmpty([[OWTool Instance] getLoginUserInform][@"U_Tel"])
                                  }mutableCopy];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkMyCarlist withUserInfo:parms success:^(NSArray *message,NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else
         {
             [[OWTool Instance] saveUsercarList:message];
         }
     } failure:^(NSError *error) {
         
     } visibleHUD:NO];
}

@end





