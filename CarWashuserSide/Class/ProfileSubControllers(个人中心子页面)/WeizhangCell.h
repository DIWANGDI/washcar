//
//  WeizhangCell.h
//  CarWashuserSide
//
//  Created by apple on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiguiModel.h"

@interface WeizhangCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel       *timeLab;
@property(nonatomic,weak)IBOutlet UILabel       *addressLab;
@property(nonatomic,weak)IBOutlet UILabel       *reasonLab;
@property(nonatomic,weak)IBOutlet UILabel       *ScoreLab;
@property(nonatomic,weak)IBOutlet UILabel       *costLab;
@property(nonatomic,weak)IBOutlet UILabel       *scoreImg;
@property(nonatomic,weak)IBOutlet UILabel       *moneyImg;
@property(nonatomic,strong)WeiguiModel             *model;
@end
