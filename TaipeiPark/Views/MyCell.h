//
//  MyCell.h
//  TaipeiPark
//
//  Created by Nick Yang on 28/07/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttractionModel.h"

@interface MyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *parkName;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *introduction;

- (void)setupUI:(AttractionModel *)model;

@end
