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
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation FBLoginViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setLabelSizes];
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

- (void) setLabelSizes {
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        // iPhone 4
        [_titleLabel setFont:[UIFont fontWithName:_titleLabel.font.fontName size:30]];
        [_descriptionLabel setFont:[UIFont fontWithName:_descriptionLabel.font.fontName size:12]];

    } else if ([UIScreen mainScreen].bounds.size.height == 568) {
        // IPhone 5
        [_titleLabel setFont:[UIFont fontWithName:_titleLabel.font.fontName size:34]];
        [_descriptionLabel setFont:[UIFont fontWithName:_descriptionLabel.font.fontName size:18]];

    } else if ([UIScreen mainScreen].bounds.size.width == 375) {
        // iPhone 6
        [_titleLabel setFont:[UIFont fontWithName:_titleLabel.font.fontName size:38]];
        [_descriptionLabel setFont:[UIFont fontWithName:_descriptionLabel.font.fontName size:20]];

    } else if ([UIScreen mainScreen].bounds.size.width == 414) {
        // iPhone 6+
        [_titleLabel setFont:[UIFont fontWithName:_titleLabel.font.fontName size:42]];
        [_descriptionLabel setFont:[UIFont fontWithName:_descriptionLabel.font.fontName size:24]];

    }
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
