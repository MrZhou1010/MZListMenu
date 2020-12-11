//
//  MZListMenu.h
//  MZListMenu
//
//  Created by Mr.Z on 2019/12/30.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MZListMenuConfiguration;

typedef void(^MZListMenuItemClick)(NSInteger index);

@interface MZListMenu : UIView

/// 显示视图
/// @param imageArr 图片数组
/// @param titleArr 标题数组
/// @param view 所在的视图
/// @param configuration 配置
/// @param block 点击item的block回调
+ (void)showMenuWithImages:(NSArray *)imageArr titles:(NSArray *)titleArr inView:(UIView *)view configuration:(MZListMenuConfiguration *)configuration itemClickBlock:(MZListMenuItemClick)block;

/// 显示视图
/// @param imageArr 图片数组
/// @param titleArr 标题数组
/// @param currentNav 所在的navigation
/// @param configuration 配置
/// @param block 点击item的block回调
+ (void)showMenuWithImages:(NSArray *)imageArr titles:(NSArray *)titleArr currentNav:(UINavigationController *)currentNav configuration:(MZListMenuConfiguration *)configuration itemClickBlock:(MZListMenuItemClick)block;

/// 隐藏视图
/// @param view 所在的视图
/// @param isAnimation 是否动画
+ (void)dismissListMenuInView:(UIView *)view isAnimation:(BOOL)isAnimation;

@end

NS_ASSUME_NONNULL_END
