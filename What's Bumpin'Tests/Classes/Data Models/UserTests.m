//
//  UserTests.m
//  WhatsBumpin
//
//  Created by Elle Zadina on 4/26/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "User.h"
#import <Expecta/Expecta.h>
@import GooglePlaces;


@interface UserTests : XCTestCase

@end

@implementation UserTests
User *user;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    [User loginWithID:1355547881173475 name:@"Alex Lucas"];
    user = [User getCurrentUser];
}

-(void)testUserID{
    expect(user.facebookID).to.equal(1355547881173475);
}

-(void)testUserName{
    expect(user.name).to.equal(@"Alex Lucas");
}

-(void)testSetLocation{
    [user setLocation:CLLocationCoordinate2DMake(41.5043, 81.6084)];
    expect(user.coordinates.latitude).to.equal(41.502);
    expect(user.coordinates.longitude).to.equal(-81.607);
}

/*- (void)testSetBio{
    [user setBio:@"An avid iOS developer"];
    expect(user.bio).to.equal(@"An avid iOS developer");
}*/

- (void)testIsLoggedIn{
    expect(user.isLoggedIn).to.equal(true);
}

- (void)testLogout{
    [user logout];
    expect(user.isLoggedIn).to.equal(true);
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
