//
//  XinghaoController.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XinghaoController.h"
#import "PinPaiModel.h"

@interface XinghaoController ()

@end

@implementation XinghaoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitleLab.text=@"型号选择";
    [self setTableviewMethod];
    [self.tableView.mj_footer setHidden:YES];
    [self.tableView.mj_header beginRefreshing];
}

-(void)setTableviewMethod
{
    [self.tableView cb_makeDataSource:^(CBTableViewDataSourceMaker *make) {
        [make makeSection:^(CBTableViewSectionMaker *section)
         {
             section.data(self.arrayDataItems)
             .cell([UITableViewCell class])
             .adapter(^(UITableViewCell *cell,XinghaoModel *model,NSUInteger index)
                      {
                          cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                          cell.textLabel.text=model.CBT_BrandTypeName;
                      })
             .event(^(NSUInteger index, XinghaoModel *model)
                    {
                        [[NSNotificationCenter defaultCenter] postNotificationName:KG_XINGHAO_NOTIFICATION object:model];
                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(self.navigationController.viewControllers.count-3)] animated:YES];
                    })
             .height(50);
         }];
    }];
}

-(void)loadData
{
    NSMutableDictionary *parms=[@{
                                  @"CBT_BrandName":self.CBT_BrandName
                                  }mutableCopy];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkgetXinghaolst withUserInfo:parms  success:^(NSArray *message, NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else
         {
             NSArray    *locatioinArr=[XinghaoModel mj_objectArrayWithKeyValuesArray:message];
             [self.arrayDataItems addObjectsFromArray:locatioinArr];
             [self.tableView reloadData];
         }
         [self.tableView.mj_header endRefreshing];
     } failure:^(NSError *error)
     {
         
     } visibleHUD:NO];
    
}

@end
