//
//  KGBaseViewController.m
//  Aerospace
//
//  Created by mac on 16/10/18.
//  Copyright © 2016年 王迪. All rights reserved.
//

#ifndef PepJapanese_NetWorkConstants_h
#define PepJapanese_NetWorkConstants_h



#endif

/**
 *  网络接口
 */

typedef enum _NetWorkAction
{
    /**
     *  账号信息相关
     */
    kNetWorkActionLogin = 0,                    //登录
    KNetWorkEditUserInform,                     //修改用户信息
    KNetWorkLoginByIMEI,                        //通过IMEI登录
    KNetWorkRegister,                           //用户注册
    KNetWorkResetPassWord,                      //修改密码
    KNetWorkGetPassByPhoneAndOldPass,           //通过手机号和旧密码修改密码
    KNetWorkActionOrderList,                    //我的订单
    KNetWorkMyCarlist,                          //我的爱车列表
    KNetWorkPingjia,                            //评价
    KNetWorkgetxichegongLocation,               //获取洗车工位置
    KNetWorkgetChangyongaddress,                //获取常用地址
    KNetWorkgetPingtaiInform,                   //获取平台信息
    KNetWorkDeleteOrder,                        //取消订单
    KNetWrokSubbmitOrder,                       //提交洗车订单
    KNetWorkGetuserDJQlist,                     //用户代金券列表
    KNetWorkDeledeAddress,                      //删除一条常用地址
    KNetWorkEditAddress,                        //修改用户常用地址
    KNetWorkgetPinpaiList,                      //获取车辆品牌列表
    KNetWorkgetXinghaolst,                      //根据品牌获取车辆型号
    KNetWorkPostAicheInform,                    //上传爱车信息
    KNetWorkEditCarInform,                      //修改爱车信息
    KNetWorkwanshanaiCheInform,                 //完善爱车信息
    KNetWorkDeleteCar,                          //删除车辆
    KNetWorkZfbPay,                             //支付宝支付
    KNetWorkgetWeizhangList,                    //获取违章列表
    KNetWorkgetXiaofeiDeail,                    //获取消费明细
    KNetWorkChargeDetail,                       //充值明细
}NetWorkAction;



typedef enum _NetWorkStatuCode
{
    /**
     *  公用错误编码
     */
    kNetWorkStatuCodeError = -1,                    //预留用来处理特殊情况
    kNetWorkStatuCodeSuccess = 0,                   //成功,0000
    kNetWorkStatuCodeUserNotExist = 8001,           //用户不存在
}NetWorkStatuCode;

typedef void(^HJMFailureBlock)(NSError *error);
typedef void(^HJMNetWorkSuccessBlock)(id message,NSString *errorMsg,NSString *okStr);

