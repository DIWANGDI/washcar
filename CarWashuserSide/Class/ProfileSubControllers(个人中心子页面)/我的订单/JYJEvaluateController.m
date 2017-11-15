//
//  JYJEvaluateController.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JYJEvaluateController.h"
#import "KGOrderModel.h"

@interface JYJEvaluateController ()
{
    IBOutlet UIImageView                *e_img;
    IBOutlet UILabel                     *e_name;
    IBOutlet UILabel                     *e_UserNum;
    IBOutlet UILabel                     *e_orderID;
    IBOutlet UILabel                     *e_Phone;
    IBOutlet UITextView                 *e_TextView;
    IBOutletCollection(UIButton)NSArray  *e_starArr;
    IBOutletCollection(UIImageView)NSArray  *e_imgArr;
    NSInteger                                stars_Num;     //评价多少颗星星
    NSArray                                 *TypeSelectArr;
    NSMutableArray                           *TypeSelectTitleArr;
    BOOL                                    isNiming;      //是否匿名
}
@end

@implementation JYJEvaluateController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        DismissKeyboard;
    }];
    stars_Num=0;
    TypeSelectTitleArr=[NSMutableArray array];
    isNiming=NO;
    TypeSelectArr=@[@"服务周到",@"洗车专业",@"准时到达",@"风雨无阻",@"穿着整洁"];
    self.navTitleLab.text=@"评价";
    [self setUI];
}

-(void)setUI
{
    UIButton  *leftBtn=[self.view viewWithTag:10];
    UIButton   *rightBtn=[self.view viewWithTag:20];
    leftBtn.layer.borderWidth=1;
    rightBtn.layer.borderWidth=1;
    leftBtn.layer.borderColor=wh_RGB(0, 146, 159).CGColor;
    rightBtn.layer.borderColor=wh_RGB(0, 146, 159).CGColor;
    e_TextView.layer.borderWidth=1;
    e_TextView.layer.borderColor=wh_RGB(256, 256, 256).CGColor;
    e_img.layer.masksToBounds=YES;
    e_img.layer.cornerRadius=e_img.wh_height/2;
    e_TextView.layer.borderWidth=1;
    e_TextView.layer.cornerRadius=5;
    e_TextView.layer.borderColor=wh_RGB(233, 233, 233).CGColor;
    
    [e_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kNewWordBaseURLString,self.model.O_WorkerImage]]];
    e_name.text=[NSString stringWithFormat:@"姓名:%@",self.model.O_WorkerName];
    e_UserNum.text=[NSString stringWithFormat:@"工号:%@",self.model.O_WorkerID];
    e_orderID.text=[NSString stringWithFormat:@"订单号:%@",self.model.O_ID];
    e_Phone.text=[NSString stringWithFormat:@"联系方式:%@",self.model.O_WorkerTel];
}


-(IBAction)StarSelect:(UIButton *)sender
{
    NSInteger index=sender.tag/1000-1;
    for (NSInteger i=0; i<e_starArr.count; i++)
    {
        UIButton  *starBtn=e_starArr[i];
        if (i<=index)
        {
            [starBtn setImage:UIImageNamed(@"m_Start_select") forState:UIControlStateNormal];
        }
        else
        {
            [starBtn setImage:UIImageNamed(@"M_start_nuSelect") forState:UIControlStateNormal];
        }
    }
    stars_Num=index+1;
}

-(IBAction)TypeSelectAction:(UIButton *)sender
{
    NSInteger index=sender.tag/100-1;
    UIImageView *img=e_imgArr[index];

    UIImage *yuanshiImg=[UIImage imageNamed:@"M_UnChoose"];
    NSData *data1 = UIImagePNGRepresentation(img.image);
    NSData *data2 = UIImagePNGRepresentation(yuanshiImg);
    if ([data1 isEqualToData:data2])
    {
        //如果是选中状态，点击则取消选中
        img.image=UIImageNamed(@"M_Choosed_Btn");
        if (index==5)
        {
            //匿名
            isNiming=NO;
        }
        else
        {
            [TypeSelectTitleArr removeObject:TypeSelectArr[index]];
        }
    }
    else
    {
        img.image=UIImageNamed(@"M_UnChoose");
        if (index==5)
        {
            isNiming=YES;
        }
        else
        {
            [TypeSelectTitleArr addObject:TypeSelectArr[index]];
        }
    }
}

-(IBAction)subbmitAction:(UIButton *)sender
{
    NSInteger tag=sender.tag;
    if (tag==10)
    {
        //打赏
    }
    else
    {
        //提交
        NSLog(@"--星级-%zi---选中的标题-%@--是否匿名%d",stars_Num,[TypeSelectTitleArr mj_JSONString],isNiming);
//        
//        [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkPingjia withUserInfo:<#(NSMutableDictionary *)#> success:<#^(id message)successBlock#> failure:<#^(NSError *error)failureBlock#> visibleHUD:<#(BOOL)#>];
    }
}
@end



















