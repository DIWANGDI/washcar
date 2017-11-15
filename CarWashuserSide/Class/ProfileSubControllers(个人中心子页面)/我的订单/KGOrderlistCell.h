//
//  KGOrderlistCell.h
//  CarWashuserSide
//
//  Created by apple on 2017/10/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KGOrderModel;

@interface KGOrderlistCell : UITableViewCell
@property(nonatomic,strong)KGOrderModel  *model;
@property(nonatomic,copy)void (^BtnBlock)(KGOrderModel *model);
@end


@interface KGOrderHistorylistCell : UITableViewCell
@property(nonatomic,strong)KGOrderModel  *model;
@property(nonatomic,copy)void (^btnBlovk)(KGOrderModel *model,NSInteger tag);
@end


