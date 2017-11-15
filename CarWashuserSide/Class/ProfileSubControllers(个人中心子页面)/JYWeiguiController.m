//
//  JYWeiguiController.m
//  CarWashuserSide
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JYWeiguiController.h"
#import "MycarListModel.h"
#import "WeizhangCell.h"
#import "WeiguiModel.h"

@interface JYWeiguiController ()

@end

@implementation JYWeiguiController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLab.text=self.model.C_PlateNumber;
    [self setTableViewMethod];
    [self.tableView.mj_header beginRefreshing];
}

-(void)loadData
{
    NSMutableDictionary *parms=[@{
                                  @"appkey":@"358027940be2843e",
//                                  @"carorg":self.model.C_Carorg,
                                  @"carorg":@"shanxi",
                                  @"lsprefix":@"陕",
                                  @"lsnum":@"A309v8",
                                  @"lstype":@"02",
                                  @"engineno":@"4383269"
//                                  @"lsprefix":self.model.C_Isprefix,
//                                  @"lsnum":[self.model.C_PlateNumber substringFromIndex:1],
//                                  @"lstype":@"02",
//                                  @"frameno":self.model.C_VIN,
////                                  @"engineno":self.model.C_MoterNumber,
//                                  @"engineno":@"4383269",
//                                  @"iscity":@"0",
//                                  @"mobile":self.model.C_CarTel
                                  }mutableCopy];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkgetWeizhangList withUserInfo:parms success:^(NSDictionary *message,NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else
         {
             NSArray *dataArr=message[@"result"][@"list"];
             NSArray    *locatioinArr=[WeiguiModel mj_objectArrayWithKeyValuesArray:dataArr];
             if (self.currentPageIndex==1)
             {
                 [self.arrayDataItems removeAllObjects];
             }
             [self.arrayDataItems addObjectsFromArray:locatioinArr];
             [self.tableView reloadData];
         }
         [self.tableView.mj_header endRefreshing];
         [self.tableView.mj_footer endRefreshing];
     } failure:^(NSError *error) {
         
     } visibleHUD:NO];
}

-(void)setTableViewMethod
{
    [self.tableView cb_makeDataSource:^(CBTableViewDataSourceMaker *make) {
        [make makeSection:^(CBTableViewSectionMaker *section) {
            section.data(self.arrayDataItems)
            .cell([WeizhangCell class])
            .adapter(^(WeizhangCell *cell,WeiguiModel *model,NSUInteger index)
                     {
                         cell.selectionStyle=UITableViewCellSelectionStyleNone;
                         cell.model=model;
                     })
            .event(^(NSUInteger index, WeiguiModel *model)
                   {
                   })
            .autoHeight();
        }];
    }];
    
}
@end
