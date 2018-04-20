//
//  DetailViewController.m
//  TaipeiPark
//
//  Created by Nick Yang on 29/07/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import <MBProgressHUD.h>
#import "MyCollectionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

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

#pragma mark - Collection View DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _relations.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MyCollectionCell alloc] init];
    }
    
    Attraction *relation = (Attraction *)[_relations objectAtIndex:indexPath.row];
    
    if ([AppDelegate isImage:relation.Image]) {
        [cell.rImage_ImageView sd_setImageWithURL:[NSURL URLWithString:relation.Image]
                    placeholderImage:[UIImage imageNamed:@"Load.png"]];
        
    } else {
        cell.rImage_ImageView.image = [UIImage imageNamed:@"noImage.png"];
    }
    
    cell.rName_Label.text = relation.Name;
    cell.rName_Label.adjustsFontSizeToFitWidth = YES;
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

@end