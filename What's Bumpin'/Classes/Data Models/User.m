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

+(id)getCurrentUser
{
    return currentUser;
}

+(void)LoginWithUsername: (NSString *) username password: (NSString *) password completionBlock: (void (^)(User *user, NSError *error))completion
{
    //make call to DB to login. if successful, return user and null error, otherwise return null user and error code
    //set current user
    return completion(NULL, NULL);
}

+(void)RegisterWithUsername:(NSString *)username password:(NSString *)password completionBlock:(void (^)(Boolean success, NSError *error))completion
{
    
    return completion(false, NULL);
}

@end
