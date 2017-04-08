//
//  FBLoginViewController.m
//  WhatsBumpin
//
//  Created by Alex Lucas on 8/4/2017.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "FBLoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FBLoginViewController ()
<FBSDKLoginButtonDelegate>
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@end

@implementation FBLoginViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [_loginButton setDelegate:self];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"FBbg.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];


    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        //self.view.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.view.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
       // blurEffectView.alpha = 0.91;

        [self.view insertSubview:blurEffectView atIndex:0];
    } else {
        self.view.backgroundColor = [UIColor blackColor];
    }

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)
loginButton:	(FBSDKLoginButton *)loginButton
didCompleteWithResult:	(FBSDKLoginManagerLoginResult *)result
error:	(NSError *)error {
    NSLog(@"RESULT %@: ", result);
    
    if (result.grantedPermissions) {
        [self dismissViewControllerAnimated:TRUE completion:nil];
    }
    
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
