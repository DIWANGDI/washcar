//
//  CarCell.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CarCell.h"
#import "MycarListModel.h"

@implementation CarCell
{
    IBOutlet UIImageView     *m_Img;
    IBOutlet UILabel            *CarNum;
    IBOutlet UILabel            *CarJibie;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self=[[NSBundle mainBundle] loadNibNamed:@"CarCell" owner:self options:nil][0];
    }
    return self;
}

-(void)setModel:(MycarListModel *)model
{
    if (_model!=model)
    {
        _model=model;
    }
    [self setUI];
}

-(void)setUI
{
    [m_Img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kNewWordBaseURLString,self.model.C_Image]]];
    CarNum.text=self.model.C_PlateNumber;
    CarJibie.text=[self getCArType:self.model.C_CTID];
}

-(NSString *)getCArType:(NSString *)str
{
    NSString *result;
    if (str.intValue==3)
    {
        result=@"小轿车";
    }
    else
    {
        result=@"SUV/MPV";
    }
    return  result;
}
@end
