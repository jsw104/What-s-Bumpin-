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
    
    [self.navigationController.navigationBar setHidden:false];
    
    _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [[UIImage imageNamed:@"Message"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_messageButton setImage:image forState:UIControlStateNormal];
    _messageButton.tintColor = [UIColor colorWithRed:0xff/255.0 green:0x2d/255.0 blue:0x55/255.0 alpha:1];


}

- (void)configureViewContent
{
    self.title = self.location.name;
    [self.locationNameLabel sizeToFit];
    CGRect newFrame = self.locationNameLabel.frame;
    newFrame.size.height = newFrame.size.height + 80;
    [self.locationNameLabel setFrame:newFrame];
    self.locationURLLabel.text = [NSString stringWithFormat:@"website: %@", [self.location.website absoluteString]];
    
    self.locationBioLabel.text = self.location.locationDescription;
    
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
