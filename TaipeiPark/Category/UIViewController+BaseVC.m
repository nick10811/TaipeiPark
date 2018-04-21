//
//  UIViewController+BaseVC.m
//  TaipeiPark
//
//  Created by Nick Yang on 2018/4/20.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

#import "UIViewController+BaseVC.h"
#import <MBProgressHUD.h>

@implementation UIViewController (BaseVC)

- (void)showAlertWithConfirmTitle:(NSString *)title Message:(NSString *)msg {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showLoading:(BOOL)show {
    if (show) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"Loading";
    } else {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}

@end
