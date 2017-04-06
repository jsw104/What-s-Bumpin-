//
//  FacebookLoginUITest.m
//  WhatsBumpin
//
//  Created by Alex Lucas on 3/31/17.
//  Copyright © 2017 Bump Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface FacebookLoginUITest : XCTestCase

@end

@implementation FacebookLoginUITest

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
//    [app.alerts[@"Allow \u201cWhatsBumpin\u201d to access your location while you use the app?"].buttons[@"Allow"] tap];
    [[[app.tabBars childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:1] tap];
    [app.buttons[@"Continue with Facebook"] tap];
    [app.buttons[@"OK"] tap];
    [[[[app.navigationBars[@"FBLoginView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
    
    
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    
}

@end
