//
//  AttractionsTableViewController.m
//  TaipeiPark
//
//  Created by Nick Yang on 27/07/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import "AttractionsTableViewController.h"
#import "MyCell.h"
#import "AttractionModel.h"
#import "DetailViewController.h"
#import "UIViewController+BaseVC.h"
#import "AttractionViewModel.h"
#import "ParkModel.h"
#import "DetailViewModel.h"
#import "Functions.h"

@interface AttractionsTableViewController ()

@end

@implementation AttractionsTableViewController
AttractionViewModel *viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 20;
    
    viewModel = [[AttractionViewModel alloc] init];
    viewModel.loadingDelegate = self;
    [self showLoading:YES];
    [viewModel nextStatus];
    
    // pull refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(pullRefresh) forControlEvents:UIControlEventValueChanged];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pullRefresh {
    [self.refreshControl endRefreshing];
    [self showLoading:YES];
    [viewModel refreshData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int num = (int)[viewModel numberOfSection];
    NSLog(@"section number: %d", num);
    return num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int num = (int)[viewModel numberOfItemsInSection:section];
    ParkModel *park = (ParkModel *)[viewModel modelAtSection:section];
    NSLog(@"section:%@, num:%d", park.parkName, num);
    return num;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    ParkModel *model = (ParkModel *)[viewModel modelAtSection:section];
    return model.parkName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if (cell == nil) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"MyCell" owner:nil options:nil];
        for (UIView *view in views) {
            if ([view isKindOfClass:[MyCell class]]) {
                cell = (MyCell *)view;
            }
        }
    }
    
    [cell setupUI:(AttractionModel *)[viewModel modelAtIndex:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    AttractionModel *selectedModel = (AttractionModel *)[viewModel modelAtIndex:indexPath];
    DetailViewModel *detailViewModel = [[DetailViewModel alloc] initWithPark:(ParkModel *)[viewModel modelAtSection:indexPath.section] attraction:selectedModel];

    DetailViewController *vc = (DetailViewController *)[Functions findViewControllerByIDFromStoryboard:@"Main" viewControllerID:@"DetailViewController"];
    vc.viewModel = detailViewModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([viewModel isLastModel:indexPath]) {
        [self showLoading:YES];
        [viewModel nextStatus];
    }
}

#pragma mark - WebServiceLoadingDelegate
- (void) WebServiceLoadingDone {
    [self showLoading:NO];
    [self.tableView reloadData];
}

- (void) WebServiceLoadingFail:(long)code Message:(NSString *)message {
    [self showLoading:NO];
    [self showAlertWithConfirmTitle:[NSString stringWithFormat:@"Error(%ld)", code] Message:message];
}

@end
