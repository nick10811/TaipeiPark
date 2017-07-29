//
//  DetailViewController.m
//  TaipeiPark
//
//  Created by Nick Yang on 29/07/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize selectedAttraction;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (![selectedAttraction.Image isEqualToString:@""]) {
        NSURL *url = [NSURL URLWithString:selectedAttraction.Image];
        img.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
    }
    parkName.text = selectedAttraction.ParkName;
    name.text = selectedAttraction.Name;
    openTime.text = [NSString stringWithFormat:@"開放時間：%@", selectedAttraction.OpenTime];
    intro.text = selectedAttraction.Introduction;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
