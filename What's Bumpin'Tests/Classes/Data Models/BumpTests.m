//
//  BumpTests.m
//  WhatsBumpin
//
//  Created by Elle Zadina on 3/31/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Bump.h"
#import <Expecta/Expecta.h>

Bump *bump;

@interface BumpTests : XCTestCase

@end

@implementation BumpTests

- (void)setUp {
        [super setUp];
        // Put setup code here. This method is called before the invocation of each test method in the class.
        bump = [[Bump alloc] initWithUsername:1 locationWithID:@"Jolly"];
}

- (void)tearDown {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        [super tearDown];
}

- (void)testBumpUserIdValue {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        expect(bump.facebook_id).to.equal(1);
}

- (void)testBumpGooglePlacesIdValue {
        expect(bump.googlePlacesID).to.equal(@"Jolly");
}

-(void)testPostBump{
    [bump saveInBackgroundWithCompletionBlock:^(BOOL success){
        expect(success).to.equal(true);
    }];
}

/*- (void)testBumpDateValue{
        expect(bump.date).to.equal([NSDate class]);
}*/


@end
