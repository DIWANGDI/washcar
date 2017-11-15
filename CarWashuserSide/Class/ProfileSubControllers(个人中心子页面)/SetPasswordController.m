//
//  SetPasswordController.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SetPasswordController.h"

@interface SetPasswordController ()
{
    IBOutlet UITextField            *user_SetPass;
    IBOutlet UITextField            *user_ResetPss;
}
@end

@implementation SetPasswordController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitleLab.text=@"修改密码";
    [self.view wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        DismissKeyboard;
    }];
}

-(IBAction)BtnPress:(id)sender
{
    NSMutableDictionary *parms=[@{
                                  @"U_Tel":configEmpty([[OWTool Instance] getLoginUserInform][@"U_Tel"]),
                                  @"U_Pwd":user_SetPass.text,
                                  @"U_PwdNew":user_ResetPss.text
                                  }mutableCopy];
     [SVProgressHUD showWithStatus:@"修改中..."];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkGetPassByPhoneAndOldPass withUserInfo:parms success:^(NSDictionary *message,NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else if (okStr.length>0)
         {
             [SVProgressHUD showSuccessWithStatus:@"密码修改成功"];
         }
        
    } failure:^(NSError *error) {
        
    } visibleHUD:NO];
}

@end
