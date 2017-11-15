//
//  DJQCell.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DJQCell.h"

@implementation DJQCell
{
    IBOutlet UIImageView          *img;
    IBOutlet UILabel               *timeLab;
    IBOutlet UILabel                *moneyLab;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self=[[NSBundle mainBundle] loadNibNamed:@"DJQCell" owner:self options:nil][0];
    }
    return self;
}

-(void)setModelDic:(NSDictionary *)modelDic
{
    if (_modelDic!=modelDic)
    {
        _modelDic=modelDic;
    }
    NSString    *jine=configEmpty(self.modelDic[@"T_Ticket"]);
    moneyLab.text=[NSString stringWithFormat:@"¥%@元",jine];
    timeLab.text=[NSString stringWithFormat:@"有效期至:%@",configEmpty(self.modelDic[@"T_Time"])];
    if (jine.intValue==5)
    {
        [img setImage:UIImageNamed(@"Wash_Car-5")];
    }
    else if (jine.intValue==10)
    {
        [img setImage:UIImageNamed(@"Wash_Car-10-5")];
    }
    else
    {
        [img setImage:UIImageNamed(@"Wash_Car-20")];
    }
}
@end
