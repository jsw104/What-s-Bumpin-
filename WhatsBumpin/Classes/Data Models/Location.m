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

- (double)distanceToLocation: (CLLocationCoordinate2D)location
{
    return fabs(location.latitude - self.coordinate.latitude) + fabs(location.longitude - self.coordinate.longitude);
}

+ (void)getLocationsWithRadius: (int)radiusInMiles minimumBumps: (int)minBumps type: (WBType)types completionBlock:(void (^)(NSArray <Location *> *locations, NSError *error))completion
{
    NSLog(@"LAT: %f", [User getCurrentUser].coordinates.latitude);
    if ((types & WBFood) == WBFood) {
        [Location createAndExecuteURL: [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", [User getCurrentUser].coordinates.latitude, [User getCurrentUser].coordinates.longitude, [NSString stringWithFormat:@"%i", [self milesToMeters:radiusInMiles]], [Location WBTypeToString:WBFood], @"AIzaSyAXtLf-_lGIafvi3Nqrc4m24I0ehPp5ekU"]] completionBlock:completion];
    }
    if ((types & WBDayTime) == WBDayTime) {
        NSLog(@"day");

        [Location createAndExecuteURL: [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", [User getCurrentUser].coordinates.latitude, [User getCurrentUser].coordinates.longitude, [NSString stringWithFormat:@"%i", [self milesToMeters:radiusInMiles]], [Location WBTypeToString:WBDayTime], @"AIzaSyAXtLf-_lGIafvi3Nqrc4m24I0ehPp5ekU"]] completionBlock:completion];
    }
    
    if ((types & WBNightLife) == WBNightLife) {
        NSLog(@"night");

        [Location createAndExecuteURL: [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", [User getCurrentUser].coordinates.latitude, [User getCurrentUser].coordinates.longitude, [NSString stringWithFormat:@"%i", [self milesToMeters:radiusInMiles]], [Location WBTypeToString:WBNightLife], @"AIzaSyAXtLf-_lGIafvi3Nqrc4m24I0ehPp5ekU"]] completionBlock:completion];
    }
}

+ (void) createAndExecuteURL: (NSURL *)googleRequestURL completionBlock:(void (^)(NSArray <Location *> *locations, NSError *error))completion
{
    // Retrieve the results of the URL.
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        completion([self fetchedData:data], NULL);
    });
}

+ (int)milesToMeters:(int)miles
{
    return miles * 1609;
}

+ (NSString *)WBTypeToString:(WBType)type
{
    if (type == WBDayTime) {
        return @"shopping_mall";
    }
    else if (type == WBNightLife)
    {
        return @"night_club";
    }
    else if (type == WBFood)
    {
        return @"restaurant";
    }
    else if (type == WBCafe)
    {
        return @"cafe";
    }

    return NULL;
}

+(NSArray <Location *> *)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    
    //The results from Google will be an array obtained from the NSDictionary object with the key "results".
    NSArray* places = [json objectForKey:@"results"];
    
    return [self createLocationsFromJSON:places];
}

+(NSArray <Location *> *)createLocationsFromJSON:(NSArray *)data {
    NSMutableArray <Location *> *locations = [[NSMutableArray alloc] init];
    
    // 2 - Loop through the array of places returned from the Google API.
    for (int i=0; i<[data count]; i++) {
        //Retrieve the NSDictionary object in each index of the array.
        NSDictionary* place = [data objectAtIndex:i];
        // 3 - There is a specific NSDictionary object that gives us the location info.
        NSDictionary *geo = [place objectForKey:@"geometry"];
        // Get the lat and long for the location.
        NSDictionary *loc = [geo objectForKey:@"location"];

        NSString *vicinity=[place objectForKey:@"vicinity"];
        NSArray *photoInfoArray = [place objectForKey:@"photos"];
        NSMutableArray *photoURLs = [[NSMutableArray alloc] init];
        for(NSDictionary *photoInfo in photoInfoArray)
        {
            NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=%i&photoreference=%@&key=%@", 10000, [photoInfo objectForKey:@"photo_reference"], @"AIzaSyAXtLf-_lGIafvi3Nqrc4m24I0ehPp5ekU"];
            [photoURLs addObject:[NSURL URLWithString:url]];
        }
        
        // Create a special variable to hold this coordinate info.
        CLLocationCoordinate2D placeCoord;
        // Set the lat and long.
        placeCoord.latitude=[[loc objectForKey:@"lat"] doubleValue];
        placeCoord.longitude=[[loc objectForKey:@"lng"] doubleValue];
        // 5 - Create a new annotation.
        Location *location = [[Location alloc] init];
        location.name = [place objectForKey:@"name"];
        location.locationDescription = [place objectForKey:@"address_components"];
        
        

        location.coordinate = placeCoord;
        location.icon = [place objectForKey:@"icon"];
        location.photoURLs = [NSArray arrayWithArray:photoURLs];
        location.googlePlacesID = [place objectForKey:@"place_id"];
        [locations addObject:location];
    }
    return locations;
}

- (int)getBumpCountBetween:(NSDate *)earlierDate and:(NSDate *)laterDate
{
    return 0;
}

- (void)bump
{
    User *user = [User getCurrentUser];
    [[Bump alloc] initWithUsername: user.facebookID locationWithID:self.googlePlacesID];
    
    /*if (user) {
        [self bumpPrivate:user];
    } else {
        [self bumpPublic];
    }*/
}

- (void)bumpPrivate:(User *)user
{
    //Bump *newBump = [[Bump alloc] initWithUsername:user.userID locationWithID:self.goo
    
    //TODO might want to use different data structure here:
    
    //have to override hashcode and isequal methods on Bump for contains to work correctly

}

- (void)bumpPublic
{
    //Bump *newBump = [[Bump alloc] initWithUsername:NULL locationWithCoordinate:self.coordinate];
}

- (void)addBump
{
    
}

@end
