//
//  AddCarController.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddCarController.h"
#import "AddCarView.h"
#import "MycarListModel.h"
#import "ValuePickerView.h"
#import "CarPinpaiController.h"
#import "PinPaiModel.h"
#import "CKAlertViewController.h"

@interface AddCarController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIScrollView                *m_Scrollview;
@property(nonatomic,strong)AddCarView                  *leftView;
@property(nonatomic,strong)AddCarBaoxianView            *rightView;
@property(nonatomic,weak)IBOutlet    UIView                *m_Line;
@property(nonatomic,strong)XinghaoModel                    *xinghaoModel;
@end

@implementation AddCarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.couldEdit)
    {
        //查看我的爱车详情资料
        self.navTitleLab.text=@"爱车详情";
        self.m_Scrollview.frame=CGRectMake(0, 105, winsize.width, winsize.height-105);
    }
    else
    {
        self.navTitleLab.text=@"添加爱车";
        self.m_Scrollview.frame=CGRectMake(0, 105, winsize.width, winsize.height-145);
    }
    [self.m_Scrollview addSubview:self.leftView];
    [self.m_Scrollview addSubview:self.rightView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getxinghao:) name:KG_XINGHAO_NOTIFICATION object:nil];
}

-(void)getxinghao:(NSNotification *)noti
{
    self.xinghaoModel=[noti object];
    
    self.leftView.car_Type.text=[NSString stringWithFormat:@"%@-%@",self.xinghaoModel.CBT_BrandName,self.xinghaoModel.CBT_BrandTypeName];
    self.rightView.car_pintaixinghao.text=self.xinghaoModel.CBT_BrandTypeName;
}

-(UIScrollView *)m_Scrollview
{
    if (!_m_Scrollview)
    {
        _m_Scrollview = [[UIScrollView alloc] init];
        _m_Scrollview.backgroundColor=[UIColor whiteColor];
        _m_Scrollview.contentSize = CGSizeMake(2*winsize.width, 0);
        _m_Scrollview.contentOffset = CGPointMake(0, 0);
        _m_Scrollview.pagingEnabled = YES;
        _m_Scrollview.bounces = NO;
        _m_Scrollview.delegate=self;
        _m_Scrollview.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_m_Scrollview];
    }
    return _m_Scrollview;
}

-(AddCarView *)leftView
{
    if (!_leftView)
    {
          weakSelf(ws);
        _leftView=[[AddCarView alloc] initWithFrame:CGRectMake(0, 0, self.m_Scrollview.wh_width, 450)];
        _leftView.model=self.model;
        [_leftView.deleteBtn wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [ws deleteCarAction];
        }];
        _leftView.carBtnBlock = ^(NSInteger tag)
        {
            if (tag==100)
            {
                //车型
                CarPinpaiController *pinpaiVc=[[CarPinpaiController alloc] init];
                [ws.navigationController pushViewController:pinpaiVc animated:YES];
            }
            else if (tag==200)
            {
                //级别
                ValuePickerView *picker=[[ValuePickerView alloc] init];
                picker.dataSource=@[@"小轿车",@"SUV/MPV"];
                picker.pickerTitle=@"爱车选择";
                picker.valueDidSelect=^(NSString *value,NSInteger index)
                {
                    ws.leftView.car_Jibie.text=value;
                };
                [picker show];
            }
            else if (tag==300)
            {
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
            else if (tag==400)
            {
                //提交爱车左边view信息
                [ws subbmitleftInformACtion];
            }
        };
    }
    return _leftView;
}

-(AddCarBaoxianView *)rightView
{
    if (!_rightView)
    {
        weakSelf(ws);
        _rightView=[[AddCarBaoxianView alloc] initWithFrame:CGRectMake(winsize.width, 0, self.m_Scrollview.wh_width, 290)];
        _rightView.model=self.model;
        _rightView.rightviewBlock=^(NSInteger tag)
        {
            if (tag==100)
            {
                ValuePickerView *picker=[[ValuePickerView alloc] init];
                picker.dataSource=@[@"居民身份证",@"护照",@"军官证",@"驾驶证",@"港澳回乡证台胞证"];
                picker.pickerTitle=@"证件类型";
                picker.valueDidSelect=^(NSString *value,NSInteger index)
                {
                    ws.rightView.car_dzhengjianleixing.text=value;
                };
                [picker show];
            }
            else if (tag==200)
            {
                //提交爱车右边信息
                [ws subbmitrightInformACtion];
            }
        };
    }
    return _rightView;
}

-(IBAction)BtnAction:(UIButton *)sender
{
    NSInteger tag=sender.tag/100-1;
    [self updataLineFrame:tag];
    self.m_Scrollview.contentOffset=CGPointMake(tag*winsize.width, 0);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger tag=scrollView.contentOffset.x/winsize.width;
    self.leftView.frame=CGRectMake(0, 0, self.m_Scrollview.wh_width, 404);
    [self updataLineFrame:tag];
}

-(void)updataLineFrame:(NSInteger)tag
{
    DismissKeyboard;
    [self.m_Line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tag*winsize.width/2);
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.leftView.car_Img.image=info[UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//发布爱车左边信息
-(void)subbmitleftInformACtion
{
    if (self.couldEdit)
    {
        [self editCarInform];
    }
    else
    {
        [self addCarAction];
    }
}

-(void)editCarInform
{
    NSString    *C_PlateNumber=configEmpty(self.leftView.car_Num.text);
    NSString    *C_BrandName=self.xinghaoModel.CBT_BrandName;
    NSString    *C_BrandTypeName=self.xinghaoModel.CBT_BrandTypeName;
    NSString    *C_Color=configEmpty(self.leftView.car_Color.text);
    NSString    *C_CTID=[self.leftView.car_Jibie.text isEqualToString:@"小轿车"]?@"3":@"4";
    NSString    *C_CarTel=configEmpty(self.leftView.car_Phone.text);
    NSString     *C_CarName=self.model.C_CarName;
    NSString      *C_PlateNumberNew=configEmpty(self.leftView.car_UserName.text);
    if (![C_PlateNumber wh_isCarNumber])
    {
        [SVProgressHUD showImage:nil status:@"请输入正确的车牌号码"];
        return;
    }
    if (C_BrandName.length==0)
    {
        [SVProgressHUD showImage:nil status:@"请选择爱车品牌"];
        return;
    }
    if (C_BrandTypeName.length==0)
    {
        [SVProgressHUD showImage:nil status:@"请选择爱车型号"];
        return;
    }
    
    if (C_Color.length==0)
    {
        [SVProgressHUD showImage:nil status:@"请输入爱车颜色"];
        return;
    }
    if (C_CTID.length==0)
    {
        [SVProgressHUD showImage:nil status:@"请选择爱车类型"];
        return;
    }
    
    if (![C_CarTel isMobileNumber])
    {
        [SVProgressHUD showImage:nil status:@"请输入正确的手机号"];
        return;
    }
    if (C_CarName.length==0)
    {
        [SVProgressHUD showImage:nil status:@"请输入车主姓名"];
        return;
    }
    
    UIImage *yuanshiImg=[UIImage imageNamed:@"Car_Add_img"];
    NSData *data1 = UIImagePNGRepresentation(self.leftView.car_Img.image);
    NSData *data2 = UIImagePNGRepresentation(yuanshiImg);
    if ([data1 isEqualToData:data2])
    {
        [SVProgressHUD showImage:nil status:@"请上传爱车图片"];
        return;
    }
    
    NSData *data3=UIImageJPEGRepresentation(self.leftView.car_Img.image, 0.8f);
    NSString *imgStr=[data3 base64EncodedStringWithOptions:1];
    
    NSMutableDictionary *parms=[@{
                                  @"C_Image":imgStr,
                                  @"C_UTel":configEmpty([[OWTool Instance] getLoginUserInform][@"U_Tel"]),
                                  @"C_PlateNumber":C_PlateNumber,
                                  @"C_PlateNumberNew":C_PlateNumberNew,
                                  @"C_BrandName":C_BrandName,
                                  @"C_BrandTypeName":C_BrandTypeName,
                                  @"C_Color":C_Color,
                                  @"C_CTID":C_CTID,
                                  @"C_CarTel":C_CarTel,
                                  @"C_CarName":C_CarName
                                  }mutableCopy];
    [SVProgressHUD showWithStatus:@"上传中..."];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkEditCarInform withUserInfo:parms success:^(NSDictionary *message, NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else if (okStr.length>0)
         {
             [SVProgressHUD showSuccessWithStatus:@"修改成功"];
             [[NSNotificationCenter defaultCenter] postNotificationName:KG_MYCARLISTRELOAD_NOTIFICATION object:self];
         }
     } failure:^(NSError *error) {
         
     } visibleHUD:NO];
}

-(void)addCarAction
{
    NSString    *C_PlateNumber=configEmpty(self.leftView.car_Num.text);
    NSString    *C_BrandName=self.xinghaoModel.CBT_BrandName;
    NSString    *C_BrandTypeName=self.xinghaoModel.CBT_BrandTypeName;
    NSString    *C_Color=configEmpty(self.leftView.car_Color.text);
    NSString    *C_CTID=[self.leftView.car_Jibie.text isEqualToString:@"小轿车"]?@"3":@"4";
    NSString    *C_CarTel=configEmpty(self.leftView.car_Phone.text);
    NSString     *C_CarName=configEmpty(self.leftView.car_UserName.text);
    
    if (![C_PlateNumber wh_isCarNumber])
    {
        [SVProgressHUD showImage:nil status:@"请输入正确的车牌号码"];
        return;
    }
    if (C_BrandName.length==0)
    {
        [SVProgressHUD showImage:nil status:@"请选择爱车品牌"];
        return;
    }
    if (C_BrandTypeName.length==0)
    {
        [SVProgressHUD showImage:nil status:@"请选择爱车型号"];
        return;
    }
    
    if (C_Color.length==0)
    {
        [SVProgressHUD showImage:nil status:@"请输入爱车颜色"];
        return;
    }
    if (C_CTID.length==0)
    {
        [SVProgressHUD showImage:nil status:@"请选择爱车类型"];
        return;
    }
    
    if (![C_CarTel isMobileNumber])
    {
        [SVProgressHUD showImage:nil status:@"请输入正确的手机号"];
        return;
    }
    if (C_CarName.length==0)
    {
        [SVProgressHUD showImage:nil status:@"请输入车主姓名"];
        return;
    }
    
    UIImage *yuanshiImg=[UIImage imageNamed:@"Car_Add_img"];
    NSData *data1 = UIImagePNGRepresentation(self.leftView.car_Img.image);
    NSData *data2 = UIImagePNGRepresentation(yuanshiImg);
    if ([data1 isEqualToData:data2])
    {
        [SVProgressHUD showImage:nil status:@"请上传爱车图片"];
        return;
    }
    
    NSData *data3=UIImageJPEGRepresentation(self.leftView.car_Img.image, 0.8f);
    NSString *imgStr=[data3 base64EncodedStringWithOptions:1];
    
    NSMutableDictionary *parms=[@{
                                  @"data":imgStr,
                                  @"C_UTel":configEmpty([[OWTool Instance] getLoginUserInform][@"U_Tel"]),
                                  @"C_PlateNumber":C_PlateNumber,
                                  @"C_BrandName":C_BrandName,
                                  @"C_BrandTypeName":C_BrandTypeName,
                                  @"C_Color":C_Color,
                                  @"C_CTID":C_CTID,
                                  @"C_CarTel":C_CarTel,
                                  @"C_CarName":C_CarName
                                  }mutableCopy];
    [SVProgressHUD showWithStatus:@"上传中..."];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkPostAicheInform withUserInfo:parms success:^(NSDictionary *message, NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else if (okStr.length>0)
         {
             [SVProgressHUD showSuccessWithStatus:@"上传成功"];
         }
     } failure:^(NSError *error) {
         
     } visibleHUD:NO];
}

//提交右边数据
-(void)subbmitrightInformACtion
{
    NSDictionary *zjType=@{
                           @"居民身份证":@"1",
                           @"护照":@"2",
                           @"军官证":@"3",
                           @"驾驶证":@"4",
                           @"港澳回乡证台胞证":@"5"
                           };
    
    NSString    *C_UTel=configEmpty([[OWTool Instance] getLoginUserInform][@"U_Tel"]);
    NSString    *C_PlateNumber=configEmpty(self.leftView.car_Num.text);
    NSString    *C_CarTime=configEmpty(self.rightView.car_Djdate.text);
    NSString    *C_VIN=configEmpty(self.rightView.car_Cehjiahao.text);
    NSString    *C_MoterNumber=configEmpty(self.rightView.car_Fadongji.text);
    NSString    *C_CarTypeID=self.couldEdit?self.model.C_ID:self.xinghaoModel.CBT_ID;
    NSString    *C_IdentityType=configEmpty(zjType[self.rightView.car_dzhengjianleixing.text]);
    NSString    *C_IdentityCard=configEmpty(self.rightView.car_zhengjianhaoma.text);
    
    if (![C_PlateNumber wh_isCarNumber])
    {
        [SVProgressHUD showImage:nil status:@"请输入正确的车牌号码"];
        return;
    }
    NSMutableDictionary *parms=[@{
                                  @"C_UTel":C_UTel,
                                  @"C_PlateNumber":C_PlateNumber,
                                  @"C_CarTime":C_CarTime,
                                  @"C_VIN":C_VIN,
                                  @"C_MoterNumber":C_MoterNumber,
                                  @"C_CarTypeID":C_CarTypeID,
                                  @"C_IdentityType":C_IdentityType,
                                  @"C_IdentityCard":C_IdentityCard
                                  }mutableCopy];
     [SVProgressHUD showWithStatus:@"上传中..."];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkwanshanaiCheInform withUserInfo:parms success:^(id message, NSString *errorMsg, NSString *okStr)
    {
        if (errorMsg.length>0)
        {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        else
        {
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            //上传成功后刷新我的爱车列表
            [[NSNotificationCenter defaultCenter] postNotificationName:KG_MYCARLISTRELOAD_NOTIFICATION object:self];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error)
    {
    } visibleHUD:NO];
}

//删除车辆
-(void)deleteCarAction
{
    if (self.leftView.car_Num.text.length==0)
    {
        return;
    }
    NSString    *C_PlateNumber=configEmpty(self.leftView.car_Num.text);
    NSMutableDictionary *parms=[@{
                                  @"C_UTel":configEmpty([[OWTool Instance] getLoginUserInform][@"U_Tel"]),
                                  @"C_PlateNumber":C_PlateNumber
                                  }mutableCopy];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkDeleteCar withUserInfo:parms success:^(id message, NSString *errorMsg, NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else
         {
             [SVProgressHUD showSuccessWithStatus:@"删除成功"];
             //上传成功后刷新我的爱车列表
             [[NSNotificationCenter defaultCenter] postNotificationName:KG_MYCARLISTRELOAD_NOTIFICATION object:self];
             [self.navigationController popViewControllerAnimated:YES];
         }
     } failure:^(NSError *error)
     {
     } visibleHUD:NO];
}

@end
