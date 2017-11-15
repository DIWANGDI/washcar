//
//  DJQController.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DJQController.h"
#import "DJQCell.h"

@interface DJQController ()

@end

@implementation DJQController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitleLab.text=@"我的代金券";
    [self setTableMethod];
    [self.tableView.mj_footer setHidden:YES];
    [self.tableView.mj_header beginRefreshing];
}

-(void)loadData
{
    NSMutableDictionary *parms=[@{
                                  @"T_UTel":configEmpty([[OWTool Instance] getLoginUserInform][@"U_Tel"])
                                  }mutableCopy];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkGetuserDJQlist withUserInfo:parms success:^(NSArray *message, NSString *errorMsg,NSString *okStr)
    {
        if (errorMsg.length>0)
        {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        else
        {
            [self.arrayDataItems removeAllObjects];
            [self.arrayDataItems addObjectsFromArray:message];
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error)
    {
    
    } visibleHUD:NO];
}

-(void)setTableMethod
{
    [self.tableView cb_makeDataSource:^(CBTableViewDataSourceMaker *make)
    {
        [make makeSection:^(CBTableViewSectionMaker *section) {
            section.data(self.arrayDataItems)
            .cell([DJQCell class])
            .adapter(^(DJQCell *cell,NSDictionary *model,NSUInteger index)
            {
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.modelDic=model;
            })
            .event(^(NSUInteger index, NSDictionary *model)
            {
                if (_isFromMemberCenter)
                {
                    return ;
                }
                //满多少可用
                NSString *T_Money=configEmpty(model[@"T_Money"]);
                if (self.totalPayMoney>=T_Money.doubleValue)
                {
                    self.sendCountAndIDBlock(configEmpty(model[@"T_Ticket"]),configEmpty(model[@"T_ID"]),T_Money);
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"金额满%@才可以使用",T_Money]];
                }
            })
            .height(100);
        }];
    }];
}



@end
