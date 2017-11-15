//
//  KGOrderlistCell.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "KGOrderlistCell.h"
#import "KGOrderModel.h"


NSString* getState(NSString *a)
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

@interface KGOrderlistCell ()
{
    IBOutlet UIImageView                *m_img;
    IBOutlet UILabel                     *m_time;
    IBOutlet UILabel                     *m_carNum;
    IBOutlet UILabel                     *m_projType;
    IBOutlet UILabel                     *m_price;
    IBOutlet UILabel                     *m_state;
}
@end
@implementation KGOrderlistCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self=[[NSBundle mainBundle] loadNibNamed:@"KGOrderlistCell" owner:self options:nil][0];
    }
    UIButton   *btn1=[self.contentView viewWithTag:100];
    btn1.layer.borderColor=wh_RGB(240, 240, 240).CGColor;
    return self;
}

-(void)setModel:(KGOrderModel *)model
{
    if (_model!=model)
    {
        _model=model;
    }
       [self setCellUI];
}

-(void)setCellUI
{
    [m_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kNewWordBaseURLString,self.model.O_CarImage]]];
    m_time.text=[NSString stringWithFormat:@"下单时间:%@",self.model.O_Time];
    m_carNum.text=[NSString stringWithFormat:@"服务车辆:%@",self.model.O_PlateNumber];
    m_projType.text=[NSString stringWithFormat:@"服务项目:%@",self.model.O_EvaluateType];
    m_price.text=[NSString stringWithFormat:@"订单价格:%@",self.model.O_Price];
    m_state.text=[NSString stringWithFormat:@"订单状态:%@",getState(self.model.O_TypeID)];
}


-(IBAction)toplaceanOrderAction:(id)sender
{
    self.BtnBlock(self.model);
}
@end

@interface KGOrderHistorylistCell ()
{
    IBOutlet UIImageView                *h_img;
    IBOutlet UILabel                     *h_time;
    IBOutlet UILabel                     *h_carNum;
    IBOutlet UILabel                     *h_projType;
    IBOutlet UILabel                     *h_price;
}
@end
@implementation KGOrderHistorylistCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self=[[NSBundle mainBundle] loadNibNamed:@"KGOrderlistCell" owner:self options:nil][1];
    }
    UIButton   *btn1=[self.contentView viewWithTag:100];
    btn1.layer.borderColor=wh_RGB(240, 240, 240).CGColor;
    UIButton   *btn2=[self.contentView viewWithTag:200];
    btn2.layer.borderColor=wh_RGB(240, 240, 240).CGColor;
    return self;
}

-(void)setModel:(KGOrderModel *)model
{
    if (_model!=model)
    {
        _model=model;
    }
    [self setCellUI];
}

-(void)setCellUI
{
    [h_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kNewWordBaseURLString,self.model.O_CarImage]]];
    h_time.text=[NSString stringWithFormat:@"下单时间:%@",self.model.O_Time];
    h_carNum.text=[NSString stringWithFormat:@"服务车辆:%@",self.model.O_PlateNumber];
    h_projType.text=[NSString stringWithFormat:@"服务项目:%@",self.model.O_EvaluateType];
    h_price.text=[NSString stringWithFormat:@"订单价格:%@",self.model.O_Price];
}


-(IBAction)toplaceanOrderAction:(UIButton *)sender
{
    self.btnBlovk(self.model,sender.tag);
}
@end
