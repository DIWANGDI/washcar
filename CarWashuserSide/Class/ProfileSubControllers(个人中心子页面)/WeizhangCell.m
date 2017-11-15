//
//  WeizhangCell.m
//  CarWashuserSide
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WeizhangCell.h"

@implementation WeizhangCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self=[[NSBundle mainBundle] loadNibNamed:@"WeizhangCell" owner:self options:nil][0];
    }
    self.scoreImg.layer.masksToBounds=YES;
    self.scoreImg.layer.cornerRadius=10;
    self.moneyImg.layer.masksToBounds=YES;
    self.moneyImg.layer.cornerRadius=10;
    
    return self;
}

-(void)setModel:(WeiguiModel *)model
{
    if (_model!=model)
    {
        _model=model;
    }
    [self setUI];
}

-(void)setUI
{
    self.timeLab.text=self.model.time;
    self.addressLab.text=[NSString stringWithFormat:@"%@%@%@",self.model.province,self.model.city,self.model.address];
    self.reasonLab.text=self.model.content;
    self.ScoreLab.text=[NSString stringWithFormat:@"-%@",self.model.score];
    self.costLab.text=[NSString stringWithFormat:@"-%@",self.model.price];
}
@end
