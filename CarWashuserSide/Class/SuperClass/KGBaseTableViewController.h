//
//  MPagethreeController.m
//  Aerospace
//
//  Created by mac on 16/10/18.
//  Copyright © 2016年 王迪. All rights reserved.
//

/*
 *
 * 可以加入一个tableview，加入下拉刷新等通用功能等
 *
 */

@interface KGBaseTableViewController : KGBaseViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrayDataItems;
@property (nonatomic,assign) BOOL separatorFull;    //分割线是否填充满
@property (nonatomic,assign) NSInteger currentPageIndex;

- (instancetype)initWithTableViewStyle:(UITableViewStyle)style;

///MJRefresh
///刷新动画
-(void)settableviewRefreshAnimation;
///加载更多动画
-(void)settableviewLoadmoreDataAnimation;
-(void)loadData;
@end
