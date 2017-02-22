//
//  Message.h
//  What's Bumpin'
//
//  Created by Justin Wang on 2/21/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GooglePlaces;

@interface Message : NSObject

@property (strong, nonatomic, nullable) NSString *username;
@property (strong, nonatomic, nonnull) NSString *text;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
