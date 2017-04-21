//
//  FirstViewController.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/12/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "MapViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "FBLoginViewController.h"
#import "LocationInformationViewController.h"
@import GooglePlaces;
#import "Location.h"

@interface MapViewController () <CLLocationManagerDelegate, GMSMapViewDelegate, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UIGestureRecognizerDelegate, GMSAutocompleteViewControllerDelegate>

@property NSMutableArray <Location *>*locations;
@property Location *locationSelected;
@property (strong, nonatomic) UISearchController *searchController;
@property int updatedSearchText;
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIView *buttonView;



@end

static double delayInSeconds = 0.5;

@implementation MapViewController
int dayNightState = 0;
bool food = false;
bool coffee = false;
bool bumpFilter = false;
bool day = false;
bool night = false;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:TRUE];

}
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
    
    [self configureFilterView];
    
    
    
    if (! [FBSDKAccessToken currentAccessToken]) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"FBLogin"
                                                             bundle:nil];
        FBLoginViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self presentViewController:login animated:YES completion:nil];
    }
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    _blurEffectView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIButton *blurbutton = [[UIButton alloc] initWithFrame:_blurEffectView.frame];
    [blurbutton addTarget:self action:@selector(exitFilterView) forControlEvents: UIControlEventTouchUpInside];
    [_blurEffectView addSubview:blurbutton];


}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Longitude: %@", [NSString stringWithFormat: @"%f", newLocation.coordinate.longitude]); // string value
//    StrCurrentLatitude=[NSString stringWithFormat: @"%f", newLocation.coordinate.latitude];
//    appDeleg.newlocation=newLocation;
    [self.locationManager stopUpdatingLocation]; // string Value
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
    
    [self.radiusLabel setText:[NSString stringWithFormat:@"%i", (int)lroundf(self.radiusSlider.value)]];
    [self.minimumBumpsLabel setText:[NSString stringWithFormat:@"%i", (int)lroundf(self.minimumBumpsSlider.value)]];
    [self.foodButton setSelected:true];
    [self.dayTimeButton setSelected:true];
    [self.nightLifeButton setSelected:true];
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
    [self.radiusLabel setText:[NSString stringWithFormat:@"%i", sliderValue]];
}

- (void)roundBumpSlider:(id)sender
{
    int sliderValue;
    sliderValue = lroundf(((UISlider *)sender).value);
    [(UISlider *)sender setValue:sliderValue animated:YES];
    [self.minimumBumpsLabel setText:[NSString stringWithFormat:@"%i", sliderValue]];
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

- (IBAction)dayNightButtonPressed:(UIButton *)sender {
    if(sender.isSelected == YES && dayNightState == 1){
        [sender setImage:[UIImage imageNamed:@"Night"] forState:UIControlStateSelected];
        day = false;
        night = true;
        
    }
    else if(sender.isSelected == YES && dayNightState == 2){
        [sender setSelected:NO];
        day = false;
        night = false;
    }
    
    else {
        [sender setImage:[UIImage imageNamed:@"Day"] forState:UIControlStateSelected];

        [sender setSelected:YES];
        night = false;
        day = true;
    }
    dayNightState = (dayNightState + 1) %3;
    
}

- (IBAction)foodButtonPressed:(UIButton *)sender {
    [sender setSelected:!sender.isSelected];
    food = !food;
}

- (IBAction)coffeeButtonPressed:(UIButton *)sender {
    [sender setSelected:!sender.isSelected];
    coffee = !coffee;
}

- (IBAction)bumpButtonPressed:(UIButton *)sender {
    [sender setSelected:!sender.isSelected];
    bumpFilter = !bumpFilter;

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
    if (fabs(howRecent) < 15.0) {

        [[User getCurrentUser] setLocation:location.coordinate];
        
        [self getLocationsForUser];
        GMSCameraUpdate *locationUpdate = [GMSCameraUpdate setTarget:location.coordinate zoom:18];
        [self.mapView animateWithCameraUpdate:locationUpdate];
    }
    [manager stopUpdatingLocation];
}

- (void)getLocationsForUser
{
    WBType locationTypes = 0;
    if (day) { //if daytime
        locationTypes = locationTypes | WBDayTime;
    }
    if (night) { //if nighttime
        locationTypes = locationTypes | WBNightLife;
    }
    if (food) {
        locationTypes = locationTypes | WBFood;
    }
    if (coffee) {
        locationTypes = locationTypes | WBCafe;
    }
    if (self.locations) {
        //remove all markers here as well
        [self.locations removeAllObjects];
    }
    NSLog(@"RADIUS: %@", self.radiusLabel.text);
    [Location getLocationsWithRadius:self.radiusLabel.text.intValue minimumBumps:self.minimumBumpsLabel.text.intValue type:locationTypes completionBlock:^(NSArray<Location *> *locations, NSError *error) {
        NSLog(@"Locations %@", locations);
        self.locations = [NSMutableArray arrayWithArray:locations];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addLocationsToMap];
        });
        
    }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //display error message to the user
}

- (void)addLocationsToMap
{
    NSLog(@"Locations: %@", self.locations);

    for(Location *location in self.locations) {
        NSLog(@"Adding");

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

- (void)showFilterView:(id)sender
{
    [((UIButton *)sender) setTitle:@"Apply" forState:UIControlStateNormal];
    [UIView transitionWithView:self.filterView duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
        [self.filterView setHidden:false];
    } completion:nil];
}

- (void)applyFilters:(id)sender
{
    [self getLocationsForUser];
    [((UIButton *)sender) setTitle:@"Filter" forState:UIControlStateNormal];
    [UIView transitionWithView:self.filterView duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
        [self.filterView setHidden:true];
    } completion:nil];
}

- (Location *)getClosestLocation {
    int minDistance = 0;
    return self.locations.firstObject;
    for(Location *location in self.locations)
    {
        
    }
}

- (IBAction)bump:(id)sender {
    [[self getClosestLocation] bump];
}

- (IBAction)togglePlaceType:(id)sender {
    ((UIButton *)sender).selected ? [self unselectPlaceType:sender] : [self selectPlaceType:sender];
    [((UIButton *)sender) setSelected:!((UIButton *)sender).selected];
}

- (void)unselectPlaceType:(id)sender
{
    ((UIButton *)sender).alpha = 0.25;
}

- (void)selectPlaceType:(id)sender
{
    ((UIButton *)sender).alpha = 1.0;
}

- (IBAction)fitlerButtonPressed:(UIButton *)sender {
    
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        // UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(0, _searchView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
        //  self.view.backgroundColor = [UIColor clearColor];
        
        [self.view insertSubview:_blurEffectView atIndex:2];
    } else {
        self.view.backgroundColor = [UIColor blackColor];
    }
    
    [UIView animateWithDuration:0.3 animations: ^{
        [_buttonView setAlpha:0];        
        [_searchView setFrame:CGRectMake(0, 0, _searchView.frame.size.width, _searchView.frame.size.height)];
        
        [_blurEffectView setAlpha:1];
        
    }];
    
    
}

- (void) exitFilterView {
    [UIView animateWithDuration:0.3 animations: ^{
        [_buttonView setAlpha:1];
        
        [_searchView setFrame:CGRectMake(0, 20 - _searchView.frame.size.height, _searchView.frame.size.width, _searchView.frame.size.height)];
        
        [_blurEffectView setAlpha:0];
        
    } completion:^(BOOL finished) {
        [_blurEffectView removeFromSuperview];
        
    }];
    [self getLocationsForUser];
}



//** GMSAutocomplete Delegate Stuff

- (IBAction)onLaunchClicked:(id)sender {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    [filter setType:kGMSPlacesAutocompleteTypeFilterEstablishment];
    
    GMSVisibleRegion visibleRegion = self.mapView.projection.visibleRegion;

    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:visibleRegion.farLeft
                    coordinate:visibleRegion.nearRight];

    
    
    [acController setAutocompleteFilter:filter];
    
    [acController setAutocompleteBounds:bounds];
    
    [self presentViewController:acController animated:YES completion:nil];
    
}


// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Location id? %@", place.placeID);
    NSLog(@"Place attributions %@", place.attributions.string);
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


@end
