//
//  MZListMenu.m
//  MZListMenu
//
//  Created by Mr.Z on 2019/12/30.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import "MZListMenu.h"
#import "MZListMenuView.h"
#import "MZListMenuConfiguration.h"

#define MZListMenuScreenWidth [UIScreen mainScreen].bounds.size.width
#define MZListMenuScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MZListMenu ()

@property (nonatomic, strong) MZListMenuView *menuView;
@property (nonatomic, strong) MZListMenuConfiguration *configuration;
@property (nonatomic, assign) CGRect menuStartRect;
@property (nonatomic, assign) CGRect menuEndRect;
@property (nonatomic, assign) BOOL isDown;
@property (nonatomic, assign) BOOL isDismiss;

@end

@implementation MZListMenu

#pragma mark - 初始化
- (instancetype)init {
    if (self = [super init]) {
        self.isDismiss = NO;
        self.isDown = YES;
        self.frame = CGRectMake(0, 0, MZListMenuScreenWidth, MZListMenuScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        // 添加pan手势,防止视图响应scrollview的滚动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
        [self addSubview:self.menuView];
    }
    return self;
}

#pragma mark - Lazy
- (MZListMenuView *)menuView {
    if (!_menuView) {
        _menuView = [[MZListMenuView alloc] initWithFrame:CGRectZero];
    }
    return _menuView;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (![self isInMenuViewWithPoint:point]) {
        [self dismissListMenuViewWithAnimation:YES];
    }
    return [super hitTest:point withEvent:event];
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    if ([pan.view isKindOfClass:[MZListMenu class]]) {
        return;
    }
}

/// 判断触点的位置是否在ListMenuView上
- (BOOL)isInMenuViewWithPoint:(CGPoint)point {
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[MZListMenuView class]]) {
            MZListMenuView *menuView = (MZListMenuView *)subView;
            CGPoint menuViewPoint = [self convertPoint:point toView:menuView];
            return [menuView pointInside:menuViewPoint withEvent:nil];
        }
    }
    return NO;
}

#pragma mark - 展示菜单
+ (void)showMenuWithImages:(NSArray *)imageArr titles:(NSArray *)titleArr inView:(UIView *)view configuration:(MZListMenuConfiguration *)configuration itemClickBlock:(MZListMenuItemClick)block {
    if (imageArr.count == 0 || titleArr.count == 0 || imageArr.count != titleArr.count) {
        return;
    }
    MZListMenu *menu = [[MZListMenu alloc] init];
    menu.configuration = configuration;
    [menu showMenuWithImages:imageArr titles:titleArr inView:view configuration:configuration itemClickBlock:block];
}

+ (void)showMenuWithImages:(NSArray *)imageArr titles:(NSArray *)titleArr currentNav:(UINavigationController *)currentNav configuration:(MZListMenuConfiguration *)configuration itemClickBlock:(MZListMenuItemClick)block {
    if (imageArr.count == 0 || titleArr.count == 0 || imageArr.count != titleArr.count) {
        return;
    }
    MZListMenu *menu = [[MZListMenu alloc] init];
    menu.configuration = configuration;
    [menu showMenuWithImages:imageArr titles:titleArr currentNav:currentNav configuration:configuration itemClickBlock:block];
}

- (void)showMenuWithImages:(NSArray *)imageArr titles:(NSArray *)titleArr inView:(UIView *)view configuration:(MZListMenuConfiguration *)configuration itemClickBlock:(MZListMenuItemClick)block {
    if (imageArr.count == 0 || titleArr.count == 0 || imageArr.count != titleArr.count) {
        return;
    }
    self.configuration = configuration;
    [self configRectWithView:view count:imageArr.count];
    [self showAnimationMenuWithImages:imageArr titles:titleArr itemClickBlock:block];
}

- (void)showMenuWithImages:(NSArray *)imageArr titles:(NSArray *)titleArr currentNav:(UINavigationController *)currentNav configuration:(MZListMenuConfiguration *)configuration itemClickBlock:(MZListMenuItemClick)block {
    if (imageArr.count == 0 || titleArr.count == 0 || imageArr.count != titleArr.count) {
        return;
    }
    self.configuration = configuration;
    [self configRectWithCurrentNav:currentNav count:imageArr.count];
    [self showAnimationMenuWithImages:imageArr titles:titleArr itemClickBlock:block];
}

- (void)configRectWithCurrentNav:(UINavigationController *)currentNav count:(NSInteger)count {
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat statusBarHeight = statusRect.size.height;
    CGFloat navigationBarHeight = currentNav.navigationBar.bounds.size.height;
    CGFloat menuWidth = self.configuration.menuItemWidth;
    CGFloat menuHeight = self.configuration.menuItemHeight * count + self.configuration.menuTriangleHeight;
    switch (self.configuration.menuType) {
        case MZListMenuTypeLeftNavBar: {
            self.menuStartRect = CGRectMake(5.0 + menuWidth * 0.25, statusBarHeight + navigationBarHeight, 1.0, 1.0);
            self.menuEndRect = CGRectMake(5.0, statusBarHeight + navigationBarHeight, menuWidth, menuHeight);
        }
            break;
        case MZListMenuTypeRightNavBar: {
            self.menuStartRect = CGRectMake(MZListMenuScreenWidth - menuWidth * 0.25 - 5.0, statusBarHeight + navigationBarHeight, 1.0, 1.0);
            self.menuEndRect = CGRectMake(MZListMenuScreenWidth - menuWidth - 5.0, statusBarHeight + navigationBarHeight, menuWidth, menuHeight);
        }
            break;
        default:
            break;
    }
    [currentNav.view addSubview:self];
}

- (void)configRectWithView:(UIView *)view count:(NSInteger)count {
    UIView *vcView = [MZListMenu rootViewFromSubView:view];
    UIView *superView = view.superview;
    CGRect viewRectFromWindow = [superView convertRect:view.frame toView:vcView];
    CGFloat midX = CGRectGetMidX(viewRectFromWindow);
    CGFloat minY = CGRectGetMinY(viewRectFromWindow);
    CGFloat maxY = CGRectGetMaxY(viewRectFromWindow);
    CGFloat menuWidth = self.configuration.menuItemWidth;
    CGFloat menuHeight = self.configuration.menuItemHeight * count + self.configuration.menuTriangleHeight;
    if ((maxY + menuHeight) >= MZListMenuScreenHeight) {
        self.isDown = NO;
    }
    self.configuration.menuType = MZListMenuTypeMidNormal;
    if (midX - menuWidth * 0.5 <= 0) {
        self.configuration.menuType = MZListMenuTypeLeftNormal;
    } else if (midX + menuWidth * 0.5 >= MZListMenuScreenWidth) {
        self.configuration.menuType = MZListMenuTypeRightNormal;
    }
    switch (self.configuration.menuType) {
        case MZListMenuTypeLeftNormal: {
            if (self.isDown) {
                self.menuStartRect = CGRectMake(midX, maxY, 1.0, 1.0);
                self.menuEndRect = CGRectMake(midX - menuWidth * 0.25, maxY + 2.0, menuWidth, menuHeight);
            } else {
                self.menuStartRect = CGRectMake(midX, minY, 1.0, 1.0);
                self.menuEndRect = CGRectMake(midX - menuWidth * 0.25, minY - 2.0 - menuHeight, menuWidth, menuHeight);
            }
        }
            break;
        case MZListMenuTypeRightNormal: {
            if (self.isDown) {
                self.menuStartRect = CGRectMake(midX, maxY, 1.0, 1.0);
                self.menuEndRect = CGRectMake(midX - menuWidth * 0.75, maxY + 2.0, menuWidth, menuHeight);
            } else {
                self.menuStartRect = CGRectMake(midX, minY, 1.0, 1.0);
                self.menuEndRect = CGRectMake(midX - menuWidth * 0.75, minY - 2.0 - menuHeight, menuWidth, menuHeight);
            }
        }
            break;
        case MZListMenuTypeMidNormal: {
            if (self.isDown) {
                self.menuStartRect = CGRectMake(midX, maxY, 1.0, 1.0);
                self.menuEndRect = CGRectMake(midX - menuWidth * 0.5, maxY + 2.0, menuWidth, menuHeight);
            } else {
                self.menuStartRect = CGRectMake(midX, minY, 1.0, 1.0);
                self.menuEndRect = CGRectMake(midX - menuWidth * 0.5, minY - 2.0 - menuHeight, menuWidth, menuHeight);
            }
        }
            break;
        default: {
            if (self.isDown) {
                self.menuStartRect = CGRectMake(midX, maxY, 1.0, 1.0);
                self.menuEndRect = CGRectMake(midX - menuWidth * 0.5, maxY + 2.0, menuWidth, menuHeight);
            } else {
                self.menuStartRect = CGRectMake(midX, minY, 1.0, 1.0);
                self.menuEndRect = CGRectMake(midX - menuWidth * 0.5, minY - 2.0 - menuHeight, menuWidth, menuHeight);
            }
        }
            break;
    }
    [vcView addSubview:self];
}

- (void)showAnimationMenuWithImages:(NSArray *)imageArr titles:(NSArray *)titleArr itemClickBlock:(MZListMenuItemClick)block {
    __weak typeof(self) weakSelf = self;
    [self.menuView setImages:imageArr titles:titleArr configuration:self.configuration isDown:self.isDown itemClickBlock:^(NSInteger index) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf dismissListMenuViewWithAnimation:NO];
        block(index);
    }];
    self.menuView.frame = self.menuStartRect;
    [self.menuView hideContentView];
    [UIView animateWithDuration:0.2 animations:^{
        self.menuView.frame = self.menuEndRect;
    } completion:^(BOOL finished) {
        [self.menuView showContentView];
    }];
}

#pragma mark - 隐藏菜单
+ (void)dismissListMenuInView:(UIView *)view isAnimation:(BOOL)isAnimation {
    MZListMenu *menu = [self listMenuInView:view];
    if (menu) {
        [menu dismissListMenuViewWithAnimation:isAnimation];
    }
}

+ (MZListMenu *)listMenuInView:(UIView *)view {
    UIView *rootView = [self rootViewFromSubView:view];
    for (UIView *subView in rootView.subviews) {
        if ([subView isKindOfClass:[MZListMenu class]]) {
            MZListMenu *menu = (MZListMenu *)view;
            return menu;
        }
    }
    return nil;
}

+ (UIView *)rootViewFromSubView:(UIView *)view {
    UIViewController *vc = nil;
    UIResponder *next = view.nextResponder;
    do {
        if ([next isKindOfClass:[UINavigationController class]]) {
            vc = (UIViewController *)next;
            break;
        }
        next = next.nextResponder;
    } while (next);
    if (!vc) {
        next = view.nextResponder;
        do {
            if ([next isKindOfClass:[UIViewController class]] || [next isKindOfClass:[UITableViewController class]]) {
                vc = (UIViewController *)next;
                break;
            }
            next = next.nextResponder;
        } while (next);
    }
    return vc.view;
}

- (void)dismissListMenuViewWithAnimation:(BOOL)isAnimation {
    // 由于hitTest会响应多次,使用isDismiss使该方法只执行一次,防止多次响应造成动画无效
    if (self.isDismiss) {
        return;
    }
    self.isDismiss = YES;
    [self.menuView hideContentView];
    if (isAnimation) {
        [UIView animateWithDuration:0.2 animations:^{
            self.menuView.frame = self.menuStartRect;
        } completion:^(BOOL finished) {
            self.isDismiss = NO;
            [self removeFromSuperview];
        }];
    } else {
        self.isDismiss = NO;
        [self removeFromSuperview];
    }
}

@end
