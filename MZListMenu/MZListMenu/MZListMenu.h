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

+ (void)showMenuWithImages:(NSArray *)imageArr titles:(NSArray *)titleArr inView:(UIView *)view configuration:(MZListMenuConfiguration *)configuration itemClickBlock:(MZListMenuItemClick)block;

+ (void)showMenuWithImages:(NSArray *)imageArr titles:(NSArray *)titleArr currentNav:(UINavigationController *)currentNav configuration:(MZListMenuConfiguration *)configuration itemClickBlock:(MZListMenuItemClick)block;

+ (void)dismissListMenuInView:(UIView *)view isAnimation:(BOOL)isAnimation;

@end

NS_ASSUME_NONNULL_END
