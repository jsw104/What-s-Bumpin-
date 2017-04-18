//
//  SearchTestViewController.m
//  WhatsBumpin
//
//  Created by Alex Lucas on 14/4/2017.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "SearchTestViewController.h"
#import <GooglePlaces/GooglePlaces.h>


@interface SearchTestViewController ()
<GMSAutocompleteViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UIButton *dayNightButton;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;

@end

@implementation SearchTestViewController



- (IBAction)filterButtonPressed:(UIButton *)sender {
    [sender setSelected: !sender.isSelected];

}
- (IBAction)fitlerButtonPressed:(UIButton *)sender {

    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        // UIView *blurView = [[UIView alloc] initWithFrame:CGRectMake(0, _searchView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
        //  self.view.backgroundColor = [UIColor clearColor];
        
        [self.view insertSubview:_blurEffectView atIndex:0];
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

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    _blurEffectView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIButton *blurbutton = [[UIButton alloc] initWithFrame:_blurEffectView.frame];
    [blurbutton addTarget:self action:@selector(exitFilterView) forControlEvents: UIControlEventTouchUpInside];
    [_blurEffectView addSubview:blurbutton];
    
 //   [(UIControl *) _blurEffectView addTarget:nil action:@selector(exitFilterView) forControlEvents: UIControlEventTouchUpInside];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)filterViewDragged:(UIView *)sender {
    NSLog(@"Dragged");
}

- (IBAction) handlePan: (UIPanGestureRecognizer*) recognizer {
    if ((recognizer.state == UIGestureRecognizerStateChanged) ||
        (recognizer.state == UIGestureRecognizerStateEnded))
    {
        CGPoint velocity = [recognizer velocityInView:self.view];
        
        if (velocity.y < 0)   // panning down
        {
            [self exitFilterView];
           // self.brightness = self.brightness -.02;
            //     NSLog (@"Decreasing brigntness in pan");
        }
           }}

// Present the autocomplete view controller when the button is pressed.
- (IBAction)onLaunchClicked:(id)sender {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    [filter setType:kGMSPlacesAutocompleteTypeFilterEstablishment];
    
    
    
    [acController setAutocompleteFilter:filter];
    
 //   acController setAutocompleteBounds:<#(GMSCoordinateBounds * _Nullable)#>
    [self presentViewController:acController animated:YES completion:nil];
}

// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
