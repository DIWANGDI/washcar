//
//  WashCarController.h
//  CarWashuserSide
//
//  Created by apple on 2017/10/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "KGBaseViewController.h"
@class MycarListModel;

@interface WashCarController : KGBaseViewController
@property(nonatomic,strong)MycarListModel       *model;
@property(nonatomic,assign)float                  O_Lng;
@property(nonatomic,assign)float                  O_Lat;
@property(nonatomic,copy)NSString               *addressStr;

@end
