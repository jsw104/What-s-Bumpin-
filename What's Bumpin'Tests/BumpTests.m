//
//  BumpTests.m
//  WhatsBumpin
//
//  Created by Elle Zadina on 3/30/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Bump.h"
#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

Bump *bump;

@interface BumpTests : XCTestCase

@end

@implementation BumpTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    CLLocationDegrees latitude= 37.3305262;
    CLLocationDegrees longitude = -122.0290935;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    bump = [[Bump alloc] initWithUsername:@"Elle" locationWithCoordinate:coordinate];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBumpUsername {
    XCTAssertEqual(bump.username, @"Elle");
}

- (void)testBumpCoordinate {
}

- (void) testBumpDate{
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
