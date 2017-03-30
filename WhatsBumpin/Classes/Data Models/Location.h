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
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface Location : NSObject

typedef NS_ENUM(NSInteger, WBType) {
    WBDayTime = 1,
    WBNightLife = 2,
    WBFood = 4,
};

//static methods
+ (void)getLocationsWithRadius: (int)radiusInMiles minimumBumps: (int)minBumps type: (WBType)types completionBlock:(void (^)(NSArray <Location *> *locations, NSError *error))completion;

//instance methods
- (void)bump;
- (int)getBumpCountBetween:(NSDate *)earlierDate and:(NSDate *)laterDate;

@property (strong, nonatomic) NSString *name;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSURL *website;
@property (strong, nonatomic) NSArray <NSURL *> *photoURLs;
@property (strong, nonatomic) UIImage *icon;
@property (nonatomic) WBType type;

@end
