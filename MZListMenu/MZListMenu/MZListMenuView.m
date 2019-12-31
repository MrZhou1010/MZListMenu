//
//  MZListMenuView.m
//  MZListMemu
//
//  Created by Mr.Z on 2019/12/27.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import "MZListMenuView.h"
#import "MZListMenuItem.h"
#import "MZListMenuConfiguration.h"

@interface MZListMenuView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) MZListMenuConfiguration *configuration;
@property (nonatomic, copy) MZListMenuItemClickBlock itemClickBlock;
@property (nonatomic, copy) NSArray *imageArr;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, assign) BOOL isDown;

@end

@implementation MZListMenuView

#pragma mark - 初始化
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.contentView];
        self.contentView.frame = frame;
        self.isDown = YES;
        self.layer.shadowRadius = 2;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 1;
        self.layer.shadowOffset = CGSizeMake(1, 1);
    }
    return self;
}

#pragma mark - Lazy
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.userInteractionEnabled = YES;
        _contentView.autoresizesSubviews = YES;
    }
    return _contentView;
}

- (void)drawRect:(CGRect)rect {
    CGFloat contentWidth = self.bounds.size.width;
    CGFloat contentHeight = self.bounds.size.height;
    CGFloat triangleX = 0.0;
    switch (self.configuration.menuType) {
        case MZListMenuTypeLeftNormal:
        case MZListMenuTypeLeftNavBar: {
            triangleX = contentWidth * 0.25 - self.configuration.menuTriangleWidth * 0.5;
        }
            break;
        case MZListMenuTypeRightNormal:
        case MZListMenuTypeRightNavBar: {
            triangleX = contentWidth * 0.75 - self.configuration.menuTriangleWidth * 0.5;
        }
            break;
        default:
            triangleX = contentWidth * 0.5 - self.configuration.menuTriangleWidth * 0.5;
            break;
    }
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    if (self.isDown) {
        [trianglePath moveToPoint:CGPointMake(triangleX, self.configuration.menuTriangleHeight)];
        [trianglePath addLineToPoint:CGPointMake(triangleX + self.configuration.menuTriangleWidth * 0.5, 0)];
        [trianglePath addLineToPoint:CGPointMake(triangleX + self.configuration.menuTriangleWidth, self.configuration.menuTriangleHeight)];
    } else {
        [trianglePath moveToPoint:CGPointMake(triangleX, contentHeight - self.configuration.menuTriangleHeight)];
        [trianglePath addLineToPoint:CGPointMake(triangleX + self.configuration.menuTriangleWidth * 0.5, contentHeight)];
        [trianglePath addLineToPoint:CGPointMake(triangleX + self.configuration.menuTriangleWidth, contentHeight - self.configuration.menuTriangleHeight)];
    }
    [self.configuration.menuViewBackgroundColor set];
    [trianglePath fill];
    if (self.isDown) {
        UIBezierPath *radiusPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, self.configuration.menuTriangleHeight, contentWidth, contentHeight - self.configuration.menuTriangleHeight) cornerRadius:5];
        [self.configuration.menuViewBackgroundColor set];
        [radiusPath fill];
    } else {
        UIBezierPath *radiusPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, contentWidth, contentHeight - self.configuration.menuTriangleHeight) cornerRadius:5];
        [self.configuration.menuViewBackgroundColor set];
        [radiusPath fill];
    }
}

#pragma mark - 创建Items
- (void)setupMenuItems {
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    for (NSInteger i = 0; i < self.titleArr.count; i++) {
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn.backgroundColor = [UIColor clearColor];
        itemBtn.tag = 1000 + i;
        [itemBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:itemBtn];
        MZListMenuItem *item = [[MZListMenuItem alloc] initWithIconName:self.imageArr[i] title:self.titleArr[i]];
        item.userInteractionEnabled = NO;
        [self.contentView addSubview:item];
        if (self.isDown) {
            [item setupViewsWithRect:CGRectMake(0, i * self.configuration.menuItemHeight + self.configuration.menuTriangleHeight, self.configuration.menuItemWidth, self.configuration.menuItemHeight)];
            [item updateTitleColor:self.configuration.menuItemTitleColor font:self.configuration.menuItemTitleFont];
            itemBtn.frame = CGRectMake(0, i * self.configuration.menuItemHeight + self.configuration.menuTriangleHeight, self.configuration.menuItemWidth, self.configuration.menuItemHeight);
            if (i != 0) {
                CALayer *lineLayer = [[CALayer alloc] init];
                lineLayer.cornerRadius = 0.5;
                lineLayer.backgroundColor = self.configuration.menuViewLineColor.CGColor;
                lineLayer.frame = CGRectMake(self.configuration.menuItemHeight * 0.25 - 2, i * self.configuration.menuItemHeight + self.configuration.menuTriangleHeight - 1, self.configuration.menuItemWidth - self.configuration.menuItemHeight * 0.5 + 4, 0.5);
                [self.contentView.layer addSublayer:lineLayer];
            }
        } else {
            [item setupViewsWithRect:CGRectMake(0, i * self.configuration.menuItemHeight, self.configuration.menuItemWidth, self.configuration.menuItemHeight)];
            [item updateTitleColor:self.configuration.menuItemTitleColor font:self.configuration.menuItemTitleFont];
            itemBtn.frame = CGRectMake(0, i * self.configuration.menuItemHeight, self.configuration.menuItemWidth, self.configuration.menuItemHeight);
            if (i != 0) {
                CALayer *lineLayer = [[CALayer alloc] init];
                lineLayer.cornerRadius = 0.5;
                lineLayer.backgroundColor = self.configuration.menuViewLineColor.CGColor;
                lineLayer.frame = CGRectMake(self.configuration.menuItemHeight * 0.25 - 2, i * self.configuration.menuItemHeight - 1, self.configuration.menuItemWidth - self.configuration.menuItemHeight * 0.5 + 4, 0.5);
                [self.contentView.layer addSublayer:lineLayer];
            }
        }
        UIImage *buttonHighlightedImage = [self buttonHighlightedImageWithSize:itemBtn.bounds.size];
        [itemBtn setBackgroundImage:buttonHighlightedImage forState:UIControlStateHighlighted];
        // 上下两边的圆角
        if (i == 0 || i == self.titleArr.count - 1) {
            itemBtn.layer.cornerRadius = 5;
            itemBtn.layer.masksToBounds = YES;
        }
    }
}

- (void)btnAction:(UIButton *)sender {
    if (self.itemClickBlock) {
        self.itemClickBlock(sender.tag - 1000);
    }
}

- (UIImage *)buttonHighlightedImageWithSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:0];
    [[UIColor colorWithWhite:0.3 alpha:1.0] set];
    [bezierPath fill];
    UIImage *highlightedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return highlightedImage;
}

#pragma mark - Public Function
- (void)setImages:(NSArray *)imageArr titles:(NSArray *)titleArr configuration:(MZListMenuConfiguration *)configuration isDown:(BOOL)isDown itemClickBlock:(MZListMenuItemClickBlock)block {
    self.imageArr = imageArr;
    self.titleArr = titleArr;
    self.configuration = configuration;
    self.isDown = isDown;
    [self setupMenuItems];
    if (block) {
        self.itemClickBlock = block;
    }
    [self setNeedsDisplay];
}

- (void)showContentView {
    self.contentView.hidden = NO;
    self.contentView.frame = self.bounds;
}

- (void)hideContentView {
    self.contentView.hidden = YES;
}

@end
