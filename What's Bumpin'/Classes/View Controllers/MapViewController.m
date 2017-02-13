//
//  FirstViewController.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/12/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "MapViewController.h"
@import GooglePlaces;
@import GoogleMaps;
#import "Location.h"

@interface MapViewController ()

@property GMSMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.80
                                                            longitude:151.20
                                                                 zoom:20];
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.view = self.mapView;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.800, 151.200);
    marker.title = @"Me";
    marker.map = self.mapView;
    
    //adds dummy locations
    [self addLocations];
}

- (void)addLocations
{
    NSArray <Location *> *locations = [self getLocations];
    for(Location *location in locations)
    {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = location.coordinates;
        marker.title = location.name;
        marker.snippet = [NSString stringWithFormat:@"%d bumps", location.bumps];
        marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:0 green:location.bumps/255.0 blue:0 alpha:1]];
        marker.map = self.mapView;
    }
}

- (NSArray <Location *> *) getLocations
{
    Location *l1 = [[Location alloc] initWithName:@"Corner Alley" bumps:222 coordinates:CLLocationCoordinate2DMake(-33.801, 151.200) bio:@"The hottest spot in town! Grab some friends and come swing by for a night of bowling and drinks!" image:[UIImage imageNamed:@"Corner Alley"]];
    Location *l2 = [[Location alloc] initWithName:@"The Jolly Scholar" bumps:87 coordinates:CLLocationCoordinate2DMake(-33.800, 151.201) bio:@"" image:[UIImage imageNamed:@"Corner Alley"]];
    Location *l3 = [[Location alloc] initWithName:@"Happy Dog" bumps:8 coordinates:CLLocationCoordinate2DMake(-33.801, 151.201) bio:@"" image:[UIImage imageNamed:@"Corner Alley"]];
    return [NSArray arrayWithObjects:l1, l2, l3, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
