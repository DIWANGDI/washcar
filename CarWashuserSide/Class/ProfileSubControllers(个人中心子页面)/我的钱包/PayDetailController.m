//
//  PayDetailController.m
//  CarWashuserSide
//
//  Created by apple on 2017/11/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PayDetailController.h"
#import "PayDetailModel.h"
#import "PayDetailCell.h"

@interface PayDetailController ()

@end

@implementation PayDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLab.text=@"充值明细";
    [self setTableViewMethod];
    [self.tableView.mj_header beginRefreshing];
}

-(void)setTableViewMethod
{
    [self.tableView cb_makeDataSource:^(CBTableViewDataSourceMaker *make) {
        [make makeSection:^(CBTableViewSectionMaker *section) {
            section.data(self.arrayDataItems)
            .cell([PayDetailCell class])
            .adapter(^(PayDetailCell *cell,PayDetailModel *model,NSUInteger index)
                     {
                         cell.selectionStyle=UITableViewCellSelectionStyleNone;
                         cell.model=model;
                     })
            .event(^(NSUInteger index, PayDetailModel *model)
                   {
                   })
            .height(100);
        }];
    }];
}

-(void)loadData
{
    NSMutableDictionary *parms=[@{
                                  @"P_PayUTel":configEmpty([[OWTool Instance] getLoginUserInform][@"U_Tel"])
                                  }mutableCopy];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkChargeDetail withUserInfo:parms success:^(NSDictionary *message,NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else
         {
             NSArray *dataArr;
             dataArr=[PayDetailModel mj_objectArrayWithKeyValuesArray:message];
             if (self.currentPageIndex==1)
             {
                 [self.arrayDataItems removeAllObjects];
             }
             [self.arrayDataItems addObjectsFromArray:dataArr];
             [self.tableView reloadData];
         }
         [self.tableView.mj_header endRefreshing];
         [self.tableView.mj_footer endRefreshing];
     } failure:^(NSError *error) {
         
     } visibleHUD:NO];
}



@end
