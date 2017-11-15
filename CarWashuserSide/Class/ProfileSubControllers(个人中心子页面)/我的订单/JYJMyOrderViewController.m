//
//  JYJMyOrderViewController.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JYJMyOrderViewController.h"
#import "KGOrderlistCell.h"
#import "KGOrderModel.h"
#import "JYJEvaluateController.h"
#import "JYOrderDetailController.h"

@interface JYJMyOrderViewController ()<UIScrollViewDelegate>
{
    UIScrollView                       *m_Scrollview;
    UITableView                        *l_tableview;
    UITableView                        *c_tableview;
    UITableView                        *r_tableview;
    UITableView                        *last_tableview;
    IBOutlet UIView                   *m_line;
    int                                  l_currentPageIndex;
    int                                  c_currentPageIndex;
    int                                  r_currentPageIndex;
    int                                  last_currentPageIndex;
    NSMutableArray                    *l_arrItemArr;
    NSMutableArray                    *c_arrItemArr;
    NSMutableArray                    *r_arrItemArr;
    NSMutableArray                    *last_arrItemArr;
}
@end

@implementation JYJMyOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    l_arrItemArr=[NSMutableArray array];
    c_arrItemArr=[NSMutableArray array];
    r_arrItemArr=[NSMutableArray array];
    last_arrItemArr=[NSMutableArray array];
    [self setTableviewUI];
}

-(void)setTableviewUI
{
    m_Scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, winsize.width, winsize.height-52)];
    m_Scrollview.delegate=self;
    m_Scrollview.backgroundColor=[UIColor whiteColor];
    m_Scrollview.contentSize = CGSizeMake(4*winsize.width, 0);
    m_Scrollview.contentOffset = CGPointMake(0, 0);
    m_Scrollview.pagingEnabled = YES;
    m_Scrollview.bounces = NO;
    m_Scrollview.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:m_Scrollview];

    l_tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, winsize.width, m_Scrollview.wh_height) style:UITableViewStylePlain];
    l_tableview.showsVerticalScrollIndicator = NO;
    l_tableview.backgroundColor = [UIColor clearColor];
    l_tableview.separatorColor = [UIColor colorWithHexString:KG_COLOR_SEPARATORLINE];
    l_tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [m_Scrollview addSubview:l_tableview];
    
    c_tableview = [[UITableView alloc] initWithFrame:CGRectMake(winsize.width, 0, winsize.width, m_Scrollview.wh_height) style:UITableViewStylePlain];
    c_tableview.showsVerticalScrollIndicator = NO;
    c_tableview.backgroundColor = [UIColor clearColor];
    c_tableview.separatorColor = [UIColor colorWithHexString:KG_COLOR_SEPARATORLINE];
    c_tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [m_Scrollview addSubview:c_tableview];
    
    r_tableview = [[UITableView alloc] initWithFrame:CGRectMake(winsize.width*2, 0, winsize.width, m_Scrollview.wh_height) style:UITableViewStylePlain];
    r_tableview.showsVerticalScrollIndicator = NO;
    r_tableview.backgroundColor = [UIColor clearColor];
    r_tableview.separatorColor = [UIColor colorWithHexString:KG_COLOR_SEPARATORLINE];
    r_tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [m_Scrollview addSubview:r_tableview];
    
    last_tableview = [[UITableView alloc] initWithFrame:CGRectMake(winsize.width*3, 0, winsize.width, m_Scrollview.wh_height) style:UITableViewStylePlain];
    last_tableview.showsVerticalScrollIndicator = NO;
    last_tableview.backgroundColor = [UIColor clearColor];
    last_tableview.separatorColor = [UIColor colorWithHexString:KG_COLOR_SEPARATORLINE];
    last_tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [m_Scrollview addSubview:last_tableview];
    [self SetLeftTableviewMethod];
    [self SetCentetTableviewMethod];
    [self SetRightTableviewMethod];
    [self SetLastTableviewMethod];
    [self settableviewRefreshAnimation];
    [l_tableview.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated
{
      [l_tableview.mj_header beginRefreshing];
}

-(void)settableviewRefreshAnimation
{
    weakSelf(ws);
    //设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
//    for (int i = 1; i<=151; ++i)
//    {
//        UIImage *image =[UIImage imageNamed:[NSString stringWithFormat:@"汽车－%d（被拖移）.tiff",i]];
//        [idleImages addObject:image];
//    }
//    
    MJRefreshGifHeader *l_header=[MJRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            l_currentPageIndex=1;
            [ws leftTableloadData];
        });
    }];
//    l_header.lastUpdatedTimeLabel.hidden=YES;
//    l_header.stateLabel.hidden=YES;
//    
//    [l_header setImages:idleImages forState:MJRefreshStateIdle];
//    //设置正在刷新是的动画图片
//    [l_header setImages:idleImages forState:MJRefreshStateRefreshing];
    l_tableview.mj_header=l_header;
    
    l_tableview.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [ws leftTableloadData];
        });
    }];
    
//    
//    MJRefreshGifHeader *c_header=[MJRefreshGifHeader headerWithRefreshingBlock:^{
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            c_currentPageIndex=1;
//            [ws centerTableviewloadData];
//        });
//    }];
//    c_header.lastUpdatedTimeLabel.hidden=YES;
//    c_header.stateLabel.hidden=YES;
//    
//    [c_header setImages:idleImages forState:MJRefreshStateIdle];
//    //设置正在刷新是的动画图片
//    [c_header setImages:idleImages forState:MJRefreshStateRefreshing];
//    c_tableview.mj_header=c_header;
//    
//    c_tableview.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [ws centerTableviewloadData];
//        });
//    }];
//    
//    MJRefreshGifHeader *r_header=[MJRefreshGifHeader headerWithRefreshingBlock:^{
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            r_currentPageIndex=1;
//            [ws rightTableviewLoadData];
//        });
//    }];
//    r_header.lastUpdatedTimeLabel.hidden=YES;
//    r_header.stateLabel.hidden=YES;
//    
//    [r_header setImages:idleImages forState:MJRefreshStateIdle];
//    //设置正在刷新是的动画图片
//    [r_header setImages:idleImages forState:MJRefreshStateRefreshing];
//    r_tableview.mj_header=r_header;
//    
//    r_tableview.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [ws rightTableviewLoadData];
//        });
//    }];
//    
//    MJRefreshGifHeader *last_header=[MJRefreshGifHeader headerWithRefreshingBlock:^{
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            last_currentPageIndex=1;
//            [ws lastTableviewLoadData];
//        });
//    }];
//    last_header.lastUpdatedTimeLabel.hidden=YES;
//    last_header.stateLabel.hidden=YES;
//    
//    [last_header setImages:idleImages forState:MJRefreshStateIdle];
//    //设置正在刷新是的动画图片
//    [last_header setImages:idleImages forState:MJRefreshStateRefreshing];
//    last_tableview.mj_header=last_header;
//    
//    last_tableview.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [ws lastTableviewLoadData];
//        });
//    }];
}

-(void)leftTableloadData
{
    NSMutableDictionary *parms=[@{
                                  @"O_UTel":configEmpty([[OWTool Instance] getLoginUserInform][@"U_Tel"])
                                  }mutableCopy];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkActionOrderList withUserInfo:parms success:^(NSArray *message,NSString *errorMsg,NSString *okStr)
    {
        if (errorMsg.length>0)
        {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        else
        {
            NSArray *dataArr;
            dataArr=[KGOrderModel mj_objectArrayWithKeyValuesArray:message];
            if (l_currentPageIndex==1)
            {
                [l_arrItemArr removeAllObjects];
            }
            [l_arrItemArr addObjectsFromArray:dataArr];
            
            //订单状态筛选
            [self StateChoose:l_arrItemArr];
            [l_tableview reloadData];
        }
        [l_tableview.mj_header endRefreshing];
        [l_tableview.mj_footer endRefreshing];
    } failure:^(NSError *error)
    {
        
    } visibleHUD:NO];
}

-(void)StateChoose:(NSMutableArray *)arr;
{
    [r_arrItemArr removeAllObjects];
    [c_arrItemArr removeAllObjects];
    [last_arrItemArr removeAllObjects];
    for (KGOrderModel *model in arr)
    {
        if (model.O_TypeID.intValue==1)
        {
            //待接单
            [r_arrItemArr addObject:model];
        }
        else if (model.O_TypeID.intValue==2||model.O_TypeID.intValue==3)
        {
            //进行中
            [last_arrItemArr addObject:model];
        }
        else if (model.O_TypeID.intValue==4)
        {
            //已完成
            [c_arrItemArr addObject:model];
        }
        else if (model.O_TypeID.intValue==5)
        {
            //申请退款
        }
        else if (model.O_TypeID.intValue==6)
        {
            //已退款
        }
    }
}


-(void)centerTableviewloadData
{
    [c_tableview.mj_header endRefreshing];
    [c_tableview.mj_footer endRefreshing];
}

-(void)rightTableviewLoadData
{
    [r_tableview.mj_header endRefreshing];
    [r_tableview.mj_footer endRefreshing];
}

-(void)lastTableviewLoadData
{
    [last_tableview.mj_header endRefreshing];
    [last_tableview.mj_footer endRefreshing];
}

-(void)SetLeftTableviewMethod
{
    [l_tableview cb_makeDataSource:^(CBTableViewDataSourceMaker *make) {
        [make makeSection:^(CBTableViewSectionMaker *section) {
            section.cell([KGOrderlistCell class])
            .data(l_arrItemArr)
            .adapter(^(KGOrderlistCell * cell,KGOrderModel *infoModel,NSUInteger index)
                     {
                         cell.selectionStyle=UITableViewCellSelectionStyleNone;
                         cell.model=infoModel;
                         cell.BtnBlock=^(KGOrderModel *model)
                         {
                             [self fabuWashCarRrder];
                         };
                     })
            .event(^(NSUInteger index, KGOrderModel *model)
                   {
                       JYOrderDetailController *Vc=[[JYOrderDetailController alloc] init];
                       Vc.model=model;
                       [self.navigationController pushViewController:Vc animated:YES];
                   })
            .height(160);
        }];
    }];
}

-(void)SetCentetTableviewMethod
{
    [c_tableview cb_makeDataSource:^(CBTableViewDataSourceMaker *make) {
        [make makeSection:^(CBTableViewSectionMaker *section) {
            section.cell([KGOrderHistorylistCell class])
            .data(c_arrItemArr)
            .adapter(^(KGOrderHistorylistCell * cell,KGOrderModel *infoModel,NSUInteger index)
                     {
                         cell.selectionStyle=UITableViewCellSelectionStyleNone;
                         cell.model=infoModel;
                         cell.btnBlovk=^(KGOrderModel *model,NSInteger tag)
                         {
                             if (tag==100)
                             {
                                 [self fabuWashCarRrder];
                             }
                             else
                             {
                                 JYJEvaluateController *evC=[[JYJEvaluateController alloc] init];
                                 evC.model=model;
                                 [self.navigationController pushViewController:evC animated:YES];
                             }
                         };
                     })
            .event(^(NSUInteger index, KGOrderModel *model)
                   {
                       JYOrderDetailController *Vc=[[JYOrderDetailController alloc] init];
                       Vc.model=model;
                       [self.navigationController pushViewController:Vc animated:YES];
                   })
            .height(170);
        }];
    }];
}

-(void)SetRightTableviewMethod
{
    [r_tableview cb_makeDataSource:^(CBTableViewDataSourceMaker *make) {
        [make makeSection:^(CBTableViewSectionMaker *section) {
            section.cell([KGOrderHistorylistCell class])
            .data(r_arrItemArr)
            .adapter(^(KGOrderHistorylistCell * cell,KGOrderModel *infoModel,NSUInteger index)
                     {
                         cell.selectionStyle=UITableViewCellSelectionStyleNone;
                         cell.model=infoModel;
                         cell.btnBlovk=^(KGOrderModel *model,NSInteger tag)
                         {
                             if (tag==100)
                             {
                                 [self fabuWashCarRrder];
                             }
                             else
                             {
                                 JYJEvaluateController *evC=[[JYJEvaluateController alloc] init];
                                 evC.model=model;
                                 [self.navigationController pushViewController:evC animated:YES];
                             }
                         };
                     })
            .event(^(NSUInteger index, KGOrderModel *model)
                   {
                       JYOrderDetailController *Vc=[[JYOrderDetailController alloc] init];
                       Vc.model=model;
                       [self.navigationController pushViewController:Vc animated:YES];
                   })
            .height(170);
        }];
    }];
}

-(void)SetLastTableviewMethod
{
    [last_tableview cb_makeDataSource:^(CBTableViewDataSourceMaker *make) {
        [make makeSection:^(CBTableViewSectionMaker *section) {
            section.cell([KGOrderHistorylistCell class])
            .data(last_arrItemArr)
            .adapter(^(KGOrderHistorylistCell * cell,KGOrderModel *infoModel,NSUInteger index)
                     {
                         cell.selectionStyle=UITableViewCellSelectionStyleNone;
                         cell.model=infoModel;
                         cell.btnBlovk=^(KGOrderModel *model,NSInteger tag)
                         {
                             if (tag==100)
                             {
                                 [self fabuWashCarRrder];
                             }
                             else
                             {
                                 JYJEvaluateController *evC=[[JYJEvaluateController alloc] init];
                                 evC.model=model;
                                 [self.navigationController pushViewController:evC animated:YES];
                             }
                         };
                     })
            .event(^(NSUInteger index, KGOrderModel *model)
                   {
                       JYOrderDetailController *Vc=[[JYOrderDetailController alloc] init];
                       Vc.model=model;
                       [self.navigationController pushViewController:Vc animated:YES];
                   })
            .height(170);
        }];
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page=scrollView.contentOffset.x/winsize.width;
    [self ChangeTableviewAndLineUI:page];
}

-(IBAction)BtnChangePress:(UIButton *)sender
{
    int page=(int)sender.tag/100-1;
    [self ChangeTableviewAndLineUI:page];
}

-(void)ChangeTableviewAndLineUI:(int)page
{
    [m_line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.offset(winsize.width/4*page);
    }];
    m_Scrollview.contentOffset=CGPointMake(winsize.width*page, 0);
    [self setDataOfTableview:page];
}

-(void)setDataOfTableview:(int)page
{
    if (page==0)
    {
//        if (l_arrItemArr.count==0)
//        {
//            [l_tableview.mj_header beginRefreshing];
//        }
        [l_tableview reloadData];
    }
    else if (page==1)
    {
//        if (c_arrItemArr.count==0)
//        {
//            [c_tableview.mj_header beginRefreshing];
//        }
        [c_tableview reloadData];
    }
    else if (page==2)
    {
//        if (r_arrItemArr.count==0)
//        {
//            [r_tableview.mj_header beginRefreshing];
//        }
        [r_tableview reloadData];
    }
    else
    {
//        if (last_arrItemArr.count==0)
//        {
//            [last_tableview.mj_header beginRefreshing];
//        }
        [last_tableview reloadData];
    }
}

-(void)fabuWashCarRrder
{
     [[NSNotificationCenter defaultCenter] postNotificationName:KG_ORDERFABU_NOTIFICATION object:nil];
     [self.navigationController popViewControllerAnimated:YES];
}
@end
