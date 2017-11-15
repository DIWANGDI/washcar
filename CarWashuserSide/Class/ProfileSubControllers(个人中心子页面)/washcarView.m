//
//  washcarView.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "washcarView.h"
#import "UserDatePicker.h"
#import "MycarListModel.h"
#import "PtOrderListModel.h"

@implementation washcarView
{
    NSString        *typeStr;
    IBOutlet        UILabel         *chewailab;
    IBOutlet        UILabel         *biaozhunlab;
    IBOutlet        UILabel         *fadongjilab;
    IBOutlet        UILabel         *dalalab;
    IBOutlet        UILabel         *shineilab;
    IBOutlet        UILabel         *kongtiaolab;
    PtOrderListModel                *chewaiModel;
    PtOrderListModel                *biaozhunModel;
    PtOrderListModel                *fadongjiModel;
    PtOrderListModel                *dalaModel;
    PtOrderListModel                *shineiModel;
    PtOrderListModel                *kongtiaoModel;
    
    NSMutableArray                  *ptorderArr;
}

-(instancetype)initWithFrame:(CGRect)frame andModel:(NSMutableArray *)modelArr
{
    if (self=[super initWithFrame:frame])
    {
        self=[[NSBundle mainBundle] loadNibNamed:@"washcarView" owner:self options:nil][0];
        self.frame=frame;
    }
    ptorderArr=modelArr;
    return self;
}

-(void)setModel:(MycarListModel *)model
{
    if (_model!=model)
    {
        _model=model;
    }
    typeStr=self.model.C_CTID;
    [self setUI];
}

-(void)setUI
{
    [self.carBtn setTitle:self.model.C_PlateNumber forState:UIControlStateNormal];
    for (PtOrderListModel *ptmodel in ptorderArr)
    {
        if ([ptmodel.W_CTID isEqualToString:typeStr])
        {
         //车辆类型一样
            if ([ptmodel.W_Name isEqualToString:@"车外清洗"])
            {
                chewaiModel=ptmodel;
                chewailab.text=[NSString stringWithFormat:@"%@元",ptmodel.W_Price];
            }
            else if ([ptmodel.W_Name isEqualToString:@"车内外清洗"])
            {
                //标准清洗
                biaozhunModel=ptmodel;
                biaozhunlab.text=[NSString stringWithFormat:@"%@元",ptmodel.W_Price];
            }
            else if ([ptmodel.W_Name isEqualToString:@"发动机清洗"])
            {
                fadongjiModel=ptmodel;
                fadongjilab.text=[NSString stringWithFormat:@"%@元",ptmodel.W_Price];
            }
            else if ([ptmodel.W_Name isEqualToString:@"打蜡"])
            {
                dalaModel=ptmodel;
                dalalab.text=[NSString stringWithFormat:@"%@元",ptmodel.W_Price];
            }
            else if ([ptmodel.W_Name isEqualToString:@"室内精洗"])
            {
                shineiModel=ptmodel;
                shineilab.text=[NSString stringWithFormat:@"%@元",ptmodel.W_Price];
            }
            else if ([ptmodel.W_Name isEqualToString:@"空调消毒"])
            {
                kongtiaoModel=ptmodel;
                kongtiaolab.text=[NSString stringWithFormat:@"%@元",ptmodel.W_Price];
            }
        }
    }
}

-(IBAction)BtnSelectAction:(UIButton *)sender
{
    NSInteger tag=sender.tag;
    UIImage *yuanshiImg=[UIImage imageNamed:@"Wsh_Car_unselect"];
    NSData *data1 = UIImagePNGRepresentation(sender.imageView.image);
    NSData *data2 = UIImagePNGRepresentation(yuanshiImg);
    if (tag==100)
    {
        //车外清洗
        if ([data1 isEqualToData:data2])
        {
            //没选
            [sender setImage:UIImageNamed(@"Wsh_Car_selected") forState:UIControlStateNormal];
            self.car_chewaiqingxi=[NSString stringWithFormat:@"%@,%@",chewaiModel.W_ID,chewaiModel.W_Price];
        }
        else
        {
            self.car_chewaiqingxi=@"";
            [sender setImage:UIImageNamed(@"Wsh_Car_unselect") forState:UIControlStateNormal];
        }
        self.getTotalMoneyBlock();
    }
    else if (tag==200)
    {
        //标准清洗
        if ([data1 isEqualToData:data2])
        {
            //没选
            [sender setImage:UIImageNamed(@"Wsh_Car_selected") forState:UIControlStateNormal];
            self.car_biaozhunqingxi=[NSString stringWithFormat:@"%@,%@",biaozhunModel.W_ID,biaozhunModel.W_Price];
        }
        else
        {
            self.car_biaozhunqingxi=@"";
            [sender setImage:UIImageNamed(@"Wsh_Car_unselect") forState:UIControlStateNormal];
        }
        self.getTotalMoneyBlock();
    }
    else if (tag==300)
    {
        //发动机清洗
        if ([data1 isEqualToData:data2])
        {
            //没选
            [sender setImage:UIImageNamed(@"Wsh_Car_selected") forState:UIControlStateNormal];
            self.car_fadongjiqingxi=[NSString stringWithFormat:@"%@,%@",fadongjiModel.W_ID,fadongjiModel.W_Price];
        }
        else
        {
            self.car_fadongjiqingxi=@"";
            [sender setImage:UIImageNamed(@"Wsh_Car_unselect") forState:UIControlStateNormal];
        }
        self.getTotalMoneyBlock();
        
    }else if (tag==400)
    {
        //打蜡
        if ([data1 isEqualToData:data2])
        {
            //没选
            [sender setImage:UIImageNamed(@"Wsh_Car_selected") forState:UIControlStateNormal];
            self.car_dala=[NSString stringWithFormat:@"%@,%@",dalaModel.W_ID,dalaModel.W_Price];
        }
        else
        {
            self.car_dala=@"";
            [sender setImage:UIImageNamed(@"Wsh_Car_unselect") forState:UIControlStateNormal];
        }
        self.getTotalMoneyBlock();
    }else if (tag==500)
    {
        //室内精选
        if ([data1 isEqualToData:data2])
        {
            //没选
            [sender setImage:UIImageNamed(@"Wsh_Car_selected") forState:UIControlStateNormal];
            self.car_shineijingxuan=[NSString stringWithFormat:@"%@,%@",shineiModel.W_ID,shineiModel.W_Price];
        }
        else
        {
            self.car_shineijingxuan=@"";
            [sender setImage:UIImageNamed(@"Wsh_Car_unselect") forState:UIControlStateNormal];
        }
        self.getTotalMoneyBlock();
    }else if (tag==600)
    {
        //空调消毒
        if ([data1 isEqualToData:data2])
        {
            //没选
            [sender setImage:UIImageNamed(@"Wsh_Car_selected") forState:UIControlStateNormal];
            self.car_kongtiaoxiaodu=[NSString stringWithFormat:@"%@,%@",kongtiaoModel.W_ID,kongtiaoModel.W_Price];
        }
        else
        {
            self.car_kongtiaoxiaodu=@"";
            [sender setImage:UIImageNamed(@"Wsh_Car_unselect") forState:UIControlStateNormal];
        }
        self.getTotalMoneyBlock();
    }else if (tag==700||tag==800||tag==900)
    {
        self.pushBlock(sender);
        
    }
    else if (tag==1000)
    {
        //服务时间
        UserDatePicker *datePick=[UserDatePicker UserDatePicker];
        [datePick setTitle:@"时间选择"];
        datePick.UserDateBlock=^(UserDatePicker *picker, NSString *date, NSString *udate)
        {
            [sender setTitle:date forState:UIControlStateNormal];
            NSLog(@"%@\n%@",date,udate);
        };
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    DismissKeyboard;
    return YES;
}
@end


