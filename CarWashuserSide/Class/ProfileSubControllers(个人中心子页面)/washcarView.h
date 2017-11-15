//
//  washcarView.h
//  CarWashuserSide
//
//  Created by apple on 2017/10/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MycarListModel;

@interface washcarView : UIView<UITextFieldDelegate>

-(instancetype)initWithFrame:(CGRect)frame andModel:(NSMutableArray *)modelArr;
@property(nonatomic,strong)MycarListModel           *model;
@property(nonatomic,weak)IBOutlet UIButton          *carBtn;
@property(nonatomic,copy)NSString           *car_latitude;
@property(nonatomic,copy)NSString           *car_longitude;
@property(nonatomic,weak)IBOutlet   UIButton       *car_Address;
@property(nonatomic,weak)IBOutlet   UITextField       *car_detail_Address;
@property(nonatomic,weak)IBOutlet   UIButton            *car_time;
@property(nonatomic,copy)NSString           *car_chewaiqingxi;
@property(nonatomic,copy)NSString           *car_biaozhunqingxi;
@property(nonatomic,copy)NSString           *car_fadongjiqingxi ;
@property(nonatomic,copy)NSString           *car_dala;
@property(nonatomic,copy)NSString           *car_shineijingxuan;
@property(nonatomic,copy)NSString           *car_kongtiaoxiaodu;
@property(nonatomic,copy)NSString           *car_djqID;
@property(nonatomic,weak)IBOutlet  UIButton             *djqBtn;
@property(nonatomic,copy)void     (^pushBlock)(UIButton   *btn);
@property(nonatomic,copy)void     (^getTotalMoneyBlock)();
@end
