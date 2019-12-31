//
//  MZListMenuItem.m
//  MZListMemu
//
//  Created by Mr.Z on 2019/12/27.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import "MZListMenuItem.h"

@interface MZListMenuItem ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *title;

@end

@implementation MZListMenuItem

#pragma mark - 初始化
- (instancetype)initWithIconName:(NSString *)iconName title:(NSString *)title {
    if (self= [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.iconName = iconName;
        self.title = title;
    }
    return self;
}

#pragma mark - Lazy
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.iconName]];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = self.title;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}

#pragma mark - Function
- (void)updateTitleColor:(UIColor *)color font:(UIFont *)font {
    self.titleLabel.textColor = color;
    self.titleLabel.font = font;
}

- (void)setupViewsWithRect:(CGRect)rect {
    self.frame = rect;
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    CGFloat iconHeight = rect.size.height * 0.5;
    self.iconImageView.frame = CGRectMake(iconHeight * 0.5, iconHeight * 0.5, iconHeight, iconHeight);
    CGFloat iconMaxX = CGRectGetMaxX(self.iconImageView.frame);
    self.titleLabel.frame = CGRectMake(iconMaxX + iconHeight * 0.5, iconHeight * 0.5, rect.size.width - iconMaxX - iconHeight, iconHeight);
}

@end
