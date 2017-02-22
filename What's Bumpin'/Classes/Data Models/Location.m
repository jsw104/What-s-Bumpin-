//
//  Location.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/12/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "Location.h"

@implementation Location

- (void)bump:(User *)user
{
    Bump *newBump = [[Bump alloc] initWithUsername:user.username locationWithCoordinate:self.coordinate];
    if ([self.bumps containsObject:newBump]) {
        
    }
}



@end
