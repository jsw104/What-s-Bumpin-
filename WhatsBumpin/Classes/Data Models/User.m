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

+(void)LoginWithUsername: (NSString *) email password: (NSString *) password completionBlock: (void (^)(User *user, NSError *error))completion
{
    //make call to DB to login. if successful, return user and null error, otherwise return null user and error code
    //set current user
    currentUser = [[User alloc] init];
    currentUser.email = email;
    
    return completion(NULL, NULL);
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

-(void)saveInBackground
{
    
}

@end
