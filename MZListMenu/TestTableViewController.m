//
//  TestTableViewController.m
//  MZListMenu
//
//  Created by Mr.Z on 2019/12/31.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import "TestTableViewController.h"
#import "UIView+MZListMenu.h"
#import "UIBarButtonItem+MZListMenu.h"
#import "MZListMenuConfiguration.h"

@interface TestTableViewController ()

@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"带三角的弹框选择视图";
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [MZListMenu dismissListMenuInView:self.view isAnimation:NO];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试cell-%ld", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSArray *imageArr = @[@"icon_swap", @"icon_photograph", @"icon_code"];
    NSArray *titleArr = @[@"扫一扫", @"拍\t照", @"付款码"];
    MZListMenuConfiguration *configuration = [MZListMenuConfiguration defaultConfiguration];
    configuration.menuType = MZListMenuTypeMidNormal;
    [cell mz_showMenuWithImages:imageArr titles:titleArr configuration:configuration itemClickBlock:^(NSInteger index) {
        [self showMessage:index];
    }];
}

- (void)showMessage:(NSInteger)index {
    switch (index) {
        case 0: {
            [self showAlertMessage:@"扫一扫"];
        }
            break;
        case 1: {
            [self showAlertMessage:@"拍照"];
        }
            break;
        case 2: {
            [self showAlertMessage:@"付款码"];
        }
            break;
        default:
            break;
    }
}

- (void)showAlertMessage:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
