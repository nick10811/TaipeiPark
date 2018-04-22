//
//  DetailViewController.h
//  TaipeiPark
//
//  Created by Nick Yang on 29/07/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttractionModel.h"
#import "DetailViewModel.h"

@interface DetailViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource> {
    IBOutlet UIImageView *img;
    IBOutlet UILabel *parkName;
    IBOutlet UILabel *name;
    IBOutlet UILabel *openTime;
    IBOutlet UILabel *intro;
}

@property (nonatomic, strong) DetailViewModel *viewModel;

@end
