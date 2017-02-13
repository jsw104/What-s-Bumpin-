//
//  Location.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/12/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "Location.h"

@implementation Location

-(id)initWithName:(NSString *)name bumps: (NSInteger)bumps coordinates: (CLLocationCoordinate2D) coordinates bio: (NSString *)bio image: (UIImage *)image
{
    self = [super init];
    if (self) {
        self.name = name;
        self.bumps = bumps;
        self.coordinates = coordinates;
        self.bio = bio;
        self.image = image;
    }
    return self;
}

@end
