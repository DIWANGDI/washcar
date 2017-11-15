//
//  carLocationController.h
//  CarWashuserSide
//
//  Created by apple on 2017/10/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "KGBaseTableViewController.h"

@interface carLocationController : KGBaseTableViewController

@property(nullable,copy)void    (^sendAddressBlock)(NSString    *address);

@end
