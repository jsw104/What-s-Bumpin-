//
//  LocationInformationViewController.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/13/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "LocationInformationViewController.h"
#import "LocationGraphViewController.h"

@interface LocationInformationViewController ()

@end

@implementation LocationInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViewContent];
    // Do any additional setup after loading the view.
}

- (void)configureViewContent
{
    self.title = self.location.name;
    self.locationURLLabel.text = [NSString stringWithFormat:@"website: %@", [self.location.website absoluteString]];
    self.locationBioLabel.text = @"this is a description of the location";
    
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
}

@end
