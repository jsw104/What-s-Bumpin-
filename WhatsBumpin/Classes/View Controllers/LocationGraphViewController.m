//
//  LocationGraphViewController.m
//  WhatsBumpin
//
//  Created by Justin Wang on 3/20/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//
#import "Location.h"
//#import "CorePlot.h"

@interface LocationGraphViewController: UIViewController

@property (strong, nonatomic) Location *location;
@property NSMutableArray *samples;
@end

@implementation LocationGraphViewController

-(void)loadView{
    [super loadView];
    
    [self setTitle:[NSString stringWithFormat: @"%@ Data", self.location.name]];
}


-(void)loadBumpsPerDay {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://52.14.0.153/api/get_bumps_by_day_of_week.php"]];
    [request setHTTPMethod:@"POST"];
    
    NSString *post = [[NSString alloc] initWithFormat:@"location_id=%@&submit=", @"ChIJM5WTlIT7MIgRZXbXABw3OQw"]; ///change string to location_id; hardcoded for Jolly
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"data %@", dataString);
    }];
    
    [task resume];
}

@end
