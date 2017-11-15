//
//  AddCarView.h
//  CarWashuserSide
//
//  Created by apple on 2017/10/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MycarListModel;

@interface AddCarView : UIView
@property(nonatomic,strong)MycarListModel *model;
@property(nonatomic,weak)IBOutlet UIImageView   *car_Img;
@property(nonatomic,weak)IBOutlet UITextField   *car_Num;
@property(nonatomic,weak)IBOutlet UITextField   *car_Type;
@property(nonatomic,weak)IBOutlet UITextField   *car_Jibie;
@property(nonatomic,weak)IBOutlet UITextField   *car_Color;
@property(nonatomic,weak)IBOutlet UITextField   *car_UserName;
@property(nonatomic,weak)IBOutlet UITextField   *car_Phone;
@property(nonatomic,weak)IBOutlet UIButton         *deleteBtn;
-(instancetype)initWithFrame:(CGRect)frame;
@property(nonatomic,copy)void (^carBtnBlock)(NSInteger tag);
@end


@interface AddCarBaoxianView : UIView
@property(nonatomic,strong)MycarListModel *model;
@property(nonatomic,weak)IBOutlet UITextField    *car_Djdate;
@property(nonatomic,weak)IBOutlet UITextField    *car_Cehjiahao;
@property(nonatomic,weak)IBOutlet UITextField    *car_Fadongji;
@property(nonatomic,weak)IBOutlet UITextField    *car_pintaixinghao;
@property(nonatomic,weak)IBOutlet UITextField    *car_dzhengjianleixing;
@property(nonatomic,weak)IBOutlet UITextField    *car_zhengjianhaoma;
@property(nonatomic,copy)void (^rightviewBlock)(NSInteger tag);
-(instancetype)initWithFrame:(CGRect)frame;
@end
