//
//  Bump.h
//  What's Bumpin'
//
//  Created by Justin Wang on 2/21/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GooglePlaces;

@interface Bump : NSObject

-(nullable id)initWithUsername: (nullable NSString *)username locationWithCoordinate:(CLLocationCoordinate2D) coordinate;

//variables
@property (strong, nonatomic, nullable) NSString *username;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic, nonnull) NSDate *date;

@end