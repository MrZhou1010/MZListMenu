//
//  MZListMenuItem.h
//  MZListMemu
//
//  Created by Mr.Z on 2019/12/27.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MZListMenuItem : UIView

/**
 * 初始化
 *
 * @param iconName 图标
 * @param title 标题
 */
- (instancetype)initWithIconName:(NSString *)iconName title:(NSString *)title;

/**
 * 设置Frame
 *
 * @param rect 布局
 */
- (void)setupViewsWithRect:(CGRect)rect;

/**
 * 修改文字颜色和大小
 *
 * @param color 文字颜色
 * @param font 文字大小
 */
- (void)updateTitleColor:(UIColor *)color font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
