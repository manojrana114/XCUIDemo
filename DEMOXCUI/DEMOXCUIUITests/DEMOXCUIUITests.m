//
//  DEMOXCUIUITests.m
//  DEMOXCUIUITests
//
//  Created by Manoj Pratap on 20/04/16.
//  Copyright © 2016 impetus. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface DEMOXCUIUITests : XCTestCase

@end

@implementation DEMOXCUIUITests

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
    XCUIElementQuery *tablesQuery = app.tables;

    XCTAssertEqual(app.tables.cells.count, 2);
    //Tap add
    [app.navigationBars[@"Search"].buttons[@"Add"] tap];
    XCTAssertEqual(app.tables.cells.count, 3);   //Tap add

    [tablesQuery.staticTexts[@"colour 3"] swipeLeft];
    [tablesQuery.buttons[@"Delete"] tap];
    XCTAssertEqual(app.tables.cells.count, 2);

    
}

@end
