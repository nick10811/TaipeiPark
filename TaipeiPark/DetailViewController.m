//
//  DetailViewController.m
//  TaipeiPark
//
//  Created by Nick Yang on 29/07/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import "DetailViewController.h"
#import "DBHelp.h"
#import "RelationView.h"
#import "AppDelegate.h"
#import <MBProgressHUD.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize selectedAttraction;

MBProgressHUD *_hud;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.label.text = @"Loading";
    
    if ([AppDelegate isImage:selectedAttraction.Image]) {
        NSURL *url = [NSURL URLWithString:selectedAttraction.Image];
        img.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
    }
    parkName.text = selectedAttraction.ParkName;
    name.text = selectedAttraction.Name;
    openTime.text = [NSString stringWithFormat:@"開放時間：%@", selectedAttraction.OpenTime];
    intro.text = selectedAttraction.Introduction;
    
    CGSize size = CGSizeMake(100*_relations.count, 120);
    scrollView.contentSize = size;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        RelationView *preView;
        for (int i = 0; i < _relations.count; i++) {
            RelationView *rView = [[RelationView alloc] init];
            Attraction *tmp = (Attraction *)[_relations objectAtIndex:i];
            if ([AppDelegate isImage:tmp.Image]) {
                rView.img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tmp.Image]]];
                
            } else {
                rView.img.image = [UIImage imageNamed:@"noImage.png"];
            }
            
            rView.name.text = tmp.Name;
            
            if (i == 0) {
                rView.frame = CGRectMake(0, 0, 100, 120);
            } else {
                rView.frame = CGRectOffset(preView.frame, 100, 0);
            }
            
            [scrollView addSubview:rView];
            preView = rView;
            
        }
    });
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_hud) {
        [_hud setHidden:YES];
        _hud = nil;
    }
    
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
