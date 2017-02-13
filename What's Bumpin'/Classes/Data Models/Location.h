//
//  Location.h
//  What's Bumpin'
//
//  Created by Justin Wang on 2/12/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GooglePlaces;

@interface Location : NSObject

//methods
-(id)initWithName:(NSString *)name bumps: (NSInteger)bumps coordinates: (CLLocationCoordinate2D) coordinates;

//variables
@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSInteger bumps;
@property (nonatomic) CLLocationCoordinate2D coordinates;

@end
