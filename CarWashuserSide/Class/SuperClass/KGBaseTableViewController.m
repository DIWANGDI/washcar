//
//  MPagethreeController.m
//  Aerospace
//
//  Created by mac on 16/10/18.
//  Copyright © 2016年 王迪. All rights reserved.
//
#import "KGBaseTableViewController.h"

@interface KGBaseTableViewController ()

@property (nonatomic,assign) UITableViewStyle style;

@end

@implementation KGBaseTableViewController

- (instancetype)init{
    
    if (self = [super init]) {
        _currentPageIndex = 1;
        _separatorFull = NO;
        _style = UITableViewStylePlain;
        _arrayDataItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (instancetype)initWithTableViewStyle:(UITableViewStyle)style{
    
    if (self = [self init]) {
        _style = style;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
    [self settableviewRefreshAnimation];
}

- (void)initUI
{
    CGRect viewRect=self.view.bounds;
    viewRect.origin.y=64;
    viewRect.size.height-=64;
    self.tableView = [[UITableView alloc] initWithFrame:viewRect style:self.style];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor colorWithHexString:KG_COLOR_SEPARATORLINE];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
    
    //去掉kongcell的分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.arrayDataItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

//去掉viewForFooterInSection的自带颜色
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.separatorFull) {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}

-(void)viewDidLayoutSubviews{
    
    if (self.separatorFull) {
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}

///刷新动画
-(void)settableviewRefreshAnimation
{
    weakSelf(ws);
    MJRefreshGifHeader *header=[MJRefreshGifHeader headerWithRefreshingBlock:^{
        [ws refresh];
    }];
//    header.lastUpdatedTimeLabel.hidden=YES;
//    header.stateLabel.hidden=YES;
    
    
    //设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
//    for (int i = 1; i<=151; ++i)
//    {
//        UIImage *image =[UIImage imageNamed:[NSString stringWithFormat:@"汽车－%d（被拖移）.tiff",i]];
//        [idleImages addObject:image];
//    }
//    [header setImages:idleImages forState:MJRefreshStateIdle];
//    //设置正在刷新是的动画图片
//    [header setImages:idleImages forState:MJRefreshStateRefreshing];
    self.tableView.mj_header=header;
    
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [ws getMore];
    }];
}

-(void)refresh
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _currentPageIndex=1;
        [self loadData];
    });
}

-(void)getMore
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadData];
    });
}
-(void)loadData
{
    
}

@end
