//
//  Bump.h
//  What's Bumpin'
//
//  Created by Justin Wang on 2/21/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GooglePlaces;

NS_ASSUME_NONNULL_BEGIN
@interface Bump : NSObject

-(id)initWithUsername: (NSString *)username locationWithCoordinate:(CLLocationCoordinate2D) coordinate;

//variables
@property (strong, nonatomic) NSString *username;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSDate *date;

@end
NS_ASSUME_NONNULL_END