//
//  JYOrderDetailController.m
//  CarWashuserSide
//
//  Created by apple on 2017/11/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JYOrderDetailController.h"
#import "KGOrderlistCell.h"
#import "PtOrderListModel.h"
#import "CKAlertViewController.h"

NSString* getOrderState(NSString *a)
{
    NSString *result=@"";
    if ([a isEqualToString:@"1"]) {
        result=@"待接单";
    }
    else if ([a isEqualToString:@"2"])
    {
        result=@"已接单，赶往爱车途中";
    }
    else if ([a isEqualToString:@"3"])
    {
        result=@"洗车中";
    }
    else if ([a isEqualToString:@"4"])
    {
        result=@"已洗完";
    }
    else if ([a isEqualToString:@"5"])
    {
        result=@"申请退款";
    }
    else if ([a isEqualToString:@"6"])
    {
        result=@"已退款)";
    }
    return result;
}


@interface JYOrderDetailController ()
{
    IBOutlet UILabel        *orderNum;
    IBOutlet UILabel        *orderState;
    IBOutlet UILabel        *orderTime;
    IBOutlet UILabel        *orderCar;
    IBOutlet UILabel        *orderJibie;
    IBOutlet UILabel        *orderLocation;
    IBOutlet UILabel        *order_Connect_Name;
    IBOutlet UILabel        *order_Connect_Phone;
    IBOutlet UILabel        *order_project;
    IBOutlet UILabel        *order_qingxi;
    IBOutlet UILabel        *order_Total_Money;
}
@end

@implementation JYOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLab.text=@"订单详情";
    if ([getOrderState(self.model.O_TypeID) isEqualToString:@"待接单"])
    {
        [self.navRightItem setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.navRightItem wh_addActionHandler:^(UIButton *sender) {
            [self reasonList];
        }];
    }
    [self setUI];
}

-(void)reasonList
{
    {
        CKAlertViewController *alert=[CKAlertViewController alertControllerWithTitle:@"" message:@"取消订单"];
        CKAlertAction *reason1=[CKAlertAction actionWithTitle:@"改变行程" handler:^(CKAlertAction *action)
                                {
                                    [self deleteOrder:action.title];
                                }];
        CKAlertAction *reason2=[CKAlertAction actionWithTitle:@"我想重新下单" handler:^(CKAlertAction *action)
                                {
                                    [self deleteOrder:action.title];
                                }];
        CKAlertAction *reason3=[CKAlertAction actionWithTitle:@"车辆信息不符" handler:^(CKAlertAction *action)
                                {
                                    [self deleteOrder:action.title];
                                }];
        CKAlertAction *reason4=[CKAlertAction actionWithTitle:@"洗车工要求取消订单" handler:^(CKAlertAction *action)
                                {
                                    [self deleteOrder:action.title];
                                }];
        CKAlertAction *reason5=[CKAlertAction actionWithTitle:@"其他原因" handler:^(CKAlertAction *action)
                                {
                                    [self deleteOrder:action.title];
                                }];
        
        CKAlertAction *canCel=[CKAlertAction actionWithTitle:@"取消" handler:nil];
        [alert addAction:reason1];
        [alert addAction:reason2];
        [alert addAction:reason3];
        [alert addAction:reason4];
        [alert addAction:reason5];
        [alert addAction:canCel];
        [self presentViewController:alert animated:NO completion:nil];
    }
}

-(void)deleteOrder:(NSString *)reason
{
    NSDictionary *userInfor=[[OWTool Instance] getLoginUserInform];
    NSMutableDictionary *parms=[@{
                                  @"O_UTel":configEmpty(userInfor[@"U_Tel"]),
                                  @"O_PlateNumber":self.model.O_PlateNumber,
                                  @"O_ID":self.model.O_IDS,
                                  @"O_ISCancelValue":reason
                                  }mutableCopy];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkDeleteOrder withUserInfo:parms success:^(NSDictionary *message,NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else
         {
             [SVProgressHUD showSuccessWithStatus:@"取消成功"];
             [self.navigationController popViewControllerAnimated:YES];
         }
     } failure:^(NSError *error)
     {
         
     } visibleHUD:NO];
}

-(void)setUI
{
    orderNum.text=self.model.O_ID;
    orderState.text=getOrderState(self.model.O_TypeID);
    orderTime.text=self.model.O_Time;
    orderCar.text=self.model.O_PlateNumber;
    orderJibie.text=self.model.O_CTID.intValue==3?@"小轿车":@"SUV或MPV";
    orderLocation.text=self.model.O_Adress;
    order_Connect_Name.text=self.model.O_CarName;
    order_Connect_Phone.text=self.model.O_UTel;
    order_Total_Money.text=[NSString stringWithFormat:@"合计金额:%@",self.model.O_Price];
    NSArray *O_WPart_Arr=[self.model.O_WPart componentsSeparatedByString:@"|"];
    
    NSDictionary *pingtaiDic=[[OWTool Instance] getPingtaiInform];
    NSArray  *tityArr=pingtaiDic[@"entityWashCarTypes"];
    NSArray  *entiArr=[PtOrderListModel mj_objectArrayWithKeyValuesArray:tityArr];
    NSMutableDictionary *wPart_dic=[NSMutableDictionary dictionary];
    [entiArr enumerateObjectsUsingBlock:^(PtOrderListModel *ptmodel, NSUInteger idx, BOOL * _Nonnull stop)
    {
        [wPart_dic setValue:ptmodel.W_Name forKey:ptmodel.W_ID];
    }];
    
    NSMutableString *str=[[NSMutableString alloc] init];
    [O_WPart_Arr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        NSString *key=[obj componentsSeparatedByString:@","][0];
        if ([wPart_dic.allKeys  containsObject:key])
        {
          [str appendString:[wPart_dic objectForKey:key]];
        }
    }];
    order_project.text=str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
