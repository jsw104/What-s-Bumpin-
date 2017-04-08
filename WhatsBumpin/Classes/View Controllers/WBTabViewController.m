//
//  WBTabViewController.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/12/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "WBTabViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface WBTabViewController ()

@end

@implementation WBTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController *global = [UIStoryboard storyboardWithName:@"Global" bundle:nil].instantiateInitialViewController;
    UIViewController *me = [UIStoryboard storyboardWithName:@"Me" bundle:nil].instantiateInitialViewController;
    UIViewController *settings = [UIStoryboard storyboardWithName:@"Settings" bundle:nil].instantiateInitialViewController;

    NSArray <UIViewController *> *vcArray = [[NSArray alloc] initWithObjects:global, me, settings, nil];
    
    [UITabBar appearance].tintColor = [UIColor colorWithRed:0xff/255.0 green:0x2d/255.0 blue:0x55/255.0 alpha:1];

    self.viewControllers = vcArray;
    // Do any additional setup after loading the view.
    
      
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
