//
//  Message.h
//  What's Bumpin'
//
//  Created by Justin Wang on 2/21/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@import GooglePlaces;

@interface Message : NSObject

-(nullable id)initWithUserID: (long)facebook_id locationID:(NSString *_Nullable) googlePlacesID andMessage: (NSString *_Nullable)message;

-(void)saveInBackgroundWithCompletionBlock:(void (^_Nullable)(BOOL success))completion;

@property (nonatomic) long facebook_id;
@property (strong, nonatomic, nonnull) NSString *googlePlacesID;
@property (strong, nonatomic, nonnull) NSDate *date;
@property (strong, nonatomic, nonnull) NSString *message_text;
@property (strong, nonatomic, nonnull) NSString *name;
@property (strong, nonatomic, nonnull) NSString *locationID;


@end
