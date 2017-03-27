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

@end

