//
//  MessageTests.m
//  WhatsBumpin
//
//  Created by Elle Zadina on 4/26/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Message.h"
#import <Expecta/Expecta.h>

@interface MessageTests : XCTestCase

@end

@implementation MessageTests
Message *testMessage;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    testMessage = [[Message alloc] initWithUserID:10 locationID:@"Jolly" andMessage:@"Karaoke at Jolly is fantastic!"];
}

- (void)testMessageUserIdValue {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        expect(testMessage.facebook_id).to.equal(10);
}

- (void)testMessageGooglePlacesIdValue {
        expect(testMessage.googlePlacesID).to.equal(@"Jolly");
}

- (void)testMessagePayload{
    expect(testMessage.message_text).to.equal(@"Karaoke at Jolly is fantastic!");
}

-(void)testPostMessage{
    [testMessage saveInBackgroundWithCompletionBlock:^(BOOL success){
        expect(success).to.equal(true);
    }];
    
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
