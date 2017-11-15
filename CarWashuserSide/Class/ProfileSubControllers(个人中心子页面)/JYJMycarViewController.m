//
//  AppDelegate.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/14.
//  Copyright © 2017年 apple. All rights reserved.
//
#import "JYJMycarViewController.h"
#import "CarCell.h"
#import "MycarListModel.h"
#import "AddCarController.h"
#import "JYJLoginController.h"

@interface JYJMycarViewController ()
{
    UITableView             *m_Tableview;
    int                       currentPageIndex;
    NSMutableArray         *arrItemArr;
}
@end

@implementation JYJMycarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    m_Tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, winsize.width, winsize.height) style:UITableViewStylePlain];
    m_Tableview.showsVerticalScrollIndicator = NO;
    m_Tableview.backgroundColor = [UIColor clearColor];
    m_Tableview.separatorColor = [UIColor colorWithHexString:KG_COLOR_SEPARATORLINE];
    m_Tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:m_Tableview];
    arrItemArr=[NSMutableArray array];
     [self SetLastTableviewMethod];
    [m_Tableview.mj_footer setHidden:YES];
    [m_Tableview.mj_header setHidden:YES];
    [self getData];
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:UIImageNamed(@"Car_Address_add") forState:UIControlStateNormal];
    rightBtn.frame=CGRectMake(20, 0, 50, 50);
    rightBtn.imageEdgeInsets=UIEdgeInsetsMake(15, 16, 15, 16);
    [rightBtn wh_addActionHandler:^(UIButton *sender)
    {
        AddCarController *carVc=[[AddCarController alloc] init];
        carVc.couldEdit=NO;
        [self.navigationController pushViewController:carVc animated:YES];
    }];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAicarList) name:KG_MYCARLISTRELOAD_NOTIFICATION object:nil];
    
}

-(void)getData
{
    [arrItemArr removeAllObjects];
    NSMutableArray *carList=[[OWTool Instance] getUserCarList];
    NSArray    *m_lessonArr=[MycarListModel mj_objectArrayWithKeyValuesArray:carList];
    [arrItemArr addObjectsFromArray:m_lessonArr];
    [m_Tableview reloadData];
}

-(void)SetLastTableviewMethod
{
    weakSelf(ws);
    [m_Tableview cb_makeDataSource:^(CBTableViewDataSourceMaker *make) {
        [make makeSection:^(CBTableViewSectionMaker *section) {
            section.data(arrItemArr)
            .cell([CarCell class])
            .adapter(^(CarCell *cell,MycarListModel *model,NSUInteger index)
                     {
                         cell.selectionStyle=UITableViewCellSelectionStyleNone;
                         cell.model=model;
                     })
            .event(^(NSUInteger index, MycarListModel *model)
                   {
                       AddCarController *carVc=[[AddCarController alloc] init];
                       carVc.model=model;
                       carVc.couldEdit=YES;
                       [ws.navigationController pushViewController:carVc animated:YES];
                   })
            .height(80);
        }];
    }];
}

-(void)getAicarList
{
    [m_Tableview.mj_header setHidden:NO];
    [m_Tableview.mj_header beginRefreshing];
    NSMutableDictionary *parms=[@{
                                  @"C_UTel":configEmpty([[OWTool Instance] getLoginUserInform][@"U_Tel"])
                                  }mutableCopy];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkMyCarlist withUserInfo:parms success:^(NSArray *message,NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else
         {
             [[OWTool Instance] saveUsercarList:message];
             [self getData];
         }
         [m_Tableview.mj_header endRefreshing];
         [m_Tableview.mj_header setHidden:YES];
     } failure:^(NSError *error) {
         
     } visibleHUD:NO];
}

@end
