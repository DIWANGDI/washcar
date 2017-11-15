//
//  NSObject+XYExt.m
//  Tang
//
//  Created by 王小军 on 14/12/4.
//  Copyright (c) 2014年 Aaron Yu. All rights reserved.
//

#import "NSObject+XYExt.h"
#import <objc/runtime.h>

static void * const XYExtensionKey = @"com.XYExtensionKey";

@implementation NSObject (XYExt)

- (void)setExtensionInfo:(id)info{

    objc_setAssociatedObject(self, XYExtensionKey, info, OBJC_ASSOCIATION_RETAIN);
}

- (id)extensionInfo{

    id extensionInfo = objc_getAssociatedObject(self, XYExtensionKey);
    return extensionInfo;
}

@end
