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
<FBSDKLoginButtonDelegate>

@end

@implementation HomeViewController

UILabel *nameLabel;
UILabel *label;
FBSDKLoginButton *loginButton;

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
       [self updateHomeView];
    


}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//
    [self view].backgroundColor = [UIColor whiteColor];
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, 100, 100)];
    label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 1000, 100)];
    
    [[self view] addSubview:nameLabel];
    [[self view] addSubview:label];


    loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions = @[ @"email", @"user_friends", @"public_profile"];
    
    
    // Optional: Place the button in the center of your view.
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    [loginButton setDelegate:self];
    
    
    


    
//    if (![FBSDKAccessToken currentAccessToken]) {
//        [self performSegueWithIdentifier:@"FacebookLogin" sender:self];
//    }
    
    
    
//    __block long user_id;
//    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, 100, 100)];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 1000, 100)];
//    [label setText:@"Logged into facebook as"];
//    [self view].backgroundColor = [UIColor whiteColor];
//    [[self view] addSubview:label];
//
//    
//    if ([FBSDKAccessToken currentAccessToken]) {
//        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name"}]
//         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//             if (!error) {
//                 NSLog(@"fetched user:%@", result);
//                 NSDictionary *resultDict = (NSDictionary *) result;
//                 
//                 user_id = [[resultDict valueForKey:@"id"] longLongValue];
//                 NSString *name = [resultDict valueForKey:@"name"];
//                 [nameLabel setText:name];
//                 [[self view] addSubview:nameLabel];
//                 
//                 dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                     [self.view setNeedsDisplay];
//
//                     
//                 });
//                 
//                 NSString *friendPath = [NSString stringWithFormat:@"me/friends"];
//                 NSLog(@"friend path %@", friendPath);
//                 
//                 
//                 
//                 FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
//                                               initWithGraphPath:friendPath
//                                               parameters:@{@"fields": @"id, name"}
//                                               HTTPMethod:@"GET"];
//                 [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
//                                                       id result,
//                                                       NSError *error) {
//                     // Handle the result
//                     if(!error){
//                         NSLog(@"FRIENDS:%@", result);
//                     }
//                 }];
//                 
//             }
//         }];
//        
//    }
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)
loginButton:	(FBSDKLoginButton *)loginButton
didCompleteWithResult:	(FBSDKLoginManagerLoginResult *)result
error:	(NSError *)error {
    NSLog(@"RESULT %@: ", result);
    [self updateHomeView];
}

- (void) updateHomeView {
    
    __block long user_id;

    if ([FBSDKAccessToken currentAccessToken]) {

        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, email"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
                 NSDictionary *resultDict = (NSDictionary *) result;
                 
                 user_id = [[resultDict valueForKey:@"id"] longLongValue];
                 NSString *name = [resultDict valueForKey:@"name"];
                 [nameLabel setText:name];
                 [[self view] addSubview:nameLabel];
                 [label setText:@"Logged into facebook as"];

                 
                 dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                     [self.view setNeedsDisplay];
                     
                     
                 });

                 
                 NSString *friendPath = [NSString stringWithFormat:@"me/friends"];
                 NSLog(@"friend path %@", friendPath);
                 
                 
                 
                 FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                               initWithGraphPath:friendPath
                                               parameters:@{@"fields": @"id, name"}
                                               HTTPMethod:@"GET"];
                 [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                       id result,
                                                       NSError *error) {
                     // Handle the result
                     if(!error){
                         NSLog(@"FRIENDS:%@", result);
                     }
                 }];
                 
             }
         }];
        
    }
    else {
        NSLog(@"NOT LOGGED IN");
        dispatch_async(dispatch_get_main_queue(), ^{
            [nameLabel setText:@""];
            [label setText:@"Log in to facebook"];

            
            [nameLabel setNeedsDisplay];
        });

        
            
    

    }
    
  


}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    [self updateHomeView];
}


@end
