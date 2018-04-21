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

ParkService *webService;
NSMutableArray *sectionArray; // section
NSMutableDictionary *cellDictonayArray; // cell

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 20;
    
    sectionArray = [[NSMutableArray alloc] init];
    cellDictonayArray = [[NSMutableDictionary alloc] init];
    
    webService = [[ParkService alloc] init];
    [self loadData];
    
    // pull refresh
//    self.refreshControl = [[UIRefreshControl alloc] init];
//    [self.refreshControl addTarget:self action:@selector(pullReresh) forControlEvents:UIControlEventValueChanged];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    [self getDataFromServer:0];
}

- (void)loadMoreData {
    [self getDataFromServer:webService.nextOffset];
    
}

- (void)getDataFromServer:(int)offset {
    [self showLoading:YES];
    [webService loadData:^(NSMutableArray<Attraction *> *parkArray) {
        [self showLoading:NO];
        [self dataConvert:parkArray];
        [self.tableView reloadData];
        
    } error:^(long code, NSString *message) {
        [self showLoading:NO];
        [self showAlertWithConfirmTitle:[NSString stringWithFormat:@"Error(%d)", code] Message:message];
        
    } offset:offset];
}

- (void)dataConvert:(NSMutableArray<Attraction *> *) parkArray {
    // classify
    for (int i = 0; i < parkArray.count; i++) {
        Attraction *park = parkArray[i];
        if (![sectionArray containsObject:park.ParkName]) {
            [sectionArray addObject:park.ParkName];
            
            NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
            [tmpArray addObject:park];
            [cellDictonayArray setObject:tmpArray forKey:park.ParkName];
            
        } else {
            NSMutableArray *existArray = [cellDictonayArray objectForKey:park.ParkName];
            [existArray addObject:park];
            [cellDictonayArray removeObjectForKey:park.ParkName];
            [cellDictonayArray setObject:existArray forKey:park.ParkName];
            
        }
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int num = (int)sectionArray.count;
//    NSLog(@"section number: %d", num);
    return num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *parkName = sectionArray[section];
    NSArray *relactions = [cellDictonayArray objectForKey:parkName];
    int num = (int)relactions.count;
//    NSLog(@"section:%@, num:%d", parkName, num);
    return num;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *parkName = sectionArray[section];
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
    
    NSString *parkName = sectionArray[indexPath.section];
    NSArray *relactions = [cellDictonayArray objectForKey:parkName];
    
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
    
    NSString *parkName = sectionArray[indexPath.section];
    NSMutableArray *relactions = [cellDictonayArray objectForKey:parkName];
    
    DetailViewController *vc = (DetailViewController *)[Functions findViewControllerByIDFromStoryboard:@"Main" viewControllerID:@"DetailViewController"];
    vc.selectedAttraction = (Attraction *)[relactions objectAtIndex:indexPath.row];
    vc.relations = [NSMutableArray arrayWithArray:relactions];
    [vc.relations removeObjectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self checkScrollOffset:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!scrollView.isDecelerating && !scrollView.isDragging) {
        [self checkScrollOffset:scrollView];
    }
}

- (void)checkScrollOffset:(UIScrollView *)scrollView {
    int offset = scrollView.contentOffset.y;
    int maxOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    if (maxOffset - offset < 0) {
        [self loadMoreData];
    }
}

@end
