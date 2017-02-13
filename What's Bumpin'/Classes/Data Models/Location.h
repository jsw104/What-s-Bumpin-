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
-(id)initWithName:(NSString *)name bumps: (NSInteger)bumps coordinates: (CLLocationCoordinate2D) coordinates bio: (NSString *)description image: (UIImage *)image;

//variables
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) UIImage *image;
@property (nonatomic) NSInteger bumps;
@property (nonatomic) CLLocationCoordinate2D coordinates;

@end
