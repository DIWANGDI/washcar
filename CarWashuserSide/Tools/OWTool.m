//
//  OWTool.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//


#import "OWTool.h"
#import <CommonCrypto/CommonDigest.h>
NSString *const FIRSTLAUNCH = @"firstLaunch";
NSString *const USERINFIRM =@"UserInform";
NSString *const PINGTAIINFORM=@"pingtaiInform";
NSString  *const USERCAR=@"usercar";
NSString  *const IS_CALL_WHENFINISHWASH=@"isopenCall";
NSString    *const  IS_OPEN_YUYIN=@"is_open_video";

static OWTool * instance = nil;

@implementation OWTool


+(OWTool *) Instance
{
    @synchronized(self)
    {
        if(nil == instance)
        {
            [self new];
        }
    }
    return instance;
}

+ (void)SVProgressHUD
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD setMaxSupportedWindowLevel:2];
    [SVProgressHUD setMinimumSize:CGSizeMake(110, 110)];
}

+(NSString *)md5:(NSString *)str
{
    if (str == nil) {
        return @"";
    }
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
}

+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if(instance == nil)
        {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

-(void)SaveStateofInstall:(NSString *)a
{
    NSUserDefaults *personInformation = [NSUserDefaults standardUserDefaults];
    [personInformation removeObjectForKey:FIRSTLAUNCH];
    [personInformation setObject:a forKey:FIRSTLAUNCH];
    [personInformation synchronize];
}

-(NSString *)getStateofInstall
{
    NSUserDefaults *personInformation = [NSUserDefaults standardUserDefaults];
    return [personInformation objectForKey:FIRSTLAUNCH];
}


-(void)saveLoginUserInform:(NSDictionary *)dic
{
    NSUserDefaults *personInformation = [NSUserDefaults standardUserDefaults];
    [personInformation removeObjectForKey:USERINFIRM];
    [personInformation setObject:dic forKey:USERINFIRM];
    [personInformation synchronize];
}

-(NSDictionary *)getLoginUserInform
{
    NSUserDefaults *personInformation = [NSUserDefaults standardUserDefaults];
    return [personInformation objectForKey:USERINFIRM];
}

-(void)savePingtaiInform:(NSDictionary *)dic
{
    NSUserDefaults *personInformation = [NSUserDefaults standardUserDefaults];
    [personInformation removeObjectForKey:PINGTAIINFORM];
    [personInformation setObject:dic forKey:PINGTAIINFORM];
    [personInformation synchronize];
}

-(NSDictionary *)getPingtaiInform
{
    NSUserDefaults *personInformation = [NSUserDefaults standardUserDefaults];
    return [personInformation objectForKey:PINGTAIINFORM];
}

-(void)saveUsercarList:(NSArray *)arr
{
    NSUserDefaults *personInformation = [NSUserDefaults standardUserDefaults];
    [personInformation removeObjectForKey:USERCAR];
    [personInformation setObject:arr forKey:USERCAR];
    [personInformation synchronize];
}

-(NSMutableArray *)getUserCarList
{
    NSUserDefaults *personInformation = [NSUserDefaults standardUserDefaults];
    return [personInformation objectForKey:USERCAR];
}

-(void)SaveisCallWhenFinishWash:(NSString *)a
{
    NSUserDefaults *personInformation = [NSUserDefaults standardUserDefaults];
    [personInformation removeObjectForKey:IS_CALL_WHENFINISHWASH];
    [personInformation setObject:a forKey:IS_CALL_WHENFINISHWASH];
    [personInformation synchronize];
}
-(NSString *)getIsCallState
{
    NSUserDefaults *personInformation = [NSUserDefaults standardUserDefaults];
    return [personInformation objectForKey:IS_CALL_WHENFINISHWASH];
}

-(void)isOpenYUYinL:(NSString *)a
{
    NSUserDefaults *personInformation = [NSUserDefaults standardUserDefaults];
    [personInformation removeObjectForKey:IS_OPEN_YUYIN];
    [personInformation setObject:a forKey:IS_OPEN_YUYIN];
    [personInformation synchronize];
}

-(NSString *)getOpenYuyin
{
    NSUserDefaults *personInformation = [NSUserDefaults standardUserDefaults];
    return [personInformation objectForKey:IS_OPEN_YUYIN];
}
@end
