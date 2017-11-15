 //
//  HJNetworkManager.m
//  kindergarten
//
//  Created by Jun on 14-2-26.
//  Copyright (c) 2014年 WXJ. All rights reserved.
//

#import "KGNetworkManager.h"
#import "NSString+XYMethod.h"


@implementation KGNetworkManager

+ (instancetype)sharedInstance {
    static KGNetworkManager *networkManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[self alloc] init];
    });
    
    return networkManager;
}

-(AFHTTPRequestOperationManager *)baseHtppRequest
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
    return manager;
}

///POST请求
- (void)invokeNetWorkAPIWith:(NetWorkAction)action withUserInfo:(NSMutableDictionary *)params success:(HJMNetWorkSuccessBlock)successBlock failure:(HJMFailureBlock)failureBlock visibleHUD:(BOOL)visible{
    NetworkStatus status = [self networkStatus];
//    if (status == NotReachable) {
//        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"没有网络!", nil)];
//        NSError *error ;
//        failureBlock(error);
//        return;
//    }
    if (params == nil) {
        params = [[NSMutableDictionary alloc] initWithCapacity:2];
    }
    NSString *actionValue = nil;
    NSString *baseUrl=kNewWordBaseURLString;
    switch (action)
    {
        case kNetWorkActionLogin:
            actionValue = @"api/UsersLogin.ashx";
            break;
        case KNetWorkLoginByIMEI:
            actionValue=@"api/UserLoginDefault.ashx";
            break;
        case KNetWorkRegister:
            actionValue=@"api/UserRegister.ashx";
            break;
        case KNetWorkResetPassWord:
            actionValue=@"api/UserUpdatePasswordByIdentifyCode.ashx";
            break;
        case KNetWorkGetPassByPhoneAndOldPass:
            actionValue=@"api/UserUpdateByPassword.ashx";
            break;
        case KNetWorkActionOrderList:
            actionValue = @"api/OrderList.ashx";
            break;
        case KNetWorkMyCarlist:
            actionValue=@"api/CarList.ashx";
            break;
        case KNetWorkPingjia:
            actionValue=@"api/Evaluate.ashx";
            break;
        case KNetWorkgetxichegongLocation:
            actionValue=@"api/WorkerListUser.ashx";
            break;
        case KNetWorkgetChangyongaddress:
            actionValue=@"api/AdressOftenList.ashx";
            break;
        case KNetWorkgetPingtaiInform:
            actionValue=@"api/GetTitleInfoHandler.ashx";
            break;
        case KNetWrokSubbmitOrder:
            actionValue=@"api/OrderAdd.ashx";
            break;
        case KNetWorkGetuserDJQlist:
            actionValue=@"api/TicketList.ashx";
            break;
        case KNetWorkDeledeAddress:
            actionValue=@"api/AdressOftenDelete.ashx";
            break;
        case KNetWorkEditAddress:
            actionValue=@"api/AdressOftenUpdate.ashx";
            break;
        case KNetWorkgetPinpaiList:
            actionValue=@"api/CarPinPai.ashx";
            break;
        case KNetWorkgetXinghaolst:
            actionValue=@"api/CarGetXingHao.ashx";
            break;
        case KNetWorkPostAicheInform:
            actionValue=@"api/CarAdd.ashx";
            break;
        case KNetWorkEditCarInform:
            actionValue=@"api/CarUpdate.ashx";
            break;
        case KNetWorkwanshanaiCheInform:
            actionValue=@"api/CarMoreUpdate.ashx";
            break;
        case KNetWorkZfbPay:
            actionValue=@"GetResponse.aspx";
            break;
        case KNetWorkgetWeizhangList:
            baseUrl=@"http://api.jisuapi.com/illegal/query";
            actionValue=@"";
            break;
        case KNetWorkEditUserInform:
            actionValue=@"api/UserInfo.ashx";
            break;
        case KNetWorkDeleteOrder:
            actionValue=@"api/OrderDelete.ashx";
            break;
        case KNetWorkgetXiaofeiDeail:
            actionValue=@"api/OrderWash.ashx";
            break;
        case KNetWorkChargeDetail:
            actionValue=@"api/PayToList.ashx";
            break;
        case KNetWorkDeleteCar:
            actionValue=@"api/CarDelete.ashx";
            break;
    }
    
    if (visible) {
        [SVProgressHUD showWithStatus:@"发送中..."];
    }
    
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    
    NSString *urlStr = [[NSString stringWithFormat:@"%@%@",baseUrl,actionValue] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [params setObject:@"ald25e4fe86d4gv4bthj419t6yu4j6w56wty9" forKey:@"keys"];
    
    NSLog(@"post parameter == %@",params);
    NSLog(@"url=%@",urlStr);
    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (!responseObject) {
            [SVProgressHUD dismiss];
            return;
        }
        NSLog(@"response result == %@",responseObject);
        if (successBlock)
        {
            NSString    *errStr=@"";
            NSString    *okStr=@"";
            if ([responseObject isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *parDic=(NSDictionary *)responseObject;
                if ([parDic.allKeys containsObject:@"ErrorStr"])
                {
                    errStr=parDic[@"ErrorStr"];
                }
                if ([parDic.allKeys containsObject:@"OkStr"])
                {
                    okStr=parDic[@"OkStr"];;
                }
            }
            successBlock(responseObject,errStr,okStr);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@",error);
        
        [SVProgressHUD dismiss];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

#pragma mark - 网络检测

//检查网络状态
-(BOOL)checkedNetworkStatus{
    
    if (([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable) &&
        ([Reachability reachabilityForLocalWiFi].currentReachabilityStatus == NotReachable)) {
        return NO;
    }
    return YES;
}

//获取网络类型
- (NetworkStatus)networkStatus{
    
    if ([Reachability reachabilityForLocalWiFi].currentReachabilityStatus == ReachableViaWiFi) {
        return ReachableViaWiFi;
    }else if([Reachability reachabilityForInternetConnection].currentReachabilityStatus == ReachableViaWWAN){
        return ReachableViaWWAN;
    }else{
        return NotReachable;
    }
}

@end
