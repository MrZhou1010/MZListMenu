//
//  MZListMenuView.h
//  MZListMemu
//
//  Created by Mr.Z on 2019/12/27.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MZListMenuConfiguration;

typedef void(^MZListMenuItemClickBlock)(NSInteger index);

@interface MZListMenuView : UIView

/**
 * 设置menu资源
 *
 * @param imageArr 图片数组
 * @param titleArr 标题数组
 * @param configuration 配置
 * @param isDown 是否箭头向下
 * @param block 点击item的block回调
 */
- (void)setImages:(NSArray *)imageArr titles:(NSArray *)titleArr configuration:(MZListMenuConfiguration *)configuration isDown:(BOOL)isDown itemClickBlock:(MZListMenuItemClickBlock)block;

/**
 * 显示contentView
 */
- (void)showContentView;

/**
 * 隐藏contentView
 */
- (void)hideContentView;

@end

NS_ASSUME_NONNULL_END
