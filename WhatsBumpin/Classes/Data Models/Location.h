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
#import "MessageBoard.h"

@interface Location : NSObject

//static methods
+ (void)getLocationsWithRadius: (double)radius minimumBumps: (int)minBumps completionBlock:(void (^)(NSArray <Location *> *locations, NSError *error))completion;

//instance methods
- (void)bump;
- (int)getBumpCountBetween:(NSDate *)earlierDate and:(NSDate *)laterDate;

@property (strong, nonatomic) NSString *name;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSURL *website;

@end
