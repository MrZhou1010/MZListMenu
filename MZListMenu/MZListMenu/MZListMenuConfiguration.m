//
//  MZListMenuConfiguration.m
//  MZListMenu
//
//  Created by Mr.Z on 2019/12/30.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import "MZListMenuConfiguration.h"

@implementation MZListMenuConfiguration

- (instancetype)init {
    if (self = [super init]) {
        self.menuViewBackgroundColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        self.menuViewLineColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        self.menuTriangleWidth = 16.0;
        self.menuTriangleHeight = 10.0;
        self.menuItemWidth = 120.0;
        self.menuItemHeight = 45.0;
        self.menuItemTitleColor = [UIColor whiteColor];;
        self.menuItemTitleFont = [UIFont systemFontOfSize:16.0];
        self.menuType = MZListMenuTypeRightNavBar;
    }
    return self;
}

+ (instancetype)defaultConfiguration {
    static MZListMenuConfiguration *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

@end
