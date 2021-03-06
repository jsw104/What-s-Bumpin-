//
//  Bump.h
//  What's Bumpin'
//
//  Created by Justin Wang on 2/21/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
@import GooglePlaces;

@interface Bump : NSObject

-(nullable id)initWithUsername: (long)facebook_id locationWithID:(nonnull NSString *) googlePlacesID;
-(void)saveInBackgroundWithCompletionBlock:(void (^)(bool success))completion;
//- (void) bumpWithCompletionBlock:(void (^_Nullable)(BOOL successful))completion;

//variables
@property (nonatomic) long facebook_id;
@property (strong, nonatomic, nonnull) NSString *googlePlacesID;
@property (strong, nonatomic, nonnull) NSDate *date;

@end
