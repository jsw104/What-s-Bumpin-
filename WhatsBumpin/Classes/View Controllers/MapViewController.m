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

@interface MapViewController () <CLLocationManagerDelegate, GMSMapViewDelegate, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UIGestureRecognizerDelegate>

@property NSMutableArray <Location *>*locations;
@property Location *locationSelected;
@property (strong, nonatomic) UISearchController *searchController;
@property int updatedSearchText;

@end

static double delayInSeconds = 0.5;

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [User LoginPublic];

    self.mapView.delegate = self;
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
    
    [self configureSearchBar];
    [self configureFilterView];
}

- (void)configureFilterView
{
    self.filterView = [[[NSBundle mainBundle]
                     loadNibNamed:@"FilterView"
                     owner:self options:nil]
                    firstObject];
    [self.filterView setFrame:CGRectMake(self.searchBarContainerView.frame.origin.x, self.searchBarContainerView.frame.origin.y + self.searchBarContainerView.frame.size.height, self.view.frame.size.width, 200)];
    
    [self.filterView setHidden:true];
    [self.view addSubview:self.filterView];
    
    [self.radiusLabel setText:[NSString stringWithFormat:@"%i miles", (int)lroundf(self.radiusSlider.value)]];
    [self.minimumBumpsLabel setText:[NSString stringWithFormat:@"%i bumps", (int)lroundf(self.minimumBumpsSlider.value)]];
}

- (IBAction)distanceSliderValueChanged:(id)sender
{
    [self roundDistanceSlider:sender];
}

- (IBAction)bumpsSliderValueChanged:(id)sender
{
    [self roundBumpSlider:sender];
}

- (void)roundDistanceSlider:(id)sender
{
    int sliderValue;
    sliderValue = lroundf(((UISlider *)sender).value);
    [(UISlider *)sender setValue:sliderValue animated:YES];
    [self.radiusLabel setText:[NSString stringWithFormat:@"%i miles", sliderValue]];
}

- (void)roundBumpSlider:(id)sender
{
    int sliderValue;
    sliderValue = lroundf(((UISlider *)sender).value);
    [(UISlider *)sender setValue:sliderValue animated:YES];
    [self.minimumBumpsLabel setText:[NSString stringWithFormat:@"%i bumps", sliderValue]];
}

- (void)configureSearchBar
{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.searchController.delegate = self;
    self.searchController.searchResultsUpdater = self;
    
    [self.searchBarContainerView addSubview: self.searchController.searchBar];
    self.definesPresentationContext = YES;
    self.searchController.searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.searchController.searchBar sizeToFit];
    self.searchController.hidesNavigationBarDuringPresentation = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // load results from google api
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if (!self.searchBarContainerView.contentView)
    {
        self.searchBarContainerView.contentView = self.searchController.searchBar;
    }

    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       self.updatedSearchText--;
                       if (self.updatedSearchText == 0){
                           // load results from google api
                       }
                   });
    
    
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
        GMSCameraUpdate *locationUpdate = [GMSCameraUpdate setTarget:location.coordinate zoom:18];
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
        [marker setUserData:location];
        marker.snippet = [NSString stringWithFormat:@"%d bumps", [location getBumpCountBetween:[NSDate distantPast] and:[NSDate distantFuture]]];
        marker.icon = [GMSMarker markerImageWithColor:[UIColor colorWithRed:0 green:100/255.0 blue:0 alpha:1]];
        marker.map = self.mapView;
    }
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    self.locationSelected = marker.userData;
    [self performSegueWithIdentifier:@"Location Information" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//this is hardcoded right now
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ((LocationInformationViewController*)segue.destinationViewController).location = self.locationSelected;
}

- (IBAction)filter:(id)sender {
    self.filterView.hidden ? [((UIButton *)sender) setTitle:@"Apply" forState:UIControlStateNormal] : [((UIButton *)sender) setTitle:@"Filter" forState:UIControlStateNormal];
    [self.filterView setHidden:!self.filterView.hidden];
}

@end
