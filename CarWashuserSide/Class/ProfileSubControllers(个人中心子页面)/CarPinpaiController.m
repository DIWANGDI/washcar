//
//  CarPinpaiController.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CarPinpaiController.h"
#import "PinPaiModel.h"
#import "XinghaoController.h"

@interface CarPinpaiController ()<UISearchBarDelegate>
@property(nonatomic,strong)UISearchBar         *m_SearchBar;
@property(nonatomic,strong)NSMutableArray        *pinYinArray;
@end

@implementation CarPinpaiController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arrayDataItems=[NSMutableArray array];
    self.pinYinArray=[NSMutableArray array];
    [self setTableviewMethod];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_footer setHidden:YES];
    
    [self.navTitleLab setHidden:YES];
    _m_SearchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(winsize.width/2-130, 20, 260, 44)];
    _m_SearchBar.delegate=self;
    _m_SearchBar.placeholder=@"搜索";
    [self.navBackView addSubview:_m_SearchBar];
    self.m_SearchBar.backgroundImage=[[UIImage  alloc] init];
}

-(void)setTableviewMethod
{
    [self.tableView cb_makeDataSource:^(CBTableViewDataSourceMaker *make) {
        [make makeSection:^(CBTableViewSectionMaker *section)
         {
             section.data(self.pinYinArray)
             .cell([UITableViewCell class])
             .adapter(^(UITableViewCell *cell,PinPaiModel *model,NSUInteger index)
                      {
                          cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                          cell.textLabel.text=model.CB_BrandName;
                      })
             .event(^(NSUInteger index, PinPaiModel *model)
                    {

                        XinghaoController *xinghaoVc=[[XinghaoController alloc] init];
                        xinghaoVc.CBT_BrandName=model.CB_BrandName;
                        [self.navigationController pushViewController:xinghaoVc animated:YES];
                    })
             .height(50);
         }];
    }];
}

-(void)loadData
{
    [[KGNetworkManager sharedInstance] invokeNetWorkAPIWith:KNetWorkgetPinpaiList withUserInfo:nil success:^(NSArray *message, NSString *errorMsg,NSString *okStr)
    {
        if (errorMsg.length>0)
        {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        else
        {
            NSArray    *locatioinArr=[PinPaiModel mj_objectArrayWithKeyValuesArray:message];
            [self.arrayDataItems addObjectsFromArray:locatioinArr];
            [self.pinYinArray addObjectsFromArray:locatioinArr];
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error)
     {
         
     } visibleHUD:NO];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchString:searchText];
}

-(void)searchString:(NSString *)string
{
    
    [self.pinYinArray removeAllObjects];
    if (string.length==0)
    {
        [self.pinYinArray addObjectsFromArray:self.arrayDataItems];
    }
    [self.arrayDataItems enumerateObjectsUsingBlock:^(PinPaiModel *model, NSUInteger idx, BOOL * _Nonnull stop)
    {
        if ([model.CB_BrandName containsString:string])
        {
            [self.pinYinArray addObject:model];
        }
    }];

    [self.tableView reloadData];
}

@end
