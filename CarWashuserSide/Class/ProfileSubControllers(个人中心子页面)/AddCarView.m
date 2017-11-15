//
//  AddCarView.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddCarView.h"
#import "MycarListModel.h"
#import "InputPanel.h"
#import "UserDatePicker.h"
#import "BRDatePickerView.h"

//获取车辆型号
NSString *getCarType(NSString *str)
{
    NSString *result=@"";
    if (str.intValue==3)
    {
        result=@"小轿车";
    }
    else if (str.intValue==4)
    {
        result=@"SUV/MPV";
    }
    return  result;
}


//获取证件类型
NSString *getZehngjianType(NSString *str)
{
    NSString *type;
    if (str.intValue==1)
    {
        type=@"居民身份证";
    }
    else if (str.intValue==2)
    {
        type=@"护照";
    }
    else if (str.intValue==3)
    {
        type=@"军官证";
    }
    else if (str.intValue==4)
    {
        type=@"驾驶证";
    }
    else if (str.intValue==5)
    {
         type=@"港澳回乡证台胞证";
    }
    return type;
}

@implementation AddCarView
{
    CGRect   view_Rect;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self=[[NSBundle mainBundle] loadNibNamed:@"AddCarView" owner:self options:nil][0];
        self.frame=frame;
    }
    [self wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        DismissKeyboard;
    }];
    self.car_Img.userInteractionEnabled=YES;
    [self.car_Img wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer)
     {
         self.carBtnBlock(gestureRecoginzer.view.tag);
     }];
    view_Rect=frame;
    return self;
}
//
//-(void)couldEdit:(BOOL)a
//{
//    if (a)
//    {
//        //所有按钮都可以编辑
//        self.car_Img.userInteractionEnabled=YES;
//        self.car_Num.userInteractionEnabled=YES;
//        self.car_Type.userInteractionEnabled=YES;
//        self.car_Jibie.userInteractionEnabled=YES;
//        self.car_Color.userInteractionEnabled=YES;
//        self.car_UserName.userInteractionEnabled=YES;
//        self.car_Phone.userInteractionEnabled=YES;
//        self.car_Img.userInteractionEnabled=YES;
//        [self.car_Img wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer)
//        {
//           self.carBtnBlock(gestureRecoginzer.view.tag);
//        }];
//    }
//    else
//    {
//        //所有按钮都不可以编辑
//        self.car_Img.userInteractionEnabled=NO;
//        self.car_Num.userInteractionEnabled=NO;
//        self.car_Type.userInteractionEnabled=NO;
//        self.car_Jibie.userInteractionEnabled=NO;
//        self.car_Color.userInteractionEnabled=NO;
//        self.car_UserName.userInteractionEnabled=NO;
//        self.car_Phone.userInteractionEnabled=NO;
//    }
//}

-(void)setModel:(MycarListModel *)model
{
    if (_model!=model)
    {
        _model=model;
    }
    [self setUI];
}

-(void)setUI
{
    if (self.model.C_Image.length>0)
    {
     [self.car_Img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kNewWordBaseURLString,self.model.C_Image]]];   
    }
    self.car_Num.text=self.model.C_PlateNumber;
    self.car_Type.text=self.model.C_BrandTypeName;
    self.car_Jibie.text=getCarType(self.model.C_CTID);
    self.car_Color.text=self.model.C_Color;
    self.car_UserName.text=self.model.C_CarName;
    self.car_Phone.text=self.model.C_CarTel;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.car_Num == textField)
    {
         [[InputPanel Inputpanel] setTitle:@"车牌号码" TextField:textField];
    }
    
    else if (self.car_Type == textField)
    {
        self.carBtnBlock(textField.tag);
    }
    
    else if (self.car_Jibie == textField)
    {
         self.carBtnBlock(textField.tag);
    }
    else if (self.car_Color == textField)
    {
        [[InputPanel Inputpanel] setTitle:@"颜色" TextField:textField];
    }
    else if (self.car_UserName == textField)
    {
        [[InputPanel Inputpanel] setTitle:@"车主姓名" TextField:textField];
    }
    else if (self.car_Phone == textField)
    {
        [[InputPanel Inputpanel] setTitle:@"手机号" TextField:textField];
    }
    else ;
    
    return NO;
}

-(IBAction)SubbmitAction:(UIButton *)sender
{
    self.carBtnBlock(sender.tag);
}
@end



@implementation AddCarBaoxianView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self=[[NSBundle mainBundle] loadNibNamed:@"AddCarView" owner:self options:nil][1];
        self.frame=frame;
    }
//    [self couldEdit:a];
    return self;
}

//-(void)couldEdit:(BOOL)a
//{
//    if (a)
//    {
//        //所有按钮都可以编辑
//        self.car_Djdate.userInteractionEnabled=YES;
//        self.car_Cehjiahao.userInteractionEnabled=YES;
//        self.car_Fadongji.userInteractionEnabled=YES;
//        self.car_pintaixinghao.userInteractionEnabled=NO;
//        self.car_dzhengjianleixing.userInteractionEnabled=YES;
//        self.car_zhengjianhaoma.userInteractionEnabled=YES;
//        
//    }
//    else
//    {
//        //所有按钮都不可以编辑
//        self.car_Djdate.userInteractionEnabled=NO;
//        self.car_Cehjiahao.userInteractionEnabled=NO;
//        self.car_Fadongji.userInteractionEnabled=NO;
//        self.car_pintaixinghao.userInteractionEnabled=NO;
//        self.car_dzhengjianleixing.userInteractionEnabled=NO;
//        self.car_zhengjianhaoma.userInteractionEnabled=NO;
//    }
//}

-(void)setModel:(MycarListModel *)model
{
    if (_model!=model)
    {
        _model=model;
    }
    [self setUI];
}

-(void)setUI
{
    self.car_Djdate.text=self.model.C_CarTime;
    self.car_Cehjiahao.text=self.model.C_VIN;
    self.car_Fadongji.text=self.model.C_MoterNumber;
    self.car_pintaixinghao.text=self.model.C_BrandName;
    self.car_dzhengjianleixing.text=getZehngjianType(self.model.C_IdentityType);
    self.car_zhengjianhaoma.text=self.model.C_IdentityCard;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.car_Djdate == textField)
    {        
        [BRDatePickerView showDatePickerWithTitle:@"登记日期" dateType:UIDatePickerModeDate defaultSelValue:textField.text minDateStr:@"" maxDateStr:[NSDate wh_getCurrentTimeWithFormat:@"yyyy-MM-dd HH:mm:ss"] isAutoSelect:YES resultBlock:^(NSString *selectValue) {
            textField.text=selectValue;
        }];
    }
    else if (self.car_Cehjiahao == textField)
    {
         [[InputPanel Inputpanel] setTitle:@"车架号" TextField:textField];
    }
    else if (self.car_Fadongji == textField)
    {
         [[InputPanel Inputpanel] setTitle:@"发动机号" TextField:textField];
    }
    else if (self.car_pintaixinghao == textField)
    {
         [[InputPanel Inputpanel] setTitle:@"品牌型号" TextField:textField];
    }
    else if (self.car_dzhengjianleixing == textField)
    {
        self.rightviewBlock(textField.tag);
    }
    else if (self.car_zhengjianhaoma == textField)
    {
         [[InputPanel Inputpanel] setTitle:@"证件号码" TextField:textField];
    }
    return NO;
}

-(IBAction)subbmitAction:(UIButton *)sender
{
    self.rightviewBlock(sender.tag);
}
@end
