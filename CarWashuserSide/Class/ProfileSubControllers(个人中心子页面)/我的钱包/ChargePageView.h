//
//  ChargePageView.h
//  CarWashuserSide
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChargePageView : UIView

@property(nonatomic,copy)NSString           *money;

@property(nonatomic,copy)void   (^PayBlock)(NSInteger tag);
@property(nonatomic,copy)void   (^dismissBlock)(ChargePageView *view);
-(instancetype)initWithFrame:(CGRect)frame;

@end
