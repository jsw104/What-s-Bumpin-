//
//  Location.h
//  What's Bumpin'
//
//  Created by Justin Wang on 2/12/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GooglePlaces;

@interface Location : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSInteger *bumps;
@property (nonatomic) CLLocationCoordinate2D *coordinates;

@end
