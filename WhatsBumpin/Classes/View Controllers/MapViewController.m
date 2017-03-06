//
//  FirstViewController.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/12/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "MapViewController.h"
#import "LocationInformationViewController.h"
@import GooglePlaces;
#import "Location.h"

@interface MapViewController () <CLLocationManagerDelegate>

@property NSMutableArray <Location *>*locations;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [User LoginPublic];

    self.mapView.myLocationEnabled = YES;
    
    //setup location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate=self;
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    self.locationManager.distanceFilter=kCLDistanceFilterNone;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startMonitoringSignificantLocationChanges];
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // Update your marker on your map using location.coordinate by using the GMSCameraUpdate object
        [[User getCurrentUser] setLocation:location.coordinate];
        [Location getLocationsWithRadius:1000 minimumBumps:0 type:@"bar" completionBlock:^(NSArray<Location *> *locations, NSError *error) {
            self.locations = [NSMutableArray arrayWithArray:locations];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addLocationsToMap];
            });
            
        }];
        GMSCameraUpdate *locationUpdate = [GMSCameraUpdate setTarget:location.coordinate zoom:20];
        [self.mapView animateWithCameraUpdate:locationUpdate];
    }
    [manager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //display error message to the user
}

- (void)addLocationsToMap
{
    for(Location *location in self.locations)
    {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = location.coordinate;
        marker.title = location.name;
        marker.snippet = [NSString stringWithFormat:@"%d bumps", [location getBumpCountBetween:[NSDate distantPast] and:[NSDate distantFuture]]];
        marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:0 green:100/255.0 blue:0 alpha:1]];
        marker.map = self.mapView;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//this is hardcoded right now
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ((LocationInformationViewController*)segue.destinationViewController).location = self.locations.firstObject;
}

@end
