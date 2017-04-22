//
//  Message.h
//  What's Bumpin'
//
//  Created by Justin Wang on 2/21/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//
#import "Location.h"

#import <Foundation/Foundation.h>

@import GooglePlaces;

@interface Message : NSObject

@property (strong, nonatomic, nonnull) NSString *name;
@property (strong, nonatomic, nonnull) NSString *message_text;
@property (strong, nonatomic, nonnull) NSString *locationID;
@property (strong, nonatomic, nonnull) NSString *date;

@end
