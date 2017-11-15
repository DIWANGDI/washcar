//
//  InformEditController.m
//  CarWashuserSide
//
//  Created by apple on 2017/11/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "InformEditController.h"
#import "CKAlertViewController.h"

@interface InformEditController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    IBOutlet UIImageView            *img;
    IBOutlet UITextField            *name;
    IBOutlet UITextField            *phone;
    IBOutlet UIImageView            *boyImg;
    IBOutlet UIImageView            *girlImg;
    BOOL                                isBoySelect;
}
@end

@implementation InformEditController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"个人资料";
    [self.view wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        DismissKeyboard;
    }];
    NSDictionary *userInfoDic=[[OWTool Instance] getLoginUserInform];
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kNewWordBaseURLString,userInfoDic[@"U_Image"]]] placeholderImage:UIImageNamed(@"PH_UserPhoto")];
    img.layer.cornerRadius=20;
    img.layer.masksToBounds=YES;
    name.text=configEmpty(userInfoDic[@"U_Name"]);
    phone.text=configEmpty(userInfoDic[@"U_Tel"]);
    if ([configEmpty(userInfoDic[@"U_Sex"]) isEqualToString:@"男"])
    {
        boyImg.image=UIImageNamed(@"M_UnChoose.png");
        girlImg.image=UIImageNamed(@"M_Choosed_Btn.png");
    }
    else
    {
        girlImg.image=UIImageNamed(@"M_UnChoose.png");
        boyImg.image=UIImageNamed(@"M_Choosed_Btn.png");
    }
    
    [img wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer)
    {
        [self selectImg];
    }];
}

-(void)selectImg
{
    weakSelf(ws);
    CKAlertViewController *alert=[CKAlertViewController alertControllerWithTitle:@"" message:@"更换照片"];
    CKAlertAction *camera=[CKAlertAction actionWithTitle:@"相机" handler:^(CKAlertAction *action)
                           {
                               UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                               imagePicker.delegate = ws;
                               imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                               imagePicker.allowsEditing = YES;
                               imagePicker.showsCameraControls = YES;
                               [ws dismissViewControllerAnimated:YES completion:nil];
                               [ws presentViewController:imagePicker animated:YES completion:^{}];
                           }];
    CKAlertAction *phont=[CKAlertAction actionWithTitle:@"相册" handler:^(CKAlertAction *action)
                          {
                              UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                              imagePicker.navigationBar.barTintColor=wh_RGB(23, 149, 161);
                              imagePicker.navigationBar.tintColor=[UIColor whiteColor];
                              imagePicker.delegate = ws;
                              imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                              imagePicker.allowsEditing = YES;
                              [imagePicker.navigationBar setTitleTextAttributes:
                               @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSForegroundColorAttributeName:[UIColor whiteColor]}];
                              imagePicker.title=@"相机胶卷";
                              [ws dismissViewControllerAnimated:YES completion:nil];
                              [ws presentViewController:imagePicker animated:YES completion:^{}];
                          }];
    CKAlertAction *canCel=[CKAlertAction actionWithTitle:@"取消" handler:nil];
    [alert addAction:camera];
    [alert addAction:phont];
    [alert addAction:canCel];
    [ws presentViewController:alert animated:NO completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    img.image=info[UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)SexSelect:(UIButton *)sender
{
    if (sender.tag==1000)
    {
        isBoySelect=YES;
        boyImg.image=UIImageNamed(@"M_UnChoose.png");
        girlImg.image=UIImageNamed(@"M_Choosed_Btn.png");
    }
    else
    {
        isBoySelect=NO;
        girlImg.image=UIImageNamed(@"M_UnChoose.png");
        boyImg.image=UIImageNamed(@"M_Choosed_Btn.png");
    }
}

-(IBAction)Subbmit:(id)sender
{
    UIImage *yuanshiImg=[UIImage imageNamed:@"PH_UserPhoto"];
    NSData *data1 = UIImagePNGRepresentation(img.image);
    NSData *data2 = UIImagePNGRepresentation(yuanshiImg);
    if ([data1 isEqualToData:data2])
    {
        [SVProgressHUD showImage:nil status:@"请上传头像"];
        return;
    }
    else if (name.text.length==0)
    {
        [SVProgressHUD showImage:nil status:@"请输入姓名"];
        return;
    }
    
    NSData *data3=UIImageJPEGRepresentation(img.image, 0.5f);
    NSString *imgStr=[data3 base64EncodedStringWithOptions:1];
    NSMutableDictionary *parms=[@{
                                  @"U_Tel":phone.text,
                                  @"U_IMEI":configEmpty([[OWTool Instance] getLoginUserInform][@"U_IMEI"]),
                                  @"U_Name":name.text,
                                  @"U_Sex":isBoySelect?@"男":@"女",
                                  @"data":imgStr
                                  }mutableCopy];
    [SVProgressHUD showWithStatus:@"提交中..."];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkEditUserInform withUserInfo:parms success:^(NSDictionary *message,NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else
         {
             [[OWTool Instance] saveLoginUserInform:message];
             [SVProgressHUD showSuccessWithStatus:@"提交成功"];
         }
     } failure:^(NSError *error) {
         
     } visibleHUD:NO];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    DismissKeyboard;
    return YES;
}
@end

