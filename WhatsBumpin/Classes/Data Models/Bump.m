//
//  Bump.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/21/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "Bump.h"

@implementation Bump

-(id)initWithUsername: (NSString *)username locationWithCoordinate:(CLLocationCoordinate2D) coordinate
{
    self = [super init];
    if (self != nil)
    {
        self.username = username;
        self.coordinate = coordinate;
        self.date = [NSDate date];
    }
    return self;
}

@end
