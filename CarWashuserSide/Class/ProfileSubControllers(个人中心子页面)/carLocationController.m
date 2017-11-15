//
//  carLocationController.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "carLocationController.h"
#import "addressListModel.h"

@interface carLocationController ()

@end

@implementation carLocationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitleLab.text=@"常用地址";
    [self.tableView.mj_footer setHidden:YES];
    [self SetTableviewMethod];
    [self.tableView.mj_header beginRefreshing];
}

-(void)loadData
{
    NSMutableDictionary *parms=[@{
                                  @"A_UTel":configEmpty([[OWTool Instance] getLoginUserInform][@"U_Tel"])
                                  }mutableCopy];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkgetChangyongaddress withUserInfo:parms success:^(NSArray *message,NSString *errorMsg,NSString *okStr)
     {
         if (errorMsg.length>0)
         {
             [SVProgressHUD showErrorWithStatus:errorMsg];
         }
         else
         {
             [self.arrayDataItems removeAllObjects];
             NSArray    *addresslist=[addressListModel mj_objectArrayWithKeyValuesArray:message];
             [self.arrayDataItems addObjectsFromArray:addresslist];
             [self.tableView reloadData];
         }
         [self.tableView.mj_header endRefreshing];
     } failure:^(NSError *error)
    {
    } visibleHUD:NO];
}

-(void)SetTableviewMethod
{
    NSDictionary *logerDic=[[OWTool Instance] getLoginUserInform];
    [self.tableView cb_makeDataSource:^(CBTableViewDataSourceMaker *make)
    {
        [make makeSection:^(CBTableViewSectionMaker *section) {
            section.data(@[logerDic[@"U_Home"]])
            .cell([UITableViewCell class])
            .adapter(^(UITableViewCell *cell,NSString *model,NSUInteger index)
                     {
                         UIImageView    *img1=[cell.contentView viewWithTag:1000];
                         UILabel         *lab1=[cell.contentView viewWithTag:2000];
                         if (img1==nil)
                         {
                             img1=[[UIImageView alloc] initWithFrame:CGRectMake(20, 14, 22, 22)];
                             img1.tag=1000;
                             [cell.contentView addSubview:img1];
                         }
                         if (lab1==nil)
                         {
                             lab1=[[UILabel alloc] initWithFrame:CGRectMake(55, 0, winsize.width-60, 50)];
                             
                             [cell.contentView addSubview:lab1];
                             lab1.tag=2000;
                         }
                         img1.image=UIImageNamed(@"M_User_home");
                         lab1.text=[NSString stringWithFormat:@"家: %@",model];
                     })
            .event(^(NSUInteger index, NSString *model)
                   {
                       self.sendAddressBlock(model);
                       [self.navigationController popViewControllerAnimated:YES];
                   })
            .height(50);
        }];
        
        [make makeSection:^(CBTableViewSectionMaker *section) {
            section.data(@[logerDic[@"U_Office"]])
            .cell([UITableViewCell class])
            .adapter(^(UITableViewCell *cell,NSString *model,NSUInteger index)
                     {
                         UIImageView    *img1=[cell.contentView viewWithTag:1000];
                         UILabel         *lab1=[cell.contentView viewWithTag:2000];
                         if (img1==nil)
                         {
                             img1=[[UIImageView alloc] initWithFrame:CGRectMake(20, 14, 22, 22)];
                             img1.tag=1000;
                             [cell.contentView addSubview:img1];
                         }
                         if (lab1==nil)
                         {
                             lab1=[[UILabel alloc] initWithFrame:CGRectMake(55, 0, winsize.width-60, 50)];
                             
                             [cell.contentView addSubview:lab1];
                             lab1.tag=2000;
                         }
                         
                         img1.image=UIImageNamed(@"M_User_office");
                         lab1.text=[NSString stringWithFormat:@"公司: %@",model];
                     })
            .event(^(NSUInteger index, NSString *model)
                   {
                       self.sendAddressBlock(model);
                       [self.navigationController popViewControllerAnimated:YES];
                   })
            .height(50);
        }];
        [make makeSection:^(CBTableViewSectionMaker *section) {
            section.data(self.arrayDataItems)
            .cell([UITableViewCell class])
            .adapter(^(UITableViewCell *cell,addressListModel *model,NSUInteger index)
            {   
                UIImageView    *img1=[cell.contentView viewWithTag:1000];
                UILabel         *lab1=[cell.contentView viewWithTag:2000];
                if (img1==nil)
                {
                    img1=[[UIImageView alloc] initWithFrame:CGRectMake(20, 11, 22, 28)];
                    img1.tag=1000;
                    [cell.contentView addSubview:img1];
                }
                if (lab1==nil)
                {
                    lab1=[[UILabel alloc] initWithFrame:CGRectMake(55, 0, winsize.width-60, 50)];
                    
                    [cell.contentView addSubview:lab1];
                    lab1.tag=2000;
                }
                
                img1.image=UIImageNamed(@"M_Car_location");
                lab1.text=model.A_Adress;

            })
            .event(^(NSUInteger index, addressListModel *model)
             {
                 self.sendAddressBlock(model.A_Adress);
                 [self.navigationController popViewControllerAnimated:YES];
             })
            .height(50);
            [make commitEditing:^(UITableView *tableView, UITableViewCellEditingStyle *editingStyle, NSIndexPath *indexPath) {
                [self deleteAddress:self.arrayDataItems[indexPath.row]];
            }];
        }];
    }];
}

-(void)deleteAddress:(addressListModel *)model
{
    NSMutableDictionary *parms=[@{
                                  @"A_ID":model.A_ID,
                                  @"A_UTel":model.A_UTel
                                  }mutableCopy];
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkDeledeAddress withUserInfo:parms success:^(id message, NSString *errorMsg,NSString *okStr)
    {
        if (errorMsg.length>0)
        {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        else if (okStr.length>0)
        {
            [SVProgressHUD showWithStatus:@"修改成功"];
            
        }
    } failure:^(NSError *error) {
        
    } visibleHUD:NO];
}
@end
