//
//  ViewController.m
//  MZListMenu
//
//  Created by Mr.Z on 2019/12/27.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewController.h"
#import "UIView+MZListMenu.h"
#import "UIBarButtonItem+MZListMenu.h"
#import "MZListMenuConfiguration.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MZListMenu dismissListMenuInView:self.view isAnimation:NO];
}

- (void)setupUI {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(showMenu:)];
    leftItem.tag = 101;
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showMenu:)];
    rightItem.tag = 102;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(100, 120, 60, 30);
    btn1.tag = 11;
    btn1.backgroundColor= [UIColor redColor];
    [btn1 setTitle:@"view" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(100, 200, 60, 30);
    btn2.tag = 22;
    btn2.backgroundColor= [UIColor redColor];
    [btn2 setTitle:@"cell" forState:UIControlStateNormal];
    
    [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)showMenu:(id)sender {
    UIBarButtonItem *item = (UIBarButtonItem *)sender;
    NSArray *imageArr = @[@"icon_swap", @"icon_photograph", @"icon_code"];
    NSArray *titleArr = @[@"扫一扫", @"拍\t照", @"付款码"];
    MZListMenuConfiguration *configuration = [MZListMenuConfiguration defualt];
    configuration.menuType = item.tag == 101 ? MZListMenuTypeLeftNavBar: MZListMenuTypeRightNavBar;
    [item mz_showMenuWithImages:imageArr titles:titleArr currentNav:self.navigationController configuration:configuration itemClickBlock:^(NSInteger index) {
        [self showMessage:index];
    }];
}

- (void)btnAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 11) {
        NSArray *imageArr = @[@"icon_swap", @"icon_photograph", @"icon_code"];
        NSArray *titleArr = @[@"扫一扫", @"拍  照", @"付款码"];
        [btn mz_showMenuWithImages:imageArr titles:titleArr configuration:[MZListMenuConfiguration defualt] itemClickBlock:^(NSInteger index) {
            NSLog(@"%ld", (long)index);
        }];
    } else {
         [self.navigationController pushViewController:[[TestTableViewController alloc] init] animated:YES];
    }
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
