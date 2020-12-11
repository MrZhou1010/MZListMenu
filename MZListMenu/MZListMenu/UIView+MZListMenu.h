//
//  UIView+MZListMenu.h
//  MZListMenu
//
//  Created by Mr.Z on 2019/12/31.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZListMenu.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MZListMenu)

/// 显示视图
/// @param imageArr 图片数组
/// @param titleArr 标题数组
/// @param configuration 配置
/// @param block 点击item的block回调
- (void)mz_showMenuWithImages:(NSArray *)imageArr titles:(NSArray *)titleArr configuration:(MZListMenuConfiguration *)configuration itemClickBlock:(MZListMenuItemClick)block;

@end

NS_ASSUME_NONNULL_END
