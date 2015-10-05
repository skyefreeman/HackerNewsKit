//
//  HNItemTests.m
//  HackerNewsKit
//
//  Created by Skye on 10/5/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HNItem.h"

@interface HNItemTests : XCTestCase
@end

@implementation HNItemTests
{
    HNItem *item;
}

- (void)setUp {
    [super setUp];
    
    item = [[HNItem alloc] initWithID:@"123"];
}

- (void)tearDown {
    item = nil;
    
    [super tearDown];
}

- (void)testItemExists {
    XCTAssertNotNil(item, @"Should be able to create a HNItem instance");
}

- (void)testDefaultInitFails {
    HNItem *testItem = [[HNItem alloc] init];
    XCTAssertNil(testItem, @"HNItem needs to be initialized with initWithID");
}

- (void)testItemHasAnIDProperty {
    XCTAssertEqual(item.ID, @"123",@"An HNItem needs to have an ID");
}

@end
