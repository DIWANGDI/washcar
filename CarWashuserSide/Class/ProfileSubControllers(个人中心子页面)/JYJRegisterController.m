//
//  JYJRegisterController.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JYJRegisterController.h"
#import "JSMSSDK.h"

@interface JYJRegisterController ()
{
    IBOutlet UIImageView            *user_Photo;
    IBOutlet UITextField            *user_Phone;
    IBOutlet UITextField            *user_YzM;
    IBOutlet UITextField            *user_SetPass;
    IBOutlet UITextField            *user_ResetPss;
    IBOutlet UIButton                *User_YZMSetBtn;
    NSTimer                            *m_Timer;
    int                                 time;
}
@end

@implementation JYJRegisterController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitleLab.text=@"注册";
    User_YZMSetBtn.layer.borderWidth=1;
    self.view.backgroundColor=[UIColor whiteColor];
    User_YZMSetBtn.layer.borderColor=wh_RGB(167, 218, 220).CGColor;
    [self.view wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        DismissKeyboard;
    }];
}

-(IBAction)RegisterAction:(UIButton *)sender
{
    if (![user_Phone.text isMobileNumber])
    {
        [SVProgressHUD showImage:nil status:@"请输入正确的手机号码"];
        return;
    }
    
    if (sender.tag==100)
    {
        //极光短信发送
        [JSMSSDK getVerificationCodeWithPhoneNumber:user_Phone.text andTemplateID:@"1" completionHandler:^(id resultObject, NSError *error) {
            if (!error) {
                NSLog(@"Get verification code success!");
                
                time=60;
                User_YZMSetBtn.userInteractionEnabled=NO;
                [User_YZMSetBtn setTitle:[NSString stringWithFormat:@"%ds",time] forState:UIControlStateNormal];
                m_Timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimeGoNext) userInfo:nil repeats:YES];
                
            }else{
                NSLog(@"Get verification code failure!");
                NSLog(@"%@",error);
            }
        }];
    }
    else if (sender.tag==200)
    {
        //注册
        if (user_YzM.text.length==0)
        {
            [SVProgressHUD showImage:nil status:@"请获取验证码"];
            return;
        }
        if (user_SetPass.text.length<6)
        {
            [SVProgressHUD showImage:nil status:@"请输入6位以上的密码"];
            return;
        }
        if (![user_SetPass.text isEqualToString:user_ResetPss.text])
        {
            [SVProgressHUD showImage:nil status:@"两次输入的密码不一致"];
            return;
        }
        [self jiaoYanYZM];
    }
}


-(void)TimeGoNext
{
    time-=1;
    [User_YZMSetBtn setTitle:[NSString stringWithFormat:@"%ds",time] forState:UIControlStateNormal];
    if (time==0)
    {
        User_YZMSetBtn.userInteractionEnabled=YES;
        [User_YZMSetBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [m_Timer invalidate];
        m_Timer=nil;
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [m_Timer invalidate];
    m_Timer=nil;
}

//极光验证码校验
-(void)jiaoYanYZM
{
     [SVProgressHUD showWithStatus:@"登录中..."];
    [JSMSSDK commitWithPhoneNumber:user_Phone.text verificationCode:user_YzM.text completionHandler:^(id resultObject, NSError *error)
     {
         if (!error)
         {
             [self registerMethod];
         }else{
             [SVProgressHUD showErrorWithStatus:@"验证码错误"];
         }
     }];
}

-(void)registerMethod
{
    NSMutableDictionary *parms=[@{
                                  @"U_Tel":user_Phone.text,
                                  @"U_Pwd":user_SetPass.text
                                  }mutableCopy];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkRegister withUserInfo:parms success:^(NSDictionary *message,NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else
         {
             [[OWTool Instance] saveLoginUserInform:message];
             [SVProgressHUD showSuccessWithStatus:@"注册成功"];
         }
     } failure:^(NSError *error) {
     } visibleHUD:NO];
}

@end
