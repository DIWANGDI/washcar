//
//  PayDetailCell.m
//  CarWashuserSide
//
//  Created by apple on 2017/11/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PayDetailCell.h"

@implementation PayDetailCell
{
    IBOutlet UILabel        *countNum;
    IBOutlet UILabel        *moneyNum;
    IBOutlet UILabel        *TimeLab;
    IBOutlet UILabel        *PayMethod;
    IBOutlet UILabel          *getMoney;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self=[[NSBundle mainBundle] loadNibNamed:@"PayDetailCell" owner:self options:nil][0];
    }
    return self;
}

-(void)setModel:(PayDetailModel *)model
{
    if (_model!=model)
    {
        _model=model;
    }
    [self setUI];
}

-(void)setUI
{
    
    NSDictionary *dc=@{
                       @"1":@"支付宝",
                       @"2":@"微信",
                       @"3":@"其他方式"
                       };
    countNum.text=[NSString stringWithFormat:@"账号: %@",self.model.P_TakeUTel];
    moneyNum.text=[NSString stringWithFormat:@"支付金额(元): %@",self.model.P_PayPrice];
    TimeLab.text=[NSString stringWithFormat:@"时间: %@",self.model.P_Time];
    PayMethod.text=[NSString stringWithFormat:@"充值方式 :%@",dc[configEmpty(self.model.P_Type)]];
    getMoney.text=[NSString stringWithFormat:@"到账金额(元): %d",(self.model.P_PayPrice.intValue+self.model.P_PayPriceAdd.intValue)];
    
}
@end
