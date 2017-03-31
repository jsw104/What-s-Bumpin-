//
//  UserHomeViewController.m
//  
//
//  Created by Alex Lucas on 3/31/17.
//
//

#import "UserHomeViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface UserHomeViewController ()

@end

@implementation UserHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __block long user_id;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    
    
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
                 NSDictionary *resultDict = (NSDictionary *) result;

                user_id = [[resultDict valueForKey:@"id"] longLongValue];
                 NSString *name = [resultDict valueForKey:@"name"];
                 [nameLabel setText:name];
                 [[self view] addSubview:nameLabel];

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
