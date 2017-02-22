//
//  Location.h
//  What's Bumpin'
//
//  Created by Justin Wang on 2/12/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GooglePlaces;
#import "User.h"
#import "Bump.h"

@interface Location : GMSPlace

//methods
- (void)bump:(User *)user;

//variables
@property (strong, nonatomic) NSHashTable<Bump *>*bumps;

@end
