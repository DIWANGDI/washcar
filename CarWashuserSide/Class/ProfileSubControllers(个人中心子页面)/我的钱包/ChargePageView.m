//
//  ChargePageView.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChargePageView.h"

@implementation ChargePageView
{
    IBOutlet UILabel                *monyCount;
    IBOutlet UIButton              *WeChat_Img;
    IBOutlet UIButton              *ZFB_Img;
    int                                Row;
}

-(void)setMoney:(NSString *)money
{
    if (_money!=money)
    {
        _money=money;
    }
    monyCount.text=money;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        self=[[NSBundle mainBundle] loadNibNamed:@"ChargePageView" owner:self options:nil][0];
        self.frame=frame;
    }
    Row=0;
    [WeChat_Img setImage:UIImageNamed(@"Wsh_Car_unselect") forState:UIControlStateNormal];
    [WeChat_Img setImage:UIImageNamed(@"Wsh_Car_selected") forState:UIControlStateSelected];
    
    [ZFB_Img setImage:UIImageNamed(@"Wsh_Car_unselect") forState:UIControlStateNormal];
    [ZFB_Img setImage:UIImageNamed(@"Wsh_Car_selected") forState:UIControlStateSelected];
    WeChat_Img.selected=YES;
    
    return self;
}

-(IBAction)BtnAction:(UIButton *)sender
{
    NSInteger tag=sender.tag;
    if (tag==100)
    {
        WeChat_Img.selected=YES;
        ZFB_Img.selected=NO;
        Row=0;
    }
    else if (tag==200)
    {
        WeChat_Img.selected=NO;
        ZFB_Img.selected=YES;
        Row=1;
    }
    else if (tag==300)
    {
        self.PayBlock(Row);
    }
    else if (tag==400)
    {
        self.dismissBlock(self);
    }
}

@end
