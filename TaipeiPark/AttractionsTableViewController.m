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
#import <MBProgressHUD.h>
#import "DBHelp.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "UpdateManager.h"

@interface AttractionsTableViewController ()

@end

@implementation AttractionsTableViewController

NSArray *parks; // section
NSMutableDictionary *attractionsInPark; // cell
MBProgressHUD *hud;

- (void)pullReresh {
    
    // lock view to avoid user select cell
    [self.refreshControl endRefreshing];
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Loading...";
    
    UpdateManager *um = [[UpdateManager alloc] init];
    [[um parseData] setProgressBlock:^(float stored, float total) {
        if (stored >= total) {
            dispatch_async(dispatch_get_main_queue(), ^{
                DBHelp *db = [[DBHelp alloc] init];
                attractionsInPark = [db getAttractionsByPark];
                parks = [attractionsInPark allKeys];
                
                [self.tableView reloadData];
                
                if (hud) {
                    [hud setHidden:YES];
                    hud = nil;
                }
                
            });
        }
        
    }];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _search_TextField) {
        [textField resignFirstResponder];
        
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"Loading...";
        
        DBHelp *db = [[DBHelp alloc] init];
        attractionsInPark = [db getAttractionsByKeyword:textField.text];
        parks = [attractionsInPark allKeys];
        
        [self.tableView reloadData];
        
        if (hud) {
            [hud setHidden:YES];
            hud = nil;
        }
        
        return NO;
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 20;
    
    _search_TextField.delegate = self;
    
    DBHelp *db = [[DBHelp alloc] init];
    attractionsInPark = [db getAttractionsByPark];
    parks = [attractionsInPark allKeys];
    
    // pull refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(pullReresh) forControlEvents:UIControlEventValueChanged];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
//    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Loading..."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    if ([AppDelegate isImage:attraction.Image]) {
        cell.img.image = [UIImage imageNamed:@"Load.png"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:attraction.Image]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.img.image = img;
            });
        });
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
    
    DetailViewController *vc = (DetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    vc.selectedAttraction = (Attraction *)[relactions objectAtIndex:indexPath.row];
    vc.relations = [NSMutableArray arrayWithArray:relactions];
    [vc.relations removeObjectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
