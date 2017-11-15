//
//  WashCarController.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WashCarController.h"
#import "washcarView.h"
#import "MycarListModel.h"
#import "carLocationController.h"
#import "PtOrderListModel.h"
#import "DJQController.h"

@interface WashCarController ()
@property(nonatomic,strong)washcarView          *carView;
@property(nonatomic,strong)UIScrollView         *m_Scrollview;
@property(nonatomic,strong)UIView                *bottomView;
@property(nonatomic,strong)UILabel               *moneyCountLab;
@property(nonatomic,strong)NSMutableArray          *arrItemArr;
@property(nonatomic,strong)NSString               *djqMoneyCount;
@property(nonatomic,copy)NSString               *djqID;
@property(nonatomic,copy)NSString                 *couldUsedMony;           //当消费金额到多少代金券才可以用
@end

@implementation WashCarController

-(NSMutableArray *)arrItemArr
{
    if (!_arrItemArr)
    {
        _arrItemArr=[NSMutableArray array];
    }
    return _arrItemArr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitleLab.text=@"洗车订单";
    [self.view addSubview:self.m_Scrollview];
    [self.view addSubview:self.bottomView];
    self.m_Scrollview.contentSize=CGSizeMake(0, 680);
    NSDictionary *pingtaiDic=[[OWTool Instance] getPingtaiInform];
    NSArray  *tityArr=pingtaiDic[@"entityWashCarTypes"];
    NSArray  *entiArr=[PtOrderListModel mj_objectArrayWithKeyValuesArray:tityArr];
    [self.arrItemArr addObjectsFromArray:entiArr];
    [self.view addSubview:self.carView];
    [self.m_Scrollview addSubview:self.carView];
    self.djqID=@"";
    self.djqMoneyCount=@"";
}

-(UIScrollView *)m_Scrollview
{
    if (!_m_Scrollview)
    {
        _m_Scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 85, winsize.width, winsize.height-125)];
        _m_Scrollview.backgroundColor=[UIColor whiteColor];
        _m_Scrollview.contentSize = CGSizeMake(2*winsize.width, 0);
        _m_Scrollview.contentOffset = CGPointMake(0, 0);
        _m_Scrollview.pagingEnabled = YES;
        _m_Scrollview.bounces = YES;
        _m_Scrollview.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_m_Scrollview];
    }
    return _m_Scrollview;
}

-(washcarView *)carView
{
    if (!_carView)
    {
        weakSelf(ws);
        _carView=[[washcarView alloc] initWithFrame:CGRectMake(0, 0, winsize.width, 620) andModel:self.arrItemArr];
        _carView.model=self.model;
        [_carView.car_Address setTitle:self.addressStr forState:UIControlStateNormal];
        _carView.pushBlock=^(UIButton *sender)
        {
            if (sender.tag==800)
            {
                //车辆位置
                carLocationController *locationVc=[[carLocationController alloc] init];
                locationVc.sendAddressBlock=^(NSString *address)
                {
                    NSString *str=address;
                    if ([address containsString:@"家: "])
                    {
                        str=[address componentsSeparatedByString:@" "][1];
                    }
                    else if ([address containsString:@"公司: "])
                    {
                        str=[address componentsSeparatedByString:@" "][1];
                    }
                    [ws.carView.car_Address setTitle:str forState:UIControlStateNormal];
                };
                [ws.navigationController pushViewController:locationVc animated:YES];
            }
            else if (sender.tag==900)
            {
                //代金券
                NSString *price=[ws.moneyCountLab.text componentsSeparatedByString:@"¥ "][1];
                NSString   *O_Price=[price componentsSeparatedByString:@"元"][0];
                
                DJQController *djqVc=[[DJQController alloc] init];
                djqVc.isFromMemberCenter=NO;
                djqVc.totalPayMoney=O_Price.intValue;
                djqVc.sendCountAndIDBlock=^(NSString *count,NSString *id,NSString   *couldUsedMony)
                {
                    ws.djqID=id;
                    ws.djqMoneyCount=count;
                    ws.couldUsedMony=couldUsedMony;
                    [ws.carView.djqBtn setTitle:[NSString stringWithFormat:@"%@元",count] forState:UIControlStateNormal];
                };
                [ws.navigationController pushViewController:djqVc animated:YES];
            }
        };
        _carView.getTotalMoneyBlock=^()
        {
            NSString *str1=@"";
            NSString *str2=@"";
            NSString *str3=@"";
            NSString *str4=@"";
            NSString *str5=@"";
            NSString *str6=@"";
            if (ws.carView.car_chewaiqingxi.length>0)
            {
                str1=[ws.carView.car_chewaiqingxi componentsSeparatedByString:@","][1];
            }
            if (ws.carView.car_biaozhunqingxi.length>0)
            {
                str2=[ws.carView.car_biaozhunqingxi componentsSeparatedByString:@","][1];
            }
            if (ws.carView.car_fadongjiqingxi.length>0)
            {
                str3=[ws.carView.car_fadongjiqingxi componentsSeparatedByString:@","][1];
            }
            if (ws.carView.car_dala.length>0)
            {
                str4=[ws.carView.car_dala componentsSeparatedByString:@","][1];
            }
            if (ws.carView.car_shineijingxuan.length>0)
            {
                str5=[ws.carView.car_shineijingxuan componentsSeparatedByString:@","][1];
            }
            if (ws.carView.car_kongtiaoxiaodu.length>0)
            {
                str6=[ws.carView.car_kongtiaoxiaodu componentsSeparatedByString:@","][1];
            }
            int    money=(str1.intValue+str2.intValue+str3.intValue+str4.intValue+str5.intValue+str6.intValue);
            ws.moneyCountLab.text=[NSString stringWithFormat:@"¥ %d元",money];
            
            //选择代金券后，如果在此勾选后消费的金额，比代金券消费需要的金额低则代金券传0
            if (money<self.couldUsedMony.floatValue)
            {
                ws.djqID=@"";
                ws.djqMoneyCount=@"";
                [ws.carView.djqBtn setTitle:@"无可用代金券" forState:UIControlStateNormal];
            }
        };
    }
    return _carView;
}

-(UIView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, winsize.height-50, winsize.width, 50)];
        UILabel  *lab1=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 80, 50)];
        lab1.text=@"合计 :";
        lab1.font=[UIFont systemFontOfSize:15];
        lab1.textColor=wh_RGB(99, 100, 101);
        [_bottomView addSubview:lab1];
        
        _moneyCountLab=[[UILabel alloc] initWithFrame:CGRectMake(50, 0, winsize.width-155, 50)];
        _moneyCountLab.textColor=lab1.textColor;
        _moneyCountLab.font=lab1.font;
        _moneyCountLab.text=@"¥ 0元";
        [_bottomView addSubview:_moneyCountLab];
        
        UIButton *submiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [submiBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        submiBtn.titleLabel.font=[UIFont systemFontOfSize:17];
        submiBtn.frame=CGRectMake(winsize.width-105, 0, 100, 50);
        [submiBtn setTitleColor:lab1.textColor forState:UIControlStateNormal];
        [submiBtn wh_addActionHandler:^(UIButton *sender)
        {
            [self subbmitAction];
        }];
        [_bottomView addSubview:submiBtn];
    }
    return _bottomView;
}

-(void)subbmitAction
{
    if (self.carView.car_Address.titleLabel.text.length==0)
    {
        [SVProgressHUD showImage:nil status:@"请选择车辆位置"];
        return;
    }
    if (self.carView.car_time.titleLabel.text.length==0)
    {
        [SVProgressHUD showImage:nil status:@"请选择服务时间"];
        return;
    }
    
    NSMutableString *orderStr=[[NSMutableString alloc] init];
    if (self.carView.car_chewaiqingxi.length>0)
    {
        [orderStr appendString:self.carView.car_chewaiqingxi];
        [orderStr appendString:@"|"];
    }
    
    if (self.carView.car_biaozhunqingxi.length>0)
    {
        [orderStr appendString:self.carView.car_biaozhunqingxi];
        [orderStr appendString:@"|"];
    }
    if (self.carView.car_fadongjiqingxi.length>0)
    {
        [orderStr appendString:self.carView.car_fadongjiqingxi];
        [orderStr appendString:@"|"];
    }
    if (self.carView.car_dala.length>0)
    {
        [orderStr appendString:self.carView.car_dala];
        [orderStr appendString:@"|"];
    }
    if (self.carView.car_shineijingxuan.length>0)
    {
        [orderStr appendString:self.carView.car_shineijingxuan];
        [orderStr appendString:@"|"];
    }
    if (self.carView.car_kongtiaoxiaodu.length>0)
    {
        [orderStr appendString:self.carView.car_kongtiaoxiaodu];
        [orderStr appendString:@"|"];
    }
    
    NSString *price=[self.moneyCountLab.text componentsSeparatedByString:@"¥ "][1];
    NSString   *O_Price=[price componentsSeparatedByString:@"元"][0];
    int showld_pay=O_Price.intValue-self.djqMoneyCount.intValue;
    
    //如果账户金额不够则充值
    NSDictionary *userInfo=[[OWTool Instance] getLoginUserInform];
    NSString    *current_User_Money=configEmpty(userInfo[@"U_Money"]);
    if (current_User_Money.intValue<showld_pay)
    {
        [SVProgressHUD showImage:nil status:@"您需要先充值"];
        return;
    }
    
    
    [SVProgressHUD showWithStatus:@"提交中..."];
    NSMutableDictionary *parms=[@{
                                  @"O_UTel":configEmpty(userInfo[@"U_Tel"]),
                                  @"O_CarTel":self.model.C_CarTel,
                                  @"O_CarName":self.model.C_CarName,
                                  @"O_PlateNumber":self.model.C_PlateNumber,
                                  @"O_WPart":orderStr,
                                  @"O_CTID":self.model.C_CTID,
                                  @"O_Price":O_Price,
                                  @"O_WriteAdress":self.carView.car_detail_Address.text,
                                  @"O_Adress":self.carView.car_Address.titleLabel.text,
                                  @"O_Lng":@(self.O_Lng),
                                  @"O_Lat":@(self.O_Lat),
                                  @"O_IsPhone":[[OWTool Instance] getIsCallState],
                                  @"O_Money":@(showld_pay),
                                  @"O_WashTime":self.carView.car_time.titleLabel.text,
                                  @"O_TID":self.djqID
                                  }mutableCopy];
    
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWrokSubbmitOrder withUserInfo:parms success:^(NSDictionary *message, NSString *errorMsg,NSString *okStr)
    {
        if (errorMsg.length>0)
        {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        else
        {
            [[OWTool Instance] saveLoginUserInform:message];
            [SVProgressHUD showSuccessWithStatus:@"订单发布成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error)
    {
    } visibleHUD:NO];
}
@end



