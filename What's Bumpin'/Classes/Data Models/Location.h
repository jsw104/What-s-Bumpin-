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

@interface Location : GMSPlace

//methods
- (void)bump:(User *)user;

//variables
@property (strong, nonatomic) NSHashTable *bumps;

@end
