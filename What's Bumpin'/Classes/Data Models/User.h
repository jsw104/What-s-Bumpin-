//
//  User.h
//  What's Bumpin'
//
//  Created by Justin Wang on 2/21/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

//class methods
+(void)LoginWithUsername:(NSString *)username password:(NSString *)password completionBlock:(void (^)(User *, NSError *error))completion;
+(void)RegisterWithUsername:(NSString *)username password:(NSString *)password completionBlock:(void (^)(Boolean success, NSError *error))completion;
+(nullable User *)getCurrentUser;

//instance methods
-(void)setBio;

//variables
@property (strong, nonatomic, nonnull) NSString *username;
@property (strong, nonatomic, nullable) NSString *bio;

@end
