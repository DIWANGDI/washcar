//
//  OrderPageController.m
//  Aerospace
//
//  Created by 王迪 on 2016/12/27.
//  Copyright © 2016年 王迪. All rights reserved.
//


#import "UIImage+MKExtension.h"

@implementation UIImage(MKExtension)

+ (UIImage *)imageWithColor:(UIColor *)color;{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
