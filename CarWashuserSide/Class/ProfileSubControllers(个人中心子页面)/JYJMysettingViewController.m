//
//  AppDelegate.m
//  CarWashuserSide
//
//  Created by apple on 2017/10/14.
//  Copyright © 2017年 apple. All rights reserved.
//
#import "JYJMysettingViewController.h"
#import "KGTableviewCellModel.h"
#import "SetPasswordController.h"
#import "CKAlertViewController.h"

@interface JYJMysettingViewController ()
@property (nonatomic,strong) UITableView        *tableView;
@property (nonatomic,strong)NSMutableArray      *arrayDataItems;
@end

@implementation JYJMysettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor colorWithHexString:KG_COLOR_SEPARATORLINE];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
    [self createUIAndLoadData];
    [self loadData];
}
-(void)createUIAndLoadData
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.wh_width, 80)];
    footerView.backgroundColor = [UIColor clearColor];
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.layer.cornerRadius = 5;
    logoutButton.backgroundColor = wh_RGB(24, 149, 162);
    [logoutButton setTitle:@"退出账号" forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    logoutButton.frame = CGRectMake(16,20, self.view.wh_width - 32, 40);
    [logoutButton wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer)
    {
        CKAlertViewController *alert=[CKAlertViewController alertControllerWithTitle:@"" message:@"确认退出"];
        CKAlertAction *cancel=[CKAlertAction actionWithTitle:@"取消" handler:nil];
        CKAlertAction  *sure=[CKAlertAction actionWithTitle:@"退出" handler:^(CKAlertAction *action)
        {
            [OWTool Instance].isLogin=NO;
        }];
        [alert addAction:cancel];
        [alert addAction:sure];
        [self presentViewController:alert animated:NO completion:nil];
    }];
    [footerView addSubview:logoutButton];
    self.tableView.tableFooterView = footerView;
}

-(void)loadData
{
    self.arrayDataItems=[NSMutableArray array];
    KGTableviewCellModel *model=[[KGTableviewCellModel alloc] init];
    model.title=@"修改密码";
    model.imageName=@"M_Setting_pass";
    [self.arrayDataItems addObject:model];
    
    model=[[KGTableviewCellModel alloc] init];
    model.title=@"常用地址";
    model.imageName=@"M_Setting_address";
    [self.arrayDataItems addObject:model];
    
    model=[[KGTableviewCellModel alloc] init];
    model.title=@"洗完车，给我电话";
    model.imageName=@"M_Setting_address";
    [self.arrayDataItems addObject:model];
    
    model=[[KGTableviewCellModel alloc] init];
    model.title=@"语音提示";
    model.imageName=@"M_Setting_";
    [self.arrayDataItems addObject:model];
    
    model=[[KGTableviewCellModel alloc] init];
    model.title=@"常见问题";
    model.imageName=@"M_Setting_question";
    [self.arrayDataItems addObject:model];
    
    model=[[KGTableviewCellModel alloc] init];
    model.title=@"关于我们";
    model.imageName=@"M_Setting_Aboutus";
    [self.arrayDataItems addObject:model];
    [self SetTableviewMethod];
}

-(void)SetTableviewMethod
{
    [self.tableView cb_makeDataSource:^(CBTableViewDataSourceMaker *make) {
        [make makeSection:^(CBTableViewSectionMaker *section) {
            section.data(self.arrayDataItems)
            .cell([UITableViewCell class])
            .adapter(^(UITableViewCell *cell,KGTableviewCellModel *model,NSUInteger index)
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
                   img1.image=UIImageNamed(model.imageName);
                   lab1.text=model.title;
                   if (index==2||index==3)
                   {
                       UISwitch *sw=[[UISwitch alloc] init];
                       [cell.contentView addSubview:sw];
                       [sw mas_makeConstraints:^(MASConstraintMaker *make) {
                           make.top.offset(5);
                           make.bottom.offset(-5);
                           make.right.offset(-40);
                           make.width.mas_equalTo(30);
                       }];
                       sw.tag=index;
                       if (index==2)
                       {
                           if ([[OWTool Instance] getIsCallState].intValue==1)
                           {
                               [sw setOn:YES];
                           }
                           else
                           {
                               [sw setOn:NO];
                           }
                       }
                       else
                       {
                           if ([[OWTool Instance] getOpenYuyin].intValue==1)
                           {
                               [sw setOn:YES];
                           }
                           else
                           {
                               [sw setOn:NO];
                           }
                       }
                       [sw addTarget:self action:@selector(openOrClose:) forControlEvents:UIControlEventValueChanged];
                   }
               })
            .event(^(NSUInteger index, id row)
             {
                 [self eventAction:index];
             })
            .height(45);
        }];
    }];
}

-(void)openOrClose:(UISwitch *)sw
{
    if (sw.tag==2)
    {
        [[OWTool Instance] SaveisCallWhenFinishWash:sw.on?@"0":@"1"];
        [sw setOn:!sw.on];
    }
    else
    {
        [[OWTool Instance] isOpenYUYinL:sw.on?@"0":@"1"];
         [sw setOn:!sw.on];
    }
}

-(void)eventAction:(NSUInteger)tag
{
    if (tag==0)
    {
        SetPasswordController *setVc=[[SetPasswordController alloc] init];
        [self.navigationController pushViewController:setVc animated:YES];
    }
}
@end

