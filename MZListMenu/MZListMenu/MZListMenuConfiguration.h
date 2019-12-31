//
//  MZListMenuConfiguration.h
//  MZListMenu
//
//  Created by Mr.Z on 2019/12/30.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MZListMenuType) {
    MZListMenuTypeLeftNavBar = 0,
    MZListMenuTypeRightNavBar,
    MZListMenuTypeLeftNormal,
    MZListMenuTypeMidNormal,
    MZListMenuTypeRightNormal,
};

@interface MZListMenuConfiguration : NSObject

@property (nonatomic, strong) UIColor *menuViewBackgroundColor;

@property (nonatomic, strong) UIColor *menuViewLineColor;

@property (nonatomic, assign) CGFloat menuTriangleWidth;

@property (nonatomic, assign) CGFloat menuTriangleHeight;

@property (nonatomic, assign) CGFloat menuItemWidth;

@property (nonatomic, assign) CGFloat menuItemHeight;

@property (nonatomic, strong) UIColor *menuItemTitleColor;

@property (nonatomic, strong) UIFont *menuItemTitleFont;

@property (nonatomic, assign) MZListMenuType menuType;

+ (instancetype)defualt;

@end

NS_ASSUME_NONNULL_END
