//
//  RelationView.m
//  TaipeiPark
//
//  Created by Nick Yang on 29/07/2017.
//  Copyright © 2017 Nick Yang. All rights reserved.
//

#import "RelationView.h"

@implementation RelationView

@synthesize img;
@synthesize name;

-(instancetype)init{
    self = [super init];
    if (self) {
        self = [self initWithFrame:CGRectMake(0, 0, 100, 120)];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        img = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 80, 80)];
        [self addSubview:img];
        name = [[UILabel alloc] initWithFrame:CGRectMake(5, 90, 80, 20)];
        name.adjustsFontSizeToFitWidth = YES;
        [self addSubview:name];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
