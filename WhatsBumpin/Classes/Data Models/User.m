//
//  User.m
//  What's Bumpin'
//
//  Created by Justin Wang on 2/21/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import "User.h"

@implementation User

static User *currentUser;

+(User *)getCurrentUser
{
    return currentUser;
}

+(void)loginWithID:(long)facebook_id name:(NSString *_Nullable)name 
{
    //make call to DB to login. if successful, return user and null error, otherwise return null user and error code
    //set current user
    currentUser = [[User alloc] init];
    currentUser.facebookID = facebook_id;
    currentUser.name = name;
    //currentUser.friends = friends;
    
    [currentUser postFacebookUser];
    
}

+(void)LoginPublic
{
    currentUser = [[User alloc] init];
}

-(void)setBio:(NSString *)bio
{
    self.bio = bio;
}

-(void)setLocation:(CLLocationCoordinate2D)coordinates
{
    self.coordinates = coordinates;
}

-(BOOL)isLoggedIn
{
    return TRUE;
    
   // return self.email != NULL;
}

-(void)saveInBackground
{
    
}

-(void) postFacebookUser {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://52.14.0.153/api/insert_user.php"]];
    [request setHTTPMethod:@"POST"];

    NSLog(@"NAME: %@", currentUser.name);
    UIDevice *device = [UIDevice currentDevice];
    NSString *uniqueIdentifier = [[device identifierForVendor] UUIDString];
    NSLog(@"UID: %@", uniqueIdentifier);
    NSString *post = [[NSString alloc] initWithFormat:@"facebook_name=%@&facebook_id=%ld&device_id=%@&submit=", currentUser.name, currentUser.facebookID, uniqueIdentifier];
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest: request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"response: %@, err %@", response, error);
    }];
    
    [task resume];

    
    
}

@end
