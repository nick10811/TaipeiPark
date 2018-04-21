//
//  AttractionsTableViewController.m
//  TaipeiPark
//
//  Created by Nick Yang on 27/07/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import "AttractionsTableViewController.h"
#import "MyCell.h"
#import "Attraction.h"
#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ParkService.h"
#import "Functions.h"
#import "UIViewController+BaseVC.h"

@interface AttractionsTableViewController ()

@end

@implementation AttractionsTableViewController

NSArray *parks; // section
NSMutableDictionary *attractionsInPark; // cell

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 20;
    
    [self refreshData];
    
    // pull refresh
//    self.refreshControl = [[UIRefreshControl alloc] init];
//    [self.refreshControl addTarget:self action:@selector(pullReresh) forControlEvents:UIControlEventValueChanged];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshData {
    [self showLoading:YES];
    ParkService *webService = [[ParkService alloc] init];
    [webService loadData:^(NSMutableArray<Attraction *> *parkArray) {
        [self showLoading:NO];
        [self dataConvert:parkArray];
        [self.tableView reloadData];
        
    } error:^(long code, NSString *message) {
        [self showLoading:NO];
        [self showAlertWithConfirmTitle:[NSString stringWithFormat:@"Error(%d)", code] Message:message];
    }];
    
}

- (void)dataConvert:(NSMutableArray<Attraction *> *) parkArray {
    // classify
    NSMutableArray *sectionArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *cellArray = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < parkArray.count; i++) {
        Attraction *park = parkArray[i];
        if (![sectionArray containsObject:park.ParkName]) {
            [sectionArray addObject:park.ParkName];
            
            NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
            [tmpArray addObject:park];
            [cellArray setObject:tmpArray forKey:park.ParkName];
            
        } else {
            NSMutableArray *existArray = [cellArray objectForKey:park.ParkName];
            [existArray addObject:park];
            [cellArray removeObjectForKey:park.ParkName];
            [cellArray setObject:existArray forKey:park.ParkName];
            
        }
    }
    parks = [sectionArray copy];
    attractionsInPark = [cellArray copy];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int num = (int)parks.count;
    NSLog(@"section number: %d", num);
    return num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *parkName = parks[section];
    NSArray *relactions = [attractionsInPark objectForKey:parkName];
    int num = (int)relactions.count;
    NSLog(@"section:%@, num:%d", parkName, num);
    return num;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *parkName = parks[section];
    return parkName;
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
    
    NSString *parkName = parks[indexPath.section];
    NSArray *relactions = [attractionsInPark objectForKey:parkName];
    
    Attraction *attraction = (Attraction *)[relactions objectAtIndex:indexPath.row];
    
    if ([Functions isImage:attraction.Image]) {
        [cell.img sd_setImageWithURL:[NSURL URLWithString:attraction.Image]
                     placeholderImage:[UIImage imageNamed:@"Load.png"]];
    } else {
        cell.img.image = [UIImage imageNamed:@"noImage.png"];
    }
    
    cell.parkName.text = attraction.ParkName;
    cell.name.text = attraction.Name;
    cell.introduction.text = attraction.Introduction;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *parkName = parks[indexPath.section];
    NSMutableArray *relactions = [attractionsInPark objectForKey:parkName];
    
    DetailViewController *vc = (DetailViewController *)[Functions findViewControllerByIDFromStoryboard:@"Main" viewControllerID:@"DetailViewController"];
    vc.selectedAttraction = (Attraction *)[relactions objectAtIndex:indexPath.row];
    vc.relations = [NSMutableArray arrayWithArray:relactions];
    [vc.relations removeObjectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
