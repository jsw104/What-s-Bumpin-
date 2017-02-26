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
+(void)LoginWithUsername:(NSString *)email password:(NSString *)password completionBlock:(void (^)(User *, NSError *error))completion;
+(void)LoginPublic;
+(nullable User *)getCurrentUser;

//instance methods
-(void)setBio;
-(void)setLocation:(CLLocationCoordinate2D)coordinates;

//variables
@property (nonatomic) int userID;
@property (strong, nonatomic, nullable) NSString *email;
@property (strong, nonatomic, nullable) NSString *bio;
@property (nonatomic) CLLocationCoordinate2D coordinates;

@end
