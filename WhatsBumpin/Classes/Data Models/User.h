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
+(void)LoginWithUsername:(NSString *_Nullable)email password:(NSString *_Nullable)password completionBlock:(void (^_Nullable)(User *_Nullable, NSError * _Nullable error))completion;
+(void)LoginPublic;
+(nullable User *)getCurrentUser;

//instance methods
-(void)setBio;
-(void)setLocation:(CLLocationCoordinate2D)coordinates;
-(BOOL)isLoggedIn;

//variables
@property (nonatomic) int userID;
@property (strong, nonatomic, nullable) NSString *email;
@property (strong, nonatomic, nullable) NSString *bio;
@property (nonatomic) CLLocationCoordinate2D coordinates;

@end
