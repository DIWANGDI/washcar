//
//  AppDelegate.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "JYJPersonViewController.h"
#import "JYJMyWalletViewController.h"
#import "JYJMyOrderViewController.h"
#import "JYJMysettingViewController.h"
#import "JYJMycarViewController.h"
#import "JYJCommenItem.h"
#import "JYJProfileCell.h"
#import "JYJPushBaseViewController.h"
#import "JYJAnimateViewController.h"
#import "JYJHelpViewController.h"
#import "JYJLoginController.h"
#import "CKAlertViewController.h"
#import "InformEditController.h"

@interface JYJPersonViewController () <UITableViewDelegate, UITableViewDataSource>
/** tableView */
@property (nonatomic, weak) UITableView *tableView;
/** headerIcon */
@property (nonatomic, weak) UIImageView *headerIcon;
@property (nonatomic, weak) UILabel         *nameLab;
@property (nonatomic, weak) UILabel         *vipLab;
/** data */
@property (nonatomic, strong) NSArray *data;
@end

@implementation JYJPersonViewController

- (NSArray *)data {
    if (!_data) {
        self.data = [NSArray array];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.frame = self.view.bounds;
    self.headerIcon.frame = CGRectMake(self.tableView.frame.size.width / 2 - 36, 90, 72, 72);
    self.nameLab.frame=CGRectMake(0, 175, self.tableView.wh_width, 20);
    self.vipLab.frame=CGRectMake(0, 215, self.tableView.wh_width, 20);
    if ([OWTool Instance].isLogin)
    {
        self.nameLab.text=[[OWTool Instance] getLoginUserInform][@"U_Name"];
        self.vipLab.text=@"普通会员";
    }
    else
    {
        self.nameLab.text=@"未登录";
        self.vipLab.text=@"";
    }
}

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:247 / 255.0 blue:250 / 255.0 alpha:1.0];
    headerView.frame = CGRectMake(0, 0, 0, 250);
    self.tableView.tableHeaderView = headerView;
    headerView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"PH_BackGround"]];
    
    
    
    /** 头像图片 */
    NSDictionary *userInfoDic=[[OWTool Instance] getLoginUserInform];
    UIImageView *headerIcon = [[UIImageView alloc] init];
    [headerIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kNewWordBaseURLString,userInfoDic[@"U_Image"]]] placeholderImage:UIImageNamed(@"PH_UserPhoto")];
    headerIcon.frame = CGRectMake(0, 90, 72, 72);
    headerIcon.layer.cornerRadius = 36;
    headerIcon.clipsToBounds = YES;
    [headerView addSubview:headerIcon];
    self.headerIcon = headerIcon;
    headerIcon.userInteractionEnabled=YES;
    weakSelf(ws);
    [headerIcon wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer)
    {
        if ([OWTool Instance].isLogin)
        {
            InformEditController   *informVc=[[InformEditController alloc] init];
            [ws.navigationController pushViewController:informVc animated:YES];
        }
        else
        {
            JYJLoginController *loginVc=[[JYJLoginController alloc] init];
            [ws.navigationController pushViewController:loginVc animated:YES];
        }
    }];
    
    
    UILabel     *nameLab=[[UILabel alloc] init];
    nameLab.text=@"未登录";
    nameLab.textColor=[UIColor whiteColor];
    nameLab.font=[UIFont systemFontOfSize:15];
    [headerView addSubview:nameLab];
    nameLab.textAlignment=1;
    self.nameLab=nameLab;
    
    UILabel     *vipLab=[[UILabel alloc] init];
    vipLab.text=@"";
    vipLab.textColor=[UIColor whiteColor];
    vipLab.font=[UIFont systemFontOfSize:20];
    [headerView addSubview:vipLab];
    vipLab.textAlignment=1;
    self.vipLab=vipLab;
}


- (void)setupData {
    JYJCommenItem *myWallet = [JYJCommenItem itemWithIcon:@"PH_Mywall" title:@"我的钱包" subtitle:@"" destVcClass:[JYJMyWalletViewController class]];
    
    JYJCommenItem *myCoupon = [JYJCommenItem itemWithIcon:@"PH_Order" title:@"我的订单" subtitle:@"" destVcClass:[JYJMyOrderViewController class]];
    
    JYJCommenItem *myTrip = [JYJCommenItem itemWithIcon:@"PH_Car" title:@"我的爱车" subtitle:nil destVcClass:[JYJMycarViewController class]];
    
    JYJCommenItem *myFriend = [JYJCommenItem itemWithIcon:@"PH_Setting" title:@"我的设置" subtitle:nil destVcClass:[JYJMysettingViewController class]];
    self.data = @[myWallet, myCoupon, myTrip, myFriend];
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建cell
    JYJProfileCell *cell = [JYJProfileCell cellWithTableView:tableView];
    cell.item = self.data[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (![[OWTool Instance] isLogin])
    {
        JYJLoginController *logVc=[[JYJLoginController alloc] init];
        [self.navigationController pushViewController:logVc animated:YES];
        return;
    }
    
    JYJCommenItem *item = self.data[indexPath.row];
    if (item.destVcClass == nil) return;
    
    JYJPushBaseViewController *vc = [[item.destVcClass alloc] init];
    vc.title = item.title;
    vc.animateViewController = (JYJAnimateViewController *)self.parentViewController;
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
}


@end
