//
//  UIBarButtonItem+MZListMenu.h
//  MZListMenu
//
//  Created by Mr.Z on 2019/12/31.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZListMenu.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (MZListMenu)

/// 显示视图
/// @param imageArr 图片数组
/// @param titleArr 标题数组
/// @param currentNav BarButtonItem所在的Navigation
/// @param configuration 配置
/// @param block 点击item的block回调
- (void)mz_showMenuWithImages:(NSArray *)imageArr titles:(NSArray *)titleArr currentNav:(UINavigationController *)currentNav configuration:(MZListMenuConfiguration *)configuration itemClickBlock:(MZListMenuItemClick)block;

@end

NS_ASSUME_NONNULL_END
