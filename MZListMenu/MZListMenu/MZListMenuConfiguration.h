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

/// menu的背景颜色(默认为0.4whiteColor)
@property (nonatomic, strong) UIColor *menuViewBackgroundColor;

/// menu的间隔线颜色menu的背景颜色(默认为0.7whiteColor)
@property (nonatomic, strong) UIColor *menuViewLineColor;

/// menu的箭头的宽(默认为16.0)
@property (nonatomic, assign) CGFloat menuTriangleWidth;

/// menu的箭头的高(默认为10.0)
@property (nonatomic, assign) CGFloat menuTriangleHeight;

/// menu的item的宽(默认为120.0)
@property (nonatomic, assign) CGFloat menuItemWidth;

/// menu的item的高(默认为45.0)
@property (nonatomic, assign) CGFloat menuItemHeight;

/// menu的item的文字颜色(默认为whiteColor)
@property (nonatomic, strong) UIColor *menuItemTitleColor;

/// menu的item的文字字体(默认为16.0)
@property (nonatomic, strong) UIFont *menuItemTitleFont;

/// menu的类型(默认为MZListMenuTypeRightNavBar)
@property (nonatomic, assign) MZListMenuType menuType;

/// 单例
+ (instancetype)defaultConfiguration;

@end

NS_ASSUME_NONNULL_END
