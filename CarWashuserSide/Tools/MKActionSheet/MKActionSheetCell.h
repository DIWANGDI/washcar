//
//  OrderPageController.m
//  Aerospace
//
//  Created by 王迪 on 2016/12/27.
//  Copyright © 2016年 王迪. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MKActionSheet_select_button_tag 100

@interface MKActionSheetCell : UITableViewCell

@property (nonatomic, weak) UIButton *btnCell;
@property (nonatomic, weak) UIButton *btnSelect;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
