//
//  DetailViewController.h
//  TaipeiPark
//
//  Created by Nick Yang on 29/07/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Attraction.h"

@interface DetailViewController : UIViewController {
    IBOutlet UIImageView *img;
    IBOutlet UILabel *parkName;
    IBOutlet UILabel *name;
    IBOutlet UILabel *openTime;
    IBOutlet UILabel *intro;
}

@property (weak, nonatomic) Attraction *selectedAttraction;

@end
