//
//  AddCarController.h
//  CarWashuserSide
//
//  Created by apple on 2017/10/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "KGBaseViewController.h"
@class MycarListModel;

@interface AddCarController : KGBaseViewController
@property(nonatomic,strong)MycarListModel *model;
@property(nonatomic,assign)BOOL                   couldEdit;    //如果点击cell进来是可以修改的
@end
