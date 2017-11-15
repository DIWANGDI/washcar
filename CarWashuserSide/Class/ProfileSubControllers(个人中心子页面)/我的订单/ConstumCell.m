//
//  ConstumCell.m
//  CarWashuserSide
//
//  Created by apple on 2017/11/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ConstumCell.h"

@implementation ConstumCell
{
    IBOutlet UILabel            *carNum;
    IBOutlet UILabel            *addressNum;
    IBOutlet UILabel            *MoneyLab;
    IBOutlet UILabel            *timeLab;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self=[[NSBundle mainBundle] loadNibNamed:@"ConstumCell" owner:self options:nil][0];
    }    
    return self;
}

-(void)setModel:(ConsumeModel *)model
{
    if (_model!=model)
    {
        _model=model;
    }
    [self setUI];
}

-(void)setUI
{
    carNum.text=[NSString stringWithFormat:@"车辆: %@",self.model.O_PlateNumber];
    addressNum.text=[NSString stringWithFormat:@"地址: %@",self.model.O_WriteAdress];
    MoneyLab.text=[NSString stringWithFormat:@"消费金额: %@",self.model.O_Money];
    timeLab.text=[NSString stringWithFormat:@"时间 :%@",self.model.O_Time];
}

@end
