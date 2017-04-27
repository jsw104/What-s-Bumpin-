//
//  LocationTests.m
//  WhatsBumpin
//
//  Created by Justin Wang on 3/31/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Location.h"
#import <Expecta/Expecta.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Expecta/Expecta.h>
@import GooglePlaces;

@interface LocationTests : XCTestCase

@end

@implementation LocationTests
Location *location;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [User loginWithID:1355547881173475 name:@"Alex Lucas"];
    location = [[Location alloc] init];
    location.googlePlacesID = @"ChIJNwaBOon7MIgRwyDK9r7VCnE";
}

- (void)testBumpWithCompletion{
    [location bumpWithCompletion:^(BOOL success){
        expect(success).to.equal(true);
    }];
}

-(void)testGetBumpCountWithCompletion{
    [location getBumpCountWithCompletion:^(int response){
        expect(response).notTo.equal(NULL);
    }];
}

-(void)testDistanceToLocation{
    double distance = [location distanceToLocation:CLLocationCoordinate2DMake(41.5043, 81.6084)];
    expect(distance).to.equal(123.1127);
}

-(void)testGetBumpCountBetweenDates{
   int bumps =  [location getBumpCountBetween:[[NSDate alloc] init] and:[[NSDate alloc]init]];
    expect(bumps).to.equal(0);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
