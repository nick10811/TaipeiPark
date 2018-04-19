//
//  LaunchViewController.m
//  TaipeiPark
//
//  Created by Nick Yang on 10/08/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import "LaunchViewController.h"
#import "UpdateManager.h"
#import "AppDelegate.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _dataLoad_ProgressView.progress = 0.0;
    UpdateManager *um = [[UpdateManager alloc] init];
    [[um parseData] setProgressBlock:^(float stored, float total) {
        NSLog(@"stored:%f, total:%f", stored, total);
        dispatch_async(dispatch_get_main_queue(), ^{
            _dataLoad_ProgressView.progress = stored/total;
            
            if (stored >= total) { // finish loading
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate returnMainView];
            }
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
