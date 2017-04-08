//
//  SettingsViewController.m
//  WhatsBumpin
//
//  Created by Alex Lucas on 5/4/2017.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "SettingsViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "FBLoginViewController.h" 


@interface SettingsViewController ()
<FBSDKLoginButtonDelegate>
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *logoutButton;

@end

@implementation SettingsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    //self.tabBarItem.selectedImage = [[UIImage imageNamed:@"Settings_selected.png"]
                                 //    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    self.tabBarItem.image = [[UIImage imageNamed:@"settings_unselected.png"]
//                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_logoutButton setDelegate:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"FBLogin"
                                                         bundle:nil];
    FBLoginViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    [self presentViewController:login animated:YES completion:nil];

}

- (void) loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    
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
