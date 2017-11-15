//
//  OWTool.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWTool : NSObject

+(OWTool *) Instance;

/** 设置SVProgressHUD */
+ (void)SVProgressHUD;
/** md5加密 */
+(NSString *) md5:(NSString *) str;


/**
 是否已经登录
 */
@property(nonatomic, assign)BOOL   isLogin;
/**
 是否洗车完成电话通知，
 */
@property(nonatomic,assign)BOOL     wasnFinishedToPhone;
-(void)SaveStateofInstall:(NSString *)a;
-(NSString *)getStateofInstall;

/**
 存储登录下发的数据
 */
-(void)saveLoginUserInform:(NSDictionary *)dic;
-(NSDictionary *)getLoginUserInform;

/**
 存储获取平台接口下发的信息
 */
-(void)savePingtaiInform:(NSDictionary *)dic;
-(NSDictionary *)getPingtaiInform;


/**
 存储我的爱车信息
 */
-(void)saveUsercarList:(NSArray *)arr;
-(NSMutableArray *)getUserCarList;

/**
 设置-洗完车给我电话，打开还是关闭
 */
-(void)SaveisCallWhenFinishWash:(NSString *)a;
-(NSString *)getIsCallState;

/**
 语音提示
 */
-(void)isOpenYUYinL:(NSString *)a;
-(NSString *)getOpenYuyin;
@end


