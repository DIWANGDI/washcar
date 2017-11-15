//
//  PinPaiModel.h
//  CarWashuserSide
//
//  Created by apple on 2017/10/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PinPaiModel : NSObject
@property(nonatomic,copy)NSString                   *CB_ID;
@property(nonatomic,copy)NSString                   *CB_FirstLetter;
@property(nonatomic,copy)NSString                   *CB_BrandName;
@property(nonatomic,copy)NSString                   *CB_Image;
@property(nonatomic,copy)NSString                   *CB_Remark;
@end




@interface XinghaoModel : NSObject
@property(nonatomic,copy)NSString                   *CBT_ID;
@property(nonatomic,copy)NSString                   *CBT_FirstLetter;
@property(nonatomic,copy)NSString                   *CBT_BrandName;
@property(nonatomic,copy)NSString                   *CBT_BrandTypeName;
@property(nonatomic,copy)NSString                   *CBT_VehicleClass;
@property(nonatomic,copy)NSString                   *CBT_Remark;
@end
