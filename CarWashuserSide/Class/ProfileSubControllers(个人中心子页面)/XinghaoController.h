//
//  XinghaoController.h
//  CarWashuserSide
//
//  Created by apple on 2017/10/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "KGBaseTableViewController.h"
@class XinghaoModel;

@interface XinghaoController : KGBaseTableViewController

@property(nonatomic,copy)NSString           *CBT_BrandName;
@property(nonatomic,copy)void (^xinghaoBlock)(XinghaoModel *model);
@end
