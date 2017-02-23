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
+(void)LoginWithUsername:(NSString *)email password:(NSString *)password completionBlock:(void (^)(User *, NSError *error))completion;
+(nullable User *)getCurrentUser;

//instance methods
-(void)setBio;

//variables
@property (nonatomic) int userID;
@property (strong, nonatomic, nullable) NSString *email;
@property (strong, nonatomic, nullable) NSString *bio;

@end
