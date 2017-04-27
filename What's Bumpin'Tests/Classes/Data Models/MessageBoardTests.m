//
//  MessageBoardTests.m
//  WhatsBumpin
//
//  Created by Elle Zadina on 4/27/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "User.h"
#import <Expecta/Expecta.h>
@import GooglePlaces;
#import "MessageBoard.h"



@interface MessageBoardTests : XCTestCase

@end

@implementation MessageBoardTests
MessageBoard *messageBoard;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    messageBoard = [[MessageBoard alloc] init];
    [User loginWithID:1355547881173475 name:@"Alex Lucas"];
    [User getCurrentUser].friends = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithLong:1465572083455463], [NSNumber numberWithLong:1299006730155247], nil];
    
}

/*-(void)testLoadMessagesFromFriends{
    [messageBoard loadMessagesFromFriends:[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithLong:1465572083455463], [NSNumber numberWithLong:1299006730155247], nil] withCompletion:^(NSMutableArray* response){
        //request is made without error thrown
        expect(true).to.equal(true);
    }];
}*/

-(void)testLoadMessagesForLocation{
    [messageBoard loadMessagesForLocation:@"ChIJNwaBOon7MIgRwyDK9r7VCnE" withCompletion:^(NSMutableArray* response){
        expect(response).notTo.equal(NULL);
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
