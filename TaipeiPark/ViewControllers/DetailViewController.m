//
//  DetailViewController.m
//  TaipeiPark
//
//  Created by Nick Yang on 29/07/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import "DetailViewController.h"
#import "MyCollectionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Functions.h"
#import "UIViewController+BaseVC.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showLoading:YES];

    [self setupUI];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showLoading:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    AttractionModel *model = [viewModel selectedModel];
    if ([Functions isImage:model.Image]) {
        [img sd_setImageWithURL:[NSURL URLWithString:model.Image]
                    placeholderImage:[UIImage imageNamed:@"Load.png"]];
    } else {
        img.image = [UIImage imageNamed:@"noImage.png"];
    }
    
    parkName.text = model.ParkName;
    name.text = model.Name;
    openTime.text = [NSString stringWithFormat:@"開放時間：%@", model.OpenTime];
    intro.text = model.Introduction;

}

#pragma mark - Collection View DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [viewModel numberOfItemsInSection:section];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MyCollectionCell alloc] init];
    }

    AttractionModel *model = (AttractionModel *)[viewModel modelAtIndex:indexPath];
    [cell setupUI:model];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [viewModel numberOfSection];
}

@end
