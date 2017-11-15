//
//  PayDetailModel.h
//  CarWashuserSide
//
//  Created by apple on 2017/11/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayDetailModel : NSObject
@property(nonatomic,copy)NSString                   *P_ID;
@property(nonatomic,copy)NSString                   *P_TypeID;
@property(nonatomic,copy)NSString                   *P_PayUTel;
@property(nonatomic,copy)NSString                   *P_PayUserType;
@property(nonatomic,copy)NSString                   *P_PayPrice;
@property(nonatomic,copy)NSString                   *P_PayPriceAdd;
@property(nonatomic,copy)NSString                   *P_PayMoney;
@property(nonatomic,copy)NSString                   *P_TakeUTel;
@property(nonatomic,copy)NSString                   *P_TakeUserType;
@property(nonatomic,copy)NSString                   *P_TakePrice;
@property(nonatomic,copy)NSString                   *P_TakePriceAdd;
@property(nonatomic,copy)NSString                   *P_TakeMoney;
@property(nonatomic,copy)NSString                   *P_Time;
@property(nonatomic,copy)NSString                   *P_Type;
@property(nonatomic,copy)NSString                   *P_Ticket;
@property(nonatomic,copy)NSString                   *P_TicketNum;
@property(nonatomic,copy)NSString                   *P_Remark;
@end
