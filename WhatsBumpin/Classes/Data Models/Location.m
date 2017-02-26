//
//  Location.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/12/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "Location.h"

@implementation Location

NSHashTable<Bump *>*bumps;
MessageBoard *messageBoard;

-(id)init
{
    self = [super init];
    if (self != NULL) {
        [self loadBumps];
        [self loadMessageBoard];
    }
    return self;
}

- (void)loadBumps
{
    bumps = [[NSHashTable alloc] init];
}

- (void)loadMessageBoard
{
    messageBoard = [[MessageBoard alloc] init];
}

+ (void)getLocationsWithRadius: (double)radius minimumBumps: (int)minBumps completionBlock:(void (^)(NSArray <Location *> *locations, NSError *error))completion
{
    completion(NULL, NULL);
}

- (int)getBumpCountBetween:(NSDate *)earlierDate and:(NSDate *)laterDate
{
    return 0;
}

- (void)bump
{
    User *user = [User getCurrentUser];
    if (user) {
        [self bumpPrivate:user];
    } else {
        [self bumpPublic];
    }
}

- (void)bumpPrivate:(User *)user
{
    Bump *newBump = [[Bump alloc] initWithUsername:user.email locationWithCoordinate:self.coordinate];
    
    //TODO might want to use different data structure here:
    
    //have to override hashcode and isequal methods on Bump for contains to work correctly
    if ([bumps containsObject:newBump]) {
        //check if date is within one day here
    }
}

- (void)bumpPublic
{
    Bump *newBump = [[Bump alloc] initWithUsername:NULL locationWithCoordinate:self.coordinate];
}

- (void)addBump
{
    
}

@end
