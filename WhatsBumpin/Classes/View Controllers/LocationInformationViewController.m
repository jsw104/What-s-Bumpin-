//
//  LocationInformationViewController.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/13/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "LocationInformationViewController.h"

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
    
    NSURL *googleRequestURL=self.location.photoURLs.firstObject;
    
    // Retrieve the results of the URL.
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.locationImageView.image = [UIImage imageWithData:data];
        });
    });
    
//    self.locationBioLabel.text = self.location.bio;
    self.locationURLLabel.text = self.location.website.absoluteString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
