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
#import "User.h"


@interface SettingsViewController ()
<FBSDKLoginButtonDelegate>
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *logoutButton;
@property (weak, nonatomic) IBOutlet UISlider *minBumpSlider;
@property (weak, nonatomic) IBOutlet UILabel *minBumpLabel;

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
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"minBump"] != nil){
        NSString *bumps = [[NSUserDefaults standardUserDefaults] valueForKey:@"minBump"];
        [self.minBumpLabel setText:bumps];
        [self.minBumpSlider setValue:bumps.integerValue];
        
    }
    else {
        [self.minBumpLabel setText:@"10"];
    }
    

}
- (IBAction)sliderValueChanged:(UISlider *)sender {
    [self roundBumpSlider:sender];
}

- (void)roundBumpSlider:(UISlider *)sender
{
    int sliderValue;
    sliderValue = sender.value;
    [(UISlider *)sender setValue:sliderValue animated:YES];
    [self.minBumpLabel setText:[NSString stringWithFormat:@"%i", sliderValue]];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i", sliderValue] forKey:@"minBump"];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    [[User getCurrentUser] logout];
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
