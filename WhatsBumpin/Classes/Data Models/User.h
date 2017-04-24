//
//  User.h
//  What's Bumpin'
//
//  Created by Justin Wang on 2/21/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GooglePlaces;

@interface User : NSObject

//class methods
+(void)loginWithID:(long)facebook_id name:(NSString *_Nullable)name;
+(void)LoginPublic;
+(nullable User *)getCurrentUser;

//instance methods
-(void)setBio;
-(void)setLocation:(CLLocationCoordinate2D)coordinates;
-(BOOL)isLoggedIn;
-(void)logout;

//variables
@property (nonatomic) long facebookID;
@property (strong, nonatomic, nullable) NSString *name;
@property (strong, nonatomic, nullable) NSString *bio;
@property (nonatomic) CLLocationCoordinate2D coordinates;
@property (nonatomic, nullable) NSMutableArray<User *>* friends;

@end
