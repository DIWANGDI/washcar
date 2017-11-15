//
//  JYYueDetailController.m
//  CarWashuserSide
//
//  Created by apple on 2017/11/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JYYueDetailController.h"
#import "ConsumeModel.h"
#import "ConstumCell.h"

@interface JYYueDetailController ()

@end

@implementation JYYueDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLab.text=@"消费明细";
    [self setTableViewMethod];
    [self.tableView.mj_header beginRefreshing];
}

-(void)setTableViewMethod
{
    [self.tableView cb_makeDataSource:^(CBTableViewDataSourceMaker *make) {
        [make makeSection:^(CBTableViewSectionMaker *section) {
            section.data(self.arrayDataItems)
            .cell([ConstumCell class])
            .adapter(^(ConstumCell *cell,ConsumeModel *model,NSUInteger index)
                     {
                         cell.selectionStyle=UITableViewCellSelectionStyleNone;
                         cell.model=model;
                     })
            .event(^(NSUInteger index, ConsumeModel *model)
                   {
                   })
            .height(100);
        }];
    }];
}

-(void)loadData
{
    NSMutableDictionary *parms=[@{
                                  @"O_UTel":configEmpty([[OWTool Instance] getLoginUserInform][@"U_Tel"])
                                  }mutableCopy];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkgetXiaofeiDeail withUserInfo:parms success:^(NSDictionary *message,NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else
         {
             NSArray *dataArr;
             dataArr=[ConsumeModel mj_objectArrayWithKeyValuesArray:message];
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
