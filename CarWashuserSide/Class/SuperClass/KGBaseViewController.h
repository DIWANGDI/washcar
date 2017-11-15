//
//  KGBaseViewController.h
//  Aerospace
//
//  Created by mac on 16/10/18.
//  Copyright © 2016年 王迪. All rights reserved.
//


@interface KGBaseViewController : UIViewController
@property(nonatomic,strong)UIView       *navBackView;
@property(nonatomic,strong)UIButton     *navLetfItem;
@property(nonatomic,strong)UIButton     *navRightItem;
@property(nonatomic,strong)UILabel      *navTitleLab;

///返回事件
-(void)leftItemBtnAction;
-(void)rightItemBtnAction:(UIButton *)sender;

@end
