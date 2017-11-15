//
//  JYJChargeController.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JYJChargeController.h"
#import "ChargePageView.h"
#import "PayDetailController.h"
#import <CommonCrypto/CommonDigest.h>
#import <AlipaySDK/AlipaySDK.h>
#import "PartnerConfig.h"
#import "Order.h"
#import "DataSigner.h"
#import "WechatAuthSDK.h"
#import "WXApi.h"
#import "WXApiObject.h"
#define WX_API_KEY      @"66E1309240219FD809131D2CE28D34A0"

@interface JYJChargeController ()
{
    IBOutletCollection(UIButton)NSArray *btnArr;
    IBOutlet UIButton                        *leftBtn;
    IBOutlet UIButton                        *rightBtn;
    IBOutlet UIView                           *lineView;
    BOOL                                         isCurrentPay;
    IBOutlet UITextField                    *phoneText;
    IBOutlet UILabel                           *currentMoney;
    NSString                                   *userPhone;
    ChargePageView                           *pageView;
}
@property(nonatomic,strong)  UIView      *m_Shadow;
@property(nonatomic,weak)IBOutlet UITextField                    *monyCount;
@end

@implementation JYJChargeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLab.text=@"支付";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navRightItem.frame = CGRectMake(winsize.width-40, 30, 30, 24);
    [self.navRightItem setImage:UIImageNamed(@"￥_detail") forState:UIControlStateNormal];
    [self.navRightItem wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        PayDetailController *carVc=[[PayDetailController alloc] init];
        [self.navigationController pushViewController:carVc animated:YES];
    }];
    userPhone=[[OWTool Instance] getLoginUserInform][@"U_Tel"];
    phoneText.text=userPhone;
    currentMoney.text=[NSString stringWithFormat:@"余额(元): %@",self.totalMoney];
    [self.view wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        DismissKeyboard;
    }];
    isCurrentPay=YES;
    for (UIButton *btn in btnArr)
    {
        btn.layer.borderWidth=1;
        btn.layer.cornerRadius=5;
        btn.layer.borderColor=wh_RGB(196, 196, 196).CGColor;
    }
    
    self.m_Shadow = [[UIView alloc] init];
    UIWindow* window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [window addSubview:self.m_Shadow];
    [self.m_Shadow wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer)
    {
        self.m_Shadow.frame=CGRectMake(0, 0, 0, 0);
        [UIView animateWithDuration:0.3 animations:^
        {
            pageView.frame=CGRectMake(0, winsize.height, winsize.width, 380);
        }];
    }];
    weakSelf(ws);
    pageView=[[ChargePageView alloc] initWithFrame:CGRectMake(0, winsize.height, winsize.width, 380)];
    pageView.PayBlock=^(NSInteger tag)
    {
        if (tag==0)
        {
            //微信支付
        }
        else
        {
            NSString *appScheme = @"com.hangantongZFB.cn";
            // 1.创建一个网络路径
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.mabangxiche.com/GetResponse.aspx"]];
            // 2.创建一个网络请求，分别设置请求方法、请求参数
            NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
            request.HTTPMethod = @"POST";
            NSString *str=[NSString stringWithFormat:@"Body=%@&Subject=%@&TotalAmount=%@",configEmpty([[OWTool Instance] getLoginUserInform][@"U_Tel"]),@"充值",@"0.01"];
            request.HTTPBody=[str dataUsingEncoding:NSUTF8StringEncoding];
            // 3.获得会话对象
            NSURLSession *session = [NSURLSession sharedSession];
            // 4.根据会话对象，创建一个Task任务
            NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSLog(@"从服务器获取到数据");
                /*
                 对从服务器获取到的数据data进行相应的处理.
                 */
                NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
                
                [[AlipaySDK defaultService] payOrder:result fromScheme:appScheme callback:^(NSDictionary *resultDic)
                 {//这里的支付结果是在没有安装支付宝客服端的情况下跳转网页支付时，会在这回调
                     NSLog(@"返回结果resultDic = %@",resultDic[@"memo"]);
                     if (resultDic)
                     {
                         /*
                          9000 订单支付成功
                          8000 正在处理中
                          4000 订单支付失败
                          6001 用户中途取消
                          6002 网络连接出错
                          */
                         if ([resultDic[@"resultStatus"]integerValue] == 9000){
                             
//                             [self.navigationController popViewControllerAnimated:YES];
                             [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                         }
                     }
                 }];
                
                NSLog(@"%@",result);
            }];
            //5.最后一步，执行任务，(resume也是继续执行)。
            [sessionDataTask resume];
        
        }
    };
    pageView.dismissBlock=^(ChargePageView *views)
    {
        ws.m_Shadow.frame=CGRectMake(0, 0, 0, 0);
        [UIView animateWithDuration:0.3 animations:^{
            views.frame=CGRectMake(0, winsize.height, winsize.width, 380);
        }];
    };
    [self.view addSubview:pageView];
}

-(IBAction)ChargeAction:(UIButton *)sender
{
    DismissKeyboard;
    NSInteger tag=sender.tag;
    if (tag==700)
    {
        if (![phoneText.text isMobileNumber])
        {
             [SVProgressHUD showImage:nil status:@"手机号错误"];
            return;
        }
        if (self.monyCount.text.length==0)
        {
            [SVProgressHUD showImage:nil status:@"请选择充值金额"];
            return;
        }
        self.m_Shadow.frame=CGRectMake(0, 0, winsize.width, winsize.height-380);
        self.m_Shadow.backgroundColor = [UIColor blackColor];
        self.m_Shadow.alpha = 0.7;

        pageView.money=[self.monyCount.text componentsSeparatedByString:@"元"][0];
        pageView.frame=CGRectMake(0, winsize.height-380, winsize.width, 380);
        
    } else if (tag==800)
    {
        
        
    }
    else if (tag==900)
    {
        isCurrentPay=YES;
        phoneText.text=userPhone;
        phoneText.userInteractionEnabled=NO;
        [leftBtn setTitleColor:wh_RGB(63, 157, 171) forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
        }];
    }
    else if (tag==1000)
    {
        isCurrentPay=NO;
        phoneText.text=@"";
        phoneText.userInteractionEnabled=YES;
        [leftBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [rightBtn setTitleColor:wh_RGB(63, 157, 171) forState:UIControlStateNormal];
        [lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(winsize.width/2);
        }];
    }
    else
    {
        self.monyCount.text=[NSString stringWithFormat:@"%zi元",tag];
    }
}

///微信支付
-(void)WechatAction:(NSDictionary *)dic
{
    PayReq* req             = [[PayReq alloc] init];
    req.openID=configEmpty(dic[@"appid"]);
    req.partnerId = configEmpty(dic[@"mch_id"]);
    req.prepayId= configEmpty(dic[@"prepayId"]);
    req.package =@"Sign=WXPay";
    req.timeStamp=[[NSDate date] timeIntervalSince1970];
    req.nonceStr= configEmpty(dic[@"nonce_str"]);
    req.sign=[self createMD5SingForPayWithAppID:req.openID partnerid:req.partnerId prepayid:req.prepayId package:req.package noncestr:req.nonceStr timestamp:req.timeStamp];
    [WXApi sendReq:req];
}

-(NSString *)createMD5SingForPayWithAppID:(NSString *)appid_key partnerid:(NSString *)partnerid_key prepayid:(NSString *)prepayid_key package:(NSString *)package_key noncestr:(NSString *)noncestr_key timestamp:(UInt32)timestamp_key
{
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject:appid_key forKey:@"appid"];//微信appid 例如wxfb132134e5342
    [signParams setObject:noncestr_key forKey:@"noncestr"];//随机字符串
    [signParams setObject:package_key forKey:@"package"];//扩展字段  参数为 Sign=WXPay
    [signParams setObject:partnerid_key forKey:@"partnerid"];//商户账号
    [signParams setObject:prepayid_key forKey:@"prepayid"];//此处为统一下单接口返回的预支付订单号
    [signParams setObject:[NSString stringWithFormat:@"%u",(unsigned int)timestamp_key] forKey:@"timestamp"];//时间戳
    
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [signParams allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[signParams objectForKey:categoryId] isEqualToString:@""]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [signParams objectForKey:categoryId]];
        }
    }
    //添加商户密钥key字段  API 密钥
    [contentString appendFormat:@"key=%@", WX_API_KEY];
    NSString *result = [self md5String:contentString];//md5加密
    return result;
}

/**
 *  MD5 加密
 *
 *  @return 加密后字符串
 */
- (NSString *)md5String:(NSString *)str
{
    if(str == nil || [str length] == 0) return nil;
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([str UTF8String], (int)[str lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for(i=0;i<CC_MD5_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

//将字符串进行MD5加密，返回加密后的字符串
-(NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}

@end
