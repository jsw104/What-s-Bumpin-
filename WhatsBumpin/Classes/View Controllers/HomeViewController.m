//
//  SecondViewController.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/12/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "HomeViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [self performSegueWithIdentifier:@"showUserHome" sender:self];
    }
    else {
        [self performSegueWithIdentifier:@"FacebookLogin" sender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
