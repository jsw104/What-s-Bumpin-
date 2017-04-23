//
//  FirstViewController.h
//  What's Bumpin'
//
//  Created by Justin Wang on 2/12/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shimmer/FBShimmeringView.h"
@import GoogleMaps;

@interface MapViewController : UIViewController

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) IBOutlet FBShimmeringView *searchBarContainerView;
- (IBAction)filter:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *filterView;
@property (strong, nonatomic) IBOutlet UISlider *radiusSlider;
@property (strong, nonatomic) IBOutlet UISlider *minimumBumpsSlider;
@property (strong, nonatomic) IBOutlet UILabel *radiusLabel;
@property (strong, nonatomic) IBOutlet UILabel *minimumBumpsLabel;

@end

