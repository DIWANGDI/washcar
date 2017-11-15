//
//  DJQController.h
//  CarWashuserSide
//
//  Created by apple on 2017/10/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "KGBaseTableViewController.h"

@interface DJQController : KGBaseTableViewController

@property(nonatomic,assign)double       totalPayMoney;
@property(nonatomic,assign)BOOL          isFromMemberCenter;
@property(nonatomic,copy)void (^sendCountAndIDBlock)(NSString *money,NSString   *id,NSString    *couldUsed);
@end
