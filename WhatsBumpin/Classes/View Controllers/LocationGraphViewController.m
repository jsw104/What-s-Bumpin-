//
//  LocationGraphViewController.m
//  WhatsBumpin
//
//  Created by Justin Wang on 3/20/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//
#import "Location.h"
#import "CorePlot.h"

@interface LocationGraphViewController: UIViewController

@property (strong, nonatomic) Location *location;
@property NSMutableArray *samples;
@end

@implementation LocationGraphViewController

-(void)loadView{
    [super loadView];
    
    [self setTitle:[NSString stringWithFormat: @"%@ Data", self.location.name]];
}

@end
