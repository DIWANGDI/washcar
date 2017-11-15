//
//  PtOrderListModel.h
//  CarWashuserSide
//
//  Created by apple on 2017/10/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PtOrderListModel : NSObject
@property(nonatomic,copy)NSString                   *W_ID;
@property(nonatomic,copy)NSString                   *W_Name;
@property(nonatomic,copy)NSString                   *W_Price;
@property(nonatomic,copy)NSString                   *W_CTID;
@property(nonatomic,copy)NSString                   *W_Side;
@property(nonatomic,copy)NSString                   *W_Title;
@property(nonatomic,copy)NSString                   *W_DurationMin;
@property(nonatomic,copy)NSString                   *W_DurationMax;
@property(nonatomic,copy)NSString                   *W_Remark;

@end
