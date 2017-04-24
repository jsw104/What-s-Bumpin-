//
//  LocationInformationViewController.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/13/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "LocationInformationViewController.h"
#import "LocationGraphViewController.h"
#import "LocationMessageViewController.h"

@interface LocationInformationViewController ()

@end

@implementation LocationInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViewContent];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setHidden:false];
    
    _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [[UIImage imageNamed:@"Message"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_messageButton setImage:image forState:UIControlStateNormal];
    _messageButton.tintColor = [UIColor colorWithRed:0xff/255.0 green:0x2d/255.0 blue:0x55/255.0 alpha:1];

    NSLog(@"%@", _location.googlePlacesID);

}

- (void)configureViewContent
{
    self.title = self.location.name;
    

    self.locationAddressLabel.text = self.location.address;
    if(self.location.openNow){
        self.locationOpenLabel.text = @"OPEN";
        [self.locationOpenLabel setTextColor:[UIColor colorWithRed:0 green:0x80/255.0 blue:0 alpha:1]];
    }
    else {
        self.locationOpenLabel.text = @"CLOSED";
        [self.locationOpenLabel setTextColor: [UIColor colorWithRed:0xC0/255.0 green:0x21/255.0 blue:0x3B/255.0 alpha:1] ];
    }
    
    
    NSLog(@"lid: %@", self.location.googlePlacesID);
    [self.location getBumpCountWithCompletion:^(int bumpCount) {
        dispatch_async(dispatch_get_main_queue(), ^{

        [self.bumpLabel setText:[NSString stringWithFormat:@"%d", bumpCount]];
            [self.bumpLabel setNeedsDisplay];
        });
    }];
    
    NSURL *googleRequestURL=self.location.photoURLs.firstObject;
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.locationImageView.image = [UIImage imageWithData:data];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"LocationGraph"]) {
        ((LocationGraphViewController *)[segue destinationViewController]).location = self.location;
    }
    if ([[segue identifier] isEqualToString:@"LocationMessages"]) {
        NSLog(@"salloc: %@", self.location);
        ((LocationMessageViewController *)[segue destinationViewController]).location = self.location;
    }
}

@end
