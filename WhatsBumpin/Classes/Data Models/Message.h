//
//  Message.h
//  What's Bumpin'
//
//  Created by Justin Wang on 2/21/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@import GooglePlaces;

@interface Message : NSObject

@property (strong, nonatomic, nonnull) NSString *username;
@property (strong, nonatomic, nonnull) NSString *message_text;
//@property (strong, nonatomic, nonnull) Location *location;

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic, nonnull) NSDate *date;

@end
